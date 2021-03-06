USE [DBMonitor]
GO
/****** Object:  StoredProcedure [dbo].[DATABASE_SPACE_CONTROL]    Script Date: 11/06/2014 15:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************CREATE THE TABLE *****************************/

--use dbmonitor create table DBSC_'servername' (DB varchar(50),GrowDate datetime)
--09/14/09
/********************CREATE THE PROCEDURE**************************/
--Change the DB at the end

CREATE PROCEDURE [dbo].[DATABASE_SPACE_CONTROL] AS 

/***************************************************************************************/
/*This script was created by Oscar Gonzalez to FLEXTRONICS in order to fix the problem */
/*that SQL 7.0 has about the autogrow function.                                        */
/***************************************************************************************/

/***************************************************************************************/
/*This script should be scheduled to run at desired intervals for detecting Database   */
/*space growth before it becomes full.                                                 */
/*Datafile desired increment(MB) & desired space left(MB) on database to start growing */
/*start growing must be specified in this script.                                      */
/***************************************************************************************/

DECLARE @logical_name varchar (255)
DECLARE @physical_name varchar (255)
DECLARE @db_size int
DECLARE @max_size varchar (255)
DECLARE @growth_allowed int
DECLARE @usage varchar (255)
DECLARE @drive_growth varchar (1)
DECLARE @logical_name_growth varchar (255)
DECLARE @space_on_drive int
DECLARE @possible_increment int
DECLARE @space_left_to_grow int
DECLARE @total int
DECLARE @total_size int
DECLARE @used int
DECLARE @sumtotal int
DECLARE @sumused int
DECLARE @@unallocated int
DECLARE @file_total_size int
DECLARE @@increment varChar(10)
DECLARE @@COMND  char(255)
DECLARE @db_name varchar(255)
DECLARE @desired_increment int
DECLARE @rev_logical_name varchar (255)
DECLARE @rev_db_size int
DECLARE @to as varchar (255)
DECLARE @message_if_not_grow as varchar (255)
DECLARE @subject_if_not_grow as varchar (255)
DECLARE @message_if_increment_succed as varchar (255)
DECLARE @subject_if_increment_succed as varchar (255)
DECLARE @message_if_not_allowed_to_grow as varchar (255)
DECLARE @subject_if_not_allowed_to_grow as varchar (255)
DECLARE @reserved_space int
DECLARE @sendtrap varchar(256)


/***************************************************************************************/
/**        IMPORTANT VALUES         IMPORTANT VALUES          IMPORTANT VALUES        **/
/**        IMPORTANT VALUES         IMPORTANT VALUES          IMPORTANT VALUES        **/
/*               Use this section to modify these values as needed                     */
/***************************************************************************************/

Select @sendtrap = 'FAILED DBSPACECONTROL IN ' + db_name() 
Select @space_left_to_grow = 50   --Space left (MB) in database that cause it to grow
Select @desired_increment =  50    --Increment (MB) for growing desired datafile
Select @reserved_space = 2000     --Max space left on disk allowed - Space reserved on disk
                             --20 % Total Disk Space RECOMMENDED

select @to = '<notify DL>'  --Recipient for any notification
-- Messages if a problem occur when growing
select @message_if_not_grow = @@servername+' '+ db_name() +'DB found some problems when was trying to grow.'
select @subject_if_not_grow = 'Database '+ db_name() +' on '+@@servername+' space control'
-- Messages if growth succeded
select @message_if_increment_succed = @@servername+' '+ db_name() +' DB has succesfully increased its size.'
select @subject_if_increment_succed = 'Database '+ db_name() +' on '+@@servername+' space control'
-- Messages if not enough space on disk or datafile not enable to grow
select @message_if_not_allowed_to_grow = @@servername+' '+ db_name() +'  DB was not able to grow. There is not enougth space on disk or datafiles are not enable for auto-grow.'
select @subject_if_not_allowed_to_grow = 'Database '+ db_name() +' on '+@@servername+' space control'

/***************************************************************************************/
/**        IMPORTANT VALUES         IMPORTANT VALUES          IMPORTANT VALUES        **/
/***************************************************************************************/

/* Get total unallocated space for each datafile to get full unallocated space of the  */
/* database.   DBCC SHOWFILESTATS is used.                                             */

select @db_name = db_name()

SET NOCOUNT ON
CREATE TABLE #A(Fileid int NULL, 
            FileGroup int NULL, 
            TotalExtents int NULL, 
            UsedExtents int NULL, 
            Name varchar(255), 
            FileName varchar(255))
INSERT #A(Fileid, FileGroup, TotalExtents, UsedExtents, Name, FileName)
EXEC('DBCC SHOWFILESTATS WITH TABLERESULTS')

DECLARE used_space cursor for
SELECT TotalExtents, UsedExtents FROM #A
      Select @sumtotal=0
      Select @sumused=0
open used_space
fetch used_space into @total, @used
while (@@fetch_status =  0)
      begin
            Select @sumtotal = @sumtotal + @total
            select @sumused = @sumused + @used
            FETCH NEXT FROM used_space INTO @total, @used
      end
close used_space
deallocate used_space

select @@unallocated = (@sumtotal - @sumused)* 64 /1024


/* Once we know the total space left in the database we decide if it needs to grow      */
if @@unallocated <= @space_left_to_grow
Begin
      /* Get datafiles data from sysfiles to know which datafiles are using for data  */
      /* and to discard datafiles used for logs.                                      */
      set nocount on
      DECLARE get_datafiles SCROLL cursor for
      SELECT      name,
            filename,
            'size' =  size * 8,   --Size in KB
            'growth' = (case status & 0x100000 when 0x100000 then growth else growth * 8 end),
            'usage' = (case status & 0x40 when 0x40 then 'log only' else 'data only' end)
            from sysfiles where growth <> 0
            order by fileid

      open get_datafiles
      fetch LAST FROM get_datafiles into @logical_name, @physical_name, @db_size,  @growth_allowed, @usage
      while (@@fetch_status =  0)
      begin
            /* Check if last datafile could be used to grow, if not then gets previous and check it until */
            /* one can be used to grow. If anyone is possible to grow then send a mail to notify.         */
            if @usage = 'data only' and @growth_allowed <> 0
                  Begin
                        Select @drive_growth =  UPPER(SUBSTRING(@physical_name, 1, 1))
                        Select @logical_name_growth = @logical_name

                        /* Get space left on hard disk where datafile resides */
                        SET NOCOUNT ON
                        CREATE TABLE #C( drive varchar(255), free int NULL)
                        INSERT #C(drive, free)
                        EXEC('master..xp_fixeddrives')

                        DECLARE check_space cursor for
                              select free from #C where drive = @drive_growth
                        open check_space
                        fetch check_space into @space_on_drive
                        close check_space
                        deallocate check_space

                        /* Check total size of the datafile to calculate the final datafile size */
                        DECLARE datafile_space cursor for
                        SELECT TotalExtents FROM #A where Name = @logical_name_growth
                              Select @file_total_size = 0
                        open datafile_space
                        fetch datafile_space into @total_size
                        while (@@fetch_status =  0)
                              begin
                                    Select @file_total_size = @total_size
                                    FETCH NEXT FROM datafile_space INTO @total_size
                              end
                        close datafile_space
                        deallocate datafile_space
                        select @file_total_size =  @file_total_size * 64 /1024  

                        /* At this point we can calculate the final datafile size */
                        select @@increment = convert (varchar, ( @file_total_size  + @desired_increment ))

                        /* Check if there is enough space on disk for the increment */
                        /* If there is not free space on this drive then get next datafile available */
                        /* If there is space on drive it gets out of cycle */
                        IF @space_on_drive - @reserved_space < @desired_increment
                            Begin
                              Select @possible_increment = 0
                              DROP TABLE #C
                              FETCH PRIOR FROM get_datafiles INTO @logical_name, @physical_name, @db_size,@growth_allowed, @usage
                            End
                        ELSE
                            Begin
                              Select @possible_increment = 1
                              DROP TABLE #C
                              BREAK --Exit while
                            End
                    end
            ELSE           Select @possible_increment = 0
               FETCH PRIOR FROM get_datafiles INTO @logical_name, @physical_name, @db_size,  @growth_allowed, @usage
      end
      close get_datafiles
      deallocate get_datafiles


      IF @possible_increment <> 1
         /* Actions in case any datafile could not grow */
         Begin
            DROP TABLE #A
            Exec dbmonitor..SEND_ALARM 'SQL_ASIA','1',@sendtrap
            ----EXEC master..xp_sendmail @recipients = @to,
            ----@message = @message_if_not_allowed_to_grow,
            ----@subject = @subject_if_not_allowed_to_grow 
         End
      ELSE
         /* In case datafile could grow the sentence to grow the database is formed and executed */
         Begin
            select @@COMND = 'USE master  ALTER DATABASE ' + @db_name +
                        ' MODIFY FILE (NAME = ' + @logical_name_growth +
                        ', SIZE = ' + @@increment + ' )'
            DROP TABLE #A
            select @@COMND
            EXEC (@@COMND)

            /* Final revision to see if datafile was increased */
            set nocount on
            DECLARE Revision cursor for
            SELECT      name, 'size' =  size * 8 / 1024   --Size in Mb
                  from sysfiles where name = @logical_name_growth

            open Revision
            fetch FROM Revision into @rev_logical_name, @rev_db_size

            IF @rev_db_size <> @@increment 
                  Begin 
                          Exec dbmonitor..SEND_ALARM 'SQL_ASIA','1',@sendtrap
                     --EXEC master..xp_sendmail @recipients = @to,
                     --@message = @message_if_not_grow,
                     --@subject = @subject_if_not_grow
                  End
            Else
                  Begin
                     insert into dbmonitor..DBSC_HKGNT111  values(db_name(),getdate())
                     --EXEC master..xp_sendmail @recipients = @to,
                     --@message = @message_if_increment_succed ,
                     --@subject = @subject_if_increment_succed
                  End

            close Revision
            deallocate Revision
         End
End
ELSE DROP TABLE #A
GO

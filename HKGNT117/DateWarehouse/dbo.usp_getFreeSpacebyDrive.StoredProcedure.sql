USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[usp_getFreeSpacebyDrive]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*=============================================================================

Check Disk Free space
Create at 2010/04/02
Create By Rivern Li

=============================================================================*/
/*======================= Projram Start =====================================*/
CREATE proc [dbo].[usp_getFreeSpacebyDrive]
	@drive		char(8),		-----drive
	@AlterVerge numeric(10,2),	----Server will send Email to Some People When drive free space smaller than this Parameter   GB
	@IsAlter	int output		-----0 No Alter ; 1 Alter
as

declare @FreeSpace numeric(10,2)
set @FreeSpace=0
set @IsAlter=0

create table #temp (ID int identity(1,1),drive char(8), MBFREE int)

insert into #temp(drive,MBFREE)

exec xp_fixeddrives 
set @FreeSpace =(select 
     CONVERT(NUMERIC(10,2),CONVERT(NUMERIC(10,2),MBFREE)/1024.00)
     from #temp
     where drive=@drive)

IF(@FreeSpace IS NULL)
 begin
   select 'Not Find This Driver!'    
   return 
 end     

if(@FreeSpace<=@AlterVerge)
 begin 
  set @IsAlter=1
 end

SELECT drive , CONVERT(VARCHAR(50),CONVERT(NUMERIC(10,2),CONVERT(NUMERIC(10,2),MBFREE)/1024.00))+' G' AS 'GFREE'
FROM #temp 
where drive=@drive

/*======================= Projram End ========================================*/
GO

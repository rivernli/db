USE [multekchi_realtime]
GO
/****** Object:  StoredProcedure [dbo].[ftp]    Script Date: 2014/11/12 17:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ftp]
-- Purpose: Execute an FTP script 
-- Original Author:  Andrew Zanevsky, 21st Sentry, Inc.
-- Website: http://www.pinnaclepublishing.com/SQ/SQmag.nsf/0/0BE771908BB82C4C852568E2006B0F73
-- Modified by: Pokit Lok (System Analyst, Multek HK)
-- Version: 3
-- Date: 2002/12/09
-- Modification in Version 3
-- 1. Allow to change ftp script table 

	@ftp_para   varchar(30) = ' ',
	@ftp_server varchar(255) = ' ',
	@script_table sysname = 'ftp_script' 

as
set nocount on
declare @line     varchar(255), 
        @cmd      varchar(255), 
        @pipe     varchar(2), 
        @ftp_file varchar(255)
select  @pipe = '>', 
        @ftp_file = 'c:\~~ftp_temp_' + 
            convert( varchar, @@spid ) + '.ftp'


create table #script ( 
        line varchar(255) not null )
exec( 'insert #script select script_line ' + 
      ' from ' + @script_table + ' order by stID ')

declare script cursor 
for select line from #script

-- declare script cursor 
-- for select script_line from ftp_script

open script 
fetch script into @line
while @@fetch_status = 0 begin
	set @cmd = 'echo ' + @line + @pipe + @ftp_file
	exec master..xp_cmdshell @cmd
	fetch script into @line
	set @pipe = '>>'
end

close script
deallocate script

set @cmd = 'ftp ' + @ftp_para + ' -s:' + @ftp_file + ' ' + @ftp_server
select @cmd
exec master..xp_cmdshell @cmd

set @cmd = 'del ' + @ftp_file
select @cmd
exec master..xp_cmdshell @cmd
GO

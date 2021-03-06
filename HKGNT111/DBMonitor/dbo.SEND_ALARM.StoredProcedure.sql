USE [DBMonitor]
GO
/****** Object:  StoredProcedure [dbo].[SEND_ALARM]    Script Date: 11/06/2014 15:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SEND_ALARM] (@group varchar(30),@Serv Varchar(1), @msg varchar(100)=' ')
AS
BEGIN
-- This stored procedure Sends alarms by NSCA, prior running it, server must be
-- configured.
-- set @severity = '1' --1. Warning, 2. Critical, 3.OK, 4.Unknown
declare @command varchar(100), 
@name varchar(50),
@severity varchar(1)

set @severity= @Serv
set @group=upper(@group)

--set @msg='"' + upper(convert(varchar(30),serverproperty('servername'))) + '  Message to be sent"' -- Close in "" the message
set @msg='"' + upper(@msg)+ '"' -- Close in "" the message
set @name = upper(convert(varchar(30),serverproperty('machinename')))
set @command='c:\flexsense\NSCA\nsca.bat '+ @name + ' '+ @group + ' ' + @severity + ' ' + @msg
exec master..xp_cmdshell  @command
SELECT @command

END
GO

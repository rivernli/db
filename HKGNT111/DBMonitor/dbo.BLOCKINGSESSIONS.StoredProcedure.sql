USE [DBMonitor]
GO
/****** Object:  StoredProcedure [dbo].[BLOCKINGSESSIONS]    Script Date: 11/06/2014 15:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BLOCKINGSESSIONS] AS      
      
declare @bloqueador varchar(10)  --The blocking session      
declare @sesion varchar(10)   --The session ID      
declare @statement varchar(max)  --The statement executing at the moment      
declare @statement2 varchar(max)  --The statement executing at the moment without qoutes      
declare @insert nvarchar(max)   --The query for the insert statement      
declare @comando varchar(512)  --The command executing at the moment      
declare @DB sysname      
declare @Host varchar(20)      
declare @BSPID int, @comandblocked varchar(2048), @Hostblocked varchar(20)      
      
/**** cursor to get the blocking sessions******/      
declare cur_bloqueador scroll cursor for      
 select blkby,dbname,hostname, spid, hostname from who      
 where blkby <> '  . '      
 and blkby != spid --don't send alarm if SPID is blocked by itself      
declare cur_statement scroll cursor for       
 select Eventinfo from querytemp      
      
/**** inserts the current session to handle  ****/      
insert into who exec sp_who2      
/****   Obtain the blocking session    ****/      
open cur_bloqueador       
fetch next from cur_bloqueador into @bloqueador,@DB,@Host, @BSPID, @Hostblocked      
      
while @@fetch_status  = 0        
begin      
 --select 'El bloqueador es : ' + @bloqueador      
 insert into querytemp  exec('DBCC INPUTBUFFER (' + @bloqueador +') ')      
-- insert into querytemp1 exec('DBCC INPUTBUFFER (' + @BSPID +') WITH TABLERESULTS')      
 fetch next from cur_bloqueador into @bloqueador,@DB,@Host, @BSPID, @Hostblocked      
end      
/**** We get locked session*******/      
CREATE TABLE #bloqueado (      
  [id] [int] IDENTITY (1, 1) NOT NULL ,      
  [EventType] [varchar] (100) COLLATE SQL_Latin1_General_CP850_BIN NULL ,      
  [Parameters] [int] NULL ,      
  [Eventinfo] [text] COLLATE SQL_Latin1_General_CP850_BIN NULL       
 )       
      
open cur_statement      
fetch next from cur_statement into @statement      
fetch first from cur_bloqueador into @bloqueador,@DB,@Host, @BSPID, @Hostblocked      
while @@fetch_status  = 0       
begin      
 select @statement2 = replace(@statement,'''',' ' )      
 select @Host=rtrim(hostname) from master..sysprocesses where spid=@bloqueador      
 select @Hostblocked=rtrim(hostname) from master..sysprocesses where spid=@BSPID      
      
 insert into #bloqueado exec ('DBCC INPUTBUFFER (' + @BSPID + ') ')-- into #bloqueado      
 select top 1 @comandblocked= eventinfo from #bloqueado      
 set @comandblocked= replace(@comandblocked, '''',' ' )      
 select @insert = 'insert into query1 values('+ @bloqueador + ',''' + @db + ''', '''+@statement2+''', ''[' +@Host+']'', ''' + @comandblocked + ''',''[' + @Hostblocked + ']'')'       
 select @insert       
 delete from #bloqueado      
select * from query2      
 exec sp_executesql @insert      
 fetch next from cur_bloqueador into @bloqueador,@DB,@Host, @BSPID, @Hostblocked      
 fetch next from cur_statement into @statement      
end      
drop table #bloqueado      
/********************    Check if NO LOCKS  *******************************/      
if (select count(*) from query1 a,query2 b where  b.sesion = a.sesion and a.Eventinfo = b.Eventinfo) >= 1       
 begin 
	set @comando = 'BLOCKED OBJECTS ON ' + @DB 
	Exec dbmonitor..SEND_ALARM 'SQL_ASIA','1',@comando 
  ---print @comando      
  ---exec master..xp_cmdshell  @comando      
  --select * from query2       
  insert into history (session,dbname,eventinfo,hostname, blocked, Hostblocked) select * from query2  -- Capturar el query       
  update history set time = getdate() where time is null -- Actualiza la hora del bloqueo      
 end      
/*****   Close and Delete all existing cursors   ***********/      
close cur_bloqueador      
close cur_statement      
deallocate cur_bloqueador      
deallocate cur_statement      
delete from who      
delete from querytemp      
--drop table query2      
--select * into query2 from query1      
truncate table query2      
insert into query2 select * from query1      
delete from query1
GO

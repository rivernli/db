USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcDBRestore]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 23:16
-- Description:	还原数据库
-- =============================================
CREATE PROCEDURE [dbo].[ProcDBRestore]
--@dbname nvarchar(50),
--@bakurl nvarchar(100)

@bkfile nvarchar(1000),--定义要恢复的备份文件名(带路径)
@dbname sysname='', --定义恢复后的数据库名,默认为备份的文件名
@dbpath nvarchar(260)='',--恢复后的数据库存放目录,不指定则为SQL的默认数据目录
@retype nvarchar(10)='DB',--恢复类型:'DB'完事恢复数据库,'DBNOR' 为差异恢复,日志恢复进行完整恢复,'DF' 差异备份的恢复,'LOG' 日志恢复
@filenumber int=1,--恢复的文件号
@overexist bit=1, --是否覆盖已经存在的数据库,仅@retype为'DB'/'DBNOR'是有效
@killuser bit=1, --是否关闭用户使用进程,仅@overexist=1时有效
@password nvarchar(20)=''--备份文件的密码(仅sql2000支持),如果备份时设置了密码,必须提供此密码

AS
BEGIN
    --backup log @dbname to disk= @bakurl restore database @dbname from disk= @bakurl
    --select @@rowcount 
    declare @sql varchar(8000)

--得到恢复后的数据库名
if isnull(@dbname,'')=''
select @sql=reverse(@bkfile)
,@sql=case when charindex('.',@sql)=0 then @sql
else substring(@sql,charindex('.',@sql)+1,1000) end
,@sql=case when charindex('\',@sql)=0 then @sql
else left(@sql,charindex('\',@sql)-1) end
,@dbname=reverse(@sql)

--得到恢复后的数据库存放目录
if isnull(@dbpath,'')=''
begin
select @dbpath=rtrim(reverse(filename)) from master..sysfiles where name='master'
select @dbpath=reverse(substring(@dbpath,charindex('\',@dbpath),4000))
end

--生成数据库恢复语句
set @sql='restore '+case @retype when 'LOG' then 'log ' else 'database ' end+@dbname
+' from disk='''+@bkfile+''''
+' with file='+cast(@filenumber as varchar)
+case when @overexist=1 and @retype in('DB','DBNOR') then ',replace' else '' end
+case @retype when 'DBNOR' then ',NORECOVERY' else ',RECOVERY' end
+case isnull(@password,'') when '' then '' else ',PASSWORD='''+@password+'''' end

--添加移动逻辑文件的处理
if @retype='DB' or @retype='DBNOR'
begin
--从备份文件中获取逻辑文件名
declare @lfn nvarchar(128),@tp char(1),@i int,@s varchar(1000)

--创建临时表,保存获取的信息
create table #tb(ln nvarchar(128),pn nvarchar(260),tp char(1),fgn nvarchar(128),sz numeric(20,0),Msz numeric(20,0))
--从备份文件中获取信息
set @s='restore filelistonly from disk='''+@bkfile+''''
++case isnull(@password,'') when '' then '' else ' with PASSWORD='''+@password+'''' end
insert into #tb exec(@s)
declare #f cursor for select ln,tp from #tb
open #f
fetch next from #f into @lfn,@tp
set @i=0
while @@fetch_status=0
begin
select @sql=@sql+',move '''+@lfn+''' to '''+@dbpath+@dbname+cast(@i as varchar)
+case @tp when 'D' then '.mdf''' else '.ldf''' end
,@i=@i+1
fetch next from #f into @lfn,@tp
end
close #f
deallocate #f
end

--关闭用户进程处理
if @overexist=1 and @killuser=1
begin
declare hCForEach cursor for
select s='kill '+cast(spid as varchar) from master..sysprocesses 
where dbid=db_id(@dbname)
exec sp_msforeach_worker '?'
end

--恢复数据库
exec(@sql)


END

GO

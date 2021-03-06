USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[sp_GenInsert]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*==============================================================================

以northwind 数据库为例
sp_GenInsert 'Employees', 'INS_Employees'
注释：如果您在Master系统数据库中创建该过程，那您就可以在您服务器上所有的数据库

===============================================================================*/
CREATE procedure [dbo].[sp_GenInsert] 
	@TableName varchar(130), 
	@ProcedureName varchar(130) 
as 

set nocount on 

declare @maxcol int, @TableID int 
--itlearner.comset @TableID = object_id(@TableName) 

set @TableID = object_id(@TableName)

select @MaxCol = max(colorder) from syscolumns where id = @TableID 

select 'Create Procedure ' + rtrim(@ProcedureName) as type,0 as colorder into #TempProc 

union 
select convert(char(35),'@' + syscolumns.name) + 
rtrim(systypes.name) + 
	case 
	when rtrim(systypes.name) in ('binary','char','nchar','nvarchar','varbinary','varchar') then '(' + rtrim(convert(char(4),syscolumns.length)) + ')' 
	when rtrim(systypes.name) not in ('binary','char','nchar','nvarchar','varbinary','varchar') then ' ' end + 
	case 
	when colorder < @maxcol then ',' 
	when colorder = @maxcol then ' ' 
	end as type, 
colorder from syscolumns join systypes on syscolumns.xtype = systypes.xtype 
where id = @TableID and systypes.name <> 'sysname' 

union 
select 'AS',@maxcol + 1 as colorder 

union 
select 'INSERT INTO ' + @TableName,@maxcol + 2 as colorder 

union 
select '(',@maxcol + 3 as colorder 

union 
select syscolumns.name + 
case 
	when colorder < @maxcol then ',' 
	when colorder = @maxcol then ' ' 
end as type, 
colorder + @maxcol + 3 as colorder 
from syscolumns join systypes on syscolumns.xtype = systypes.xtype 
where id = @TableID and systypes.name <> 'sysname' 

union 
select ')',(2 * @maxcol) + 4 as colorder 

union 
select 'VALUES',(2 * @maxcol) + 5 as colorder 

union 
select '(',(2 * @maxcol) + 6 as colorder 

union 
select '@' + syscolumns.name + 
case 
when colorder < @maxcol then ',' 
when colorder = @maxcol then ' ' 
end as type, colorder + (2 * @maxcol + 6) as colorder 
from syscolumns join systypes on syscolumns.xtype = systypes.xtype 
where id = @TableID and systypes.name <> 'sysname' 

union 

select ')',(3 * @maxcol) + 7 as colorder order by colorder 

select type from #tempproc order by colorder 
drop table #tempproc





--
--SQL Server编写存储过程小工具 功能：为给定表创建Update存储过程 语法： sp_GenUpdate <Table Name>,<Primary Key>,<Stored Procedure Name> 以northwind 数据库为例 sp_GenUpdate 'Employees','EmployeeID','UPD_Employees' 
--注释：如果您在Master系统数据库中创建该过程，那您就可以在您服务器上所有的数据库中使用该过程。 
--===========================================================*/ CREATE procedure sp_GenUpdate @TableName varchar(130), @PrimaryKey varchar(130), @ProcedureName varchar(130) as set nocount on 
--declare @maxcol int, @TableID int --itlearner.comset @TableID = object_id(@TableName) 
--select @MaxCol = max(colorder) from syscolumns where id = @TableID 
--select 'Create Procedure ' + rtrim(@ProcedureName) as type,0 as colorder into #TempProc union select convert(char(35),'@' + syscolumns.name) + rtrim(systypes.name) + case when rtrim(systypes.name) in ('binary','char','nchar','nvarchar','varbinary','varchar') then '(' + rtrim(convert(char(4),syscolumns.length)) + ')' when rtrim(systypes.name) not in ('binary','char','nchar','nvarchar','varbinary','varchar') then ' ' end + case when colorder < @maxcol then ',' when colorder = @maxcol then ' ' end as type, colorder from syscolumns join systypes on syscolumns.xtype = systypes.xtype where id = @TableID and systypes.name <> 'sysname' union select 'AS',@maxcol + 1 as colorder union select 'UPDATE ' + @TableName,@maxcol + 2 as colorder union select 'SET',@maxcol + 3 as colorder union select syscolumns.name + ' = @' + syscolumns.name + case when colorder < @maxcol then ',' when colorder = @maxcol then ' ' end as type, colorder + @maxcol + 3 as colorder from syscolumns join systypes on syscolumns.xtype = systypes.xtype where id = @TableID and syscolumns.name <> @PrimaryKey and systypes.name <> 'sysname' union select 'WHERE ' + @PrimaryKey + ' = @' + @PrimaryKey,(2 * @maxcol) + 4 as colorder order by colorder 
--select type from #tempproc order by colorder 
--drop table #tempproc /*＝＝＝＝＝＝＝源程序结束＝＝＝＝＝＝＝＝＝*/
GO

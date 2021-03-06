USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFilesGetSetByOidByTopBySort]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-10-28 10:45
-- Description:	获取指字分类的文件列表(分页，指定开头行编号和条数的文件列表)
-- =============================================
CREATE PROCEDURE [dbo].[ProcFilesGetSetByOidByTopBySort]
@oid int,
@topid int,
@top int,
@Sort nvarchar (1000)='[Id] desc' 

AS
BEGIN
	
	declare @sqlString nvarchar(4000)
	
	set @sqlString = N'SELECT  top ('+convert(nvarchar(50),@top)+') [Id], [oid], [parentId], [Type], [Name], [Modified], [ModifiedBy], [Url], [user]  
                     FROM  FilesTable  where oid='+convert(nvarchar(50),@oid)+' AND id<=
                     (select min( id) from  (select  Top('+convert(nvarchar(50),@topid)+')  id   from   FilesTable where oid='+convert(nvarchar(50),@oid)+' order by '+ @Sort+')   as   tblTmp) '
                     +' order by '+ @Sort; 
	exec(@sqlString) 
END

GO

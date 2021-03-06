USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPhotoGetSetByNid]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 11:28
-- Description:	获取指定相册编号的图片(分页，指定开头行编号和条数的照片列表)
-- =============================================
CREATE PROCEDURE [dbo].[ProcPhotoGetSetByNid]
@nid int,
@topid int,
@top int,
@Sort nvarchar (1000)='id desc' 

AS
BEGIN
	declare @sqlString nvarchar(4000)
	
	set @sqlString = N'SELECT  top ('+convert(nvarchar(50),@top)+') id, nid, Title, [Description], LargeImg, SmartImg
                     FROM  PhotoTable  where nid='+convert(nvarchar(50),@nid)+' AND id<=
                     (select min( id) from  (select  Top('+convert(nvarchar(50),@topid)+')  id   from   PhotoTable where nid='+convert(nvarchar(50),@nid)+' order by '+ @Sort+')   as   tblTmp) '
                     +' order by '+ @Sort; 
	exec(@sqlString) 
END

GO

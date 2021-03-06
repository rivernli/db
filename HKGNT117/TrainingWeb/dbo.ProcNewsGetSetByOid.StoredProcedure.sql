USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsGetSetByOid]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 11:58
-- Description:	分页，获取指字分类编号，开头行编号和条数的新闻列表
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsGetSetByOid]
@oid int,
@topid int,
@top int,
@Sort nvarchar (1000)='bid desc' 

AS
BEGIN
	declare @sqlString nvarchar(4000)  

	set @sqlString = N'SELECT  top ('+convert(nvarchar(50),@top)+') id, ClassId, img, title, htmls, htmlurl, bid, flag, [from], [user], purview, click, pub_date
                     FROM  NewsTable  where classid='+convert(nvarchar(50),@oid)+' AND bid<
                     (select min( bid) from  (select  Top('+convert(nvarchar(50),@topid)+')  bid   from   NewsTable where classid='+convert(nvarchar(50),@oid)+' order by '+ @Sort+')   as   tblTmp) '
                     +' order by '+ @Sort; 
	exec(@sqlString) 
	
	
END

GO

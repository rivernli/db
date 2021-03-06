USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsGetSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 12:35
-- Description:	分页，获取指字开头行编号和条数的新闻列表
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsGetSet]
@topid int,
@top int

AS
BEGIN
	SELECT  top (@top) id, ClassId, img, title, htmls, htmlurl, bid, flag, [from], [user], purview, click, pub_date
FROM     NewsTable where bid<
(select min( bid) from  (select  Top(@topid)  bid   from   NewsTable  order by bid desc)   as   tblTmp)  
order by bid desc  
	
END

GO

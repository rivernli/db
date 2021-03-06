USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsGetByOid]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 11:28
-- Description:	获取指定分类编号的新闻列表
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsGetByOid]
@oid int
AS
BEGIN
	SELECT   id, ClassId, img, title, htmls, htmlurl, bid, flag, [from], [user], purview, click, pub_date
    FROM      NewsTable WHERE classid=@oid order by bid desc
    
END

GO

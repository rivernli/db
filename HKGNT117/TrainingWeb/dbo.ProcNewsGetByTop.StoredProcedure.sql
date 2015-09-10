USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsGetByTop]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 11:58
-- Description:	获取指定条数的新闻列表
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsGetByTop]
@top int
AS
BEGIN
	SELECT  top (@top) id, ClassId, img, title, htmls, htmlurl, bid, flag, [from], [user], purview, click, pub_date
FROM         NewsTable  order by bid desc
	
END

GO

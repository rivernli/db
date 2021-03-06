USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPhotoGetByNid]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 11:28
-- Description:	获取指定相册编号的图片
-- =============================================
CREATE PROCEDURE [dbo].[ProcPhotoGetByNid]
@nid int
AS
BEGIN
	SELECT     id, nid, Title, [Description], LargeImg, SmartImg
	FROM         PhotoTable
	WHERE     (nid = @nid) order by id desc
END

GO

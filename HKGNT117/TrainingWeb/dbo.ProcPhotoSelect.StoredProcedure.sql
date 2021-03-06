USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPhotoSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 12:28
-- Description:	获取指定编号的图片
-- =============================================
create PROCEDURE [dbo].[ProcPhotoSelect]
@id int
AS
BEGIN
	SELECT     id, nid, Title, [Description], LargeImg, SmartImg
	FROM         PhotoTable
	WHERE     (id = @id) order by id desc
END

GO

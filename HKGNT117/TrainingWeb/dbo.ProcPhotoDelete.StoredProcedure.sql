USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPhotoDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 9:52
-- Description:	删除照片
-- =============================================
create PROCEDURE [dbo].[ProcPhotoDelete]
@id int

AS
BEGIN
	Delete PhotoTable where id=@id
	select @@rowcount
END

GO

USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFilesDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-6-27 10:50
-- Description:	删除下载文件
-- =============================================
CREATE PROCEDURE [dbo].[ProcFilesDelete]
@id int
AS
BEGIN
	Delete FilesTable where id=@id
	select @@rowcount
END

GO

USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFilesSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-15 10:35
-- Description:	获取指定编号下载文件
-- =============================================
create PROCEDURE [dbo].[ProcFilesSelect]
@Id int
AS
BEGIN
	SELECT     [Id], [oid], [parentId], [Type], [Name], [Modified], [ModifiedBy], [Url], [user]  
	FROM FilesTable 
	WHERE  [Id]=@Id
END

GO

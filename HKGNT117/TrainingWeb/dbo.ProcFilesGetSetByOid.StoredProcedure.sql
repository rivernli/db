USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFilesGetSetByOid]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-6-27 10:45
-- Description:	获取指字分类的下载文件列表
-- =============================================
CREATE PROCEDURE [dbo].[ProcFilesGetSetByOid]
@oid int

AS
BEGIN
	SELECT     [Id], [oid], [parentId], [Type], [Name], [Modified], [ModifiedBy], [Url], [user]  
	FROM FilesTable WHERE (oid = @oid)
	ORDER BY [Id] DESC
END

GO

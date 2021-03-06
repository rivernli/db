USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFilesInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-6-27 10:05
-- Description:	增加下载文件
-- =============================================
CREATE PROCEDURE [dbo].[ProcFilesInsert]
@oid int,
@parentId nvarchar(255)=NULL, 
@Type nvarchar(255),
@Name nvarchar(255), 
@ModifiedBy nvarchar(255), 
@Url nvarchar(255)=null, 
@user nvarchar(255),
@ID int output

AS
BEGIN
	INSERT INTO FilesTable ([oid], [parentId], [Type], [Name], [Modified], [ModifiedBy], [Url], [user] )
    VALUES     (@oid, CASE isNumeric(@parentId) WHEN 1 THEN CAST(@parentId as int) ELSE NULL END,@Type,@Name,getdate(),@ModifiedBy,@Url,@user)
    
    SET @ID= IDENT_CURRENT('FilesTable')  ---返回自动编号的id 
    
END

GO

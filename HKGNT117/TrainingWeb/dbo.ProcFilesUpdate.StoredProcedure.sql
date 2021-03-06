USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFilesUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-6-27 10:50
-- Description:	更新下载文件
-- =============================================
create PROCEDURE [dbo].[ProcFilesUpdate]
@oid int,
@parentId nvarchar(255)=NULL,
@Type nvarchar(255)='',
@Name nvarchar(255),  
@ModifiedBy nvarchar(255), 
@Url nvarchar(255)='', 
@user nvarchar(255),
@ID int
AS
BEGIN
	UPDATE   FilesTable
    SET   oid = @oid, parentId = @parentId, Type = (case when @Type='' then [Type] else @Type end), Name = @Name, Modified = getdate(), ModifiedBy = @ModifiedBy, Url = (case when @Url='' then [Url] else @Url end), [user] = @user
    WHERE [Id]=@ID
	
	
	select @@rowcount
END

GO

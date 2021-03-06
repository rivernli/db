USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_Group]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_Group] 	
		@ID INT=NULL,
		@GroupName VARCHAR(50)=NULL,
		@Description VARCHAR(500)=NULL,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO IES_Group(GroupName, Description)
		VALUES(@GroupName, @Description)
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_Group
		SET GroupName=@GroupName, Description=@Description
		WHERE ID=@ID 	
	RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_Group WHERE ID=@ID 	
	END


GO

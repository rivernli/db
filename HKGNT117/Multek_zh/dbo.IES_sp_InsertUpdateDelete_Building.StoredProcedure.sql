USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_Building]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_Building] 	
		@ID INT=NULL,
		@Building VARCHAR(50)=NULL,
		@Description VARCHAR(500)=NULL,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO IES_Building(Building, Description)
		VALUES(@Building, @Description)
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_Building
		SET Building=@Building, Description=@Description
		WHERE ID=@ID 	
	RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_Building WHERE ID=@ID 	
	END

GO

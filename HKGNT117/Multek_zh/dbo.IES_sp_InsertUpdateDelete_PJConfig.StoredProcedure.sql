USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_PJConfig]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_PJConfig] 	
		@ID INT=NULL,
		@Building VARCHAR(50)=NULL,
		@Project VARCHAR(50)=NULL,
		@Unit DECIMAL(18,2)=NULL,
		@Yield DECIMAL(18,2)=NULL,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO IES_PJConfig(Building, Project, Unit, Yield)
		VALUES(@Building, @Project, @Unit, @Yield)
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_PJConfig
		SET Building=@Building, Project=@Project, Unit=@Unit, Yield=@Yield
		WHERE ID=@ID 	
	RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_PJConfig_CycleTime WHERE PJID = @ID
		DELETE FROM IES_PJConfig WHERE ID=@ID 	
	END

GO

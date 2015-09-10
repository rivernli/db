USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_InsertUpdateDelete_Technology_mapping]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE PROCEDURE [dbo].[KOI_sp_InsertUpdateDelete_Technology_mapping]
	@ID INT=NULL,
	@Technology char(30)=NULL,
	@Group_display VARCHAR(50)=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

IF @Operation='Insert' 
	BEGIN
		INSERT INTO KOI_Technology_mapping (Technology,Group_display)
			VALUES(@Technology,@Group_display)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE KOI_Technology_mapping
		SET Technology=@Technology,Group_display=@Group_display  
		WHERE ID=@ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE KOI_Technology_mapping  
		WHERE ID=@ID 
	END











GO

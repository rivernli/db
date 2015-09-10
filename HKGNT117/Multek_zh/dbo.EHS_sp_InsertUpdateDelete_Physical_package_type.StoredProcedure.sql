USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_InsertUpdateDelete_Physical_package_type]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[EHS_sp_InsertUpdateDelete_Physical_package_type] 	
		@ID INT=NULL,
		@package_type NVARCHAR(50),		
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO EHS_Physical_package_type (package_type) VALUES (@package_type) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE EHS_Physical_package_type SET package_type=@package_type WHERE ID=@ID 	
	return @ID 
	END
















GO

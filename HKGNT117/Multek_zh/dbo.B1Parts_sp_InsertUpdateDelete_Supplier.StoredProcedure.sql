USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Supplier]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Supplier] 	
		@ID INT=NULL,
		@VendorNo NVARCHAR(50),
		@VendorName NVARCHAR(50),		
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Supplier_List (VendorNo, VendorName)
					VALUES(@VendorNo, @VendorName) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Supplier_List
		SET VendorNo=@VendorNo, VendorName=@VendorName 
		WHERE ID=@ID 	
	return @ID 
	END














GO

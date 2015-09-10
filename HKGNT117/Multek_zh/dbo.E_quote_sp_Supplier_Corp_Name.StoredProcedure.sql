USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Supplier_Corp_Name]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[E_quote_sp_Supplier_Corp_Name] 	
	@SupplierCorpId INT=NULL, 
	@SupplierCorpName NVARCHAR(50),
	@Operation VARCHAR(10) 
AS

IF @Operation='Insert' 
	BEGIN		 
			INSERT INTO E_quote_Supplier_Corp_Name (SupplierCorpName)
			VALUES(@SupplierCorpName) 
	END 

IF @Operation='Update' 
	BEGIN
			UPDATE E_quote_Supplier_Corp_Name SET SupplierCorpName=@SupplierCorpName WHERE SupplierCorpId=@SupplierCorpId 	
	END












GO

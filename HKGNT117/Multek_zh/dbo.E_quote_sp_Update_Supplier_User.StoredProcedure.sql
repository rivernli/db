USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Update_Supplier_User]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[E_quote_sp_Update_Supplier_User] 	
	@ID INT=NULL,
	@Active BIT=NULL,
	@VendorCode NVARCHAR(50),
	@VendorName NVARCHAR(50),
	@Password NVARCHAR(50),
	@Approved NVARCHAR(50),
	@ApprovedDate DATETIME=NULL,
	@state INT=NULL 
	
AS

	BEGIN		 
			UPDATE E_quote_SupplierUser SET Active=@Active, VendorCode=@VendorCode, VendorName=@VendorName, Password=@Password, Approved=@Approved, ApprovedDate=@ApprovedDate, state=@state WHERE ID=@ID 
	END 

















GO

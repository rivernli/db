USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Supplier_Register_User]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





 
CREATE PROCEDURE [dbo].[E_quote_sp_Supplier_Register_User] 	
	@Email NVARCHAR(50),
	@RealName NVARCHAR(50),
	@Mobile NVARCHAR(50),
	@Tel NVARCHAR(50),
	@CorporateName NVARCHAR(50),
	@CompanyProfile NVARCHAR(max), 
	@RegisterDate datetime=NULL,
	@ApproverEmail NVARCHAR(50) 
AS

	BEGIN		 
			INSERT INTO E_quote_SupplierUser (Email,RealName,Mobile,Tel,CorporateName,CompanyProfile,RegisterDate,ApproverEmail,ApprovedDate)
			VALUES(@Email,@RealName,@Mobile,@Tel,@CorporateName,@CompanyProfile,@RegisterDate,@ApproverEmail,NULL) 
	END 
















GO

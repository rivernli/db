USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Supplier_guestbook]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 

 
CREATE PROCEDURE [dbo].[E_quote_sp_Supplier_guestbook] 	
	@Pur_Id INT=NULL,
	@Email NVARCHAR(50),
	@Posted_Date datetime=NULL,
	@Ip_address NVARCHAR(50),
	@Remark NVARCHAR(MAX),
	@Attachment NVARCHAR(50) 
AS

	BEGIN		 
			INSERT INTO E_quote_Supplier_guestbook (Pur_Id,Email,Posted_Date,Ip_address,Remark,Attachment)
			VALUES(@Pur_Id,@Email,@Posted_Date,@Ip_address,@Remark,@Attachment) 
	END 














GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Supplier_guestbook_Reply]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[E_quote_sp_Supplier_guestbook_Reply] 	
	@Pur_Id INT=NULL,
	@guestbookId INT=NULL,
	@Email NVARCHAR(50),
	@Posted_Date datetime=NULL,
	@Ip_address NVARCHAR(50),
	@Remark NVARCHAR(MAX),
	@Attachment NVARCHAR(50) 
AS

	BEGIN		 
			INSERT INTO E_quote_Supplier_guestbook_Reply (Pur_Id, guestbookId, Email, Posted_Date, Ip_address, Remark, Attachment)
			VALUES(@Pur_Id, @guestbookId, @Email, @Posted_Date, @Ip_address, @Remark, @Attachment) 
	END 














GO

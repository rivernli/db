USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_New_Purchase]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[E_quote_sp_New_Purchase]
	@ID INT=NULL,
	@subject NVARCHAR(200),
	@supplier NVARCHAR(MAX),
	@SupplierEmail NVARCHAR(MAX),
	@Pur_Content NVARCHAR(MAX),
	@Initiator NVARCHAR(50),
	@Initiator_Date datetime=NULL,
	@Modify NVARCHAR(50),
	@Modify_Date datetime=NULL,
	@ViewState bit,
	@Attachment NVARCHAR(50),
	@EndDate datetime=NULL,
	@Remark NVARCHAR(MAX),
	@Operation VARCHAR(10) 
AS

IF @Operation='Insert' 
	BEGIN		 
			INSERT INTO E_quote_New_Purchase (subject,supplier,SupplierEmail,Pur_Content,Initiator,Initiator_Date,Views,ViewState,Attachment,End_Date,Remark)
			VALUES(@subject,@supplier,@SupplierEmail,@Pur_Content,@Initiator,@Initiator_Date,0,@ViewState,@Attachment,@EndDate,@Remark) 
	END 

IF @Operation='Update' 
	BEGIN
			UPDATE E_quote_New_Purchase SET subject=@subject, supplier=@supplier, SupplierEmail=@SupplierEmail, 
			Pur_Content=@Pur_Content, Modify=@Modify, Modify_Date=@Modify_Date, ViewState=@ViewState, Attachment=@Attachment, End_Date=@EndDate, Remark=@Remark  
			WHERE ID=@ID 	
	END


















GO

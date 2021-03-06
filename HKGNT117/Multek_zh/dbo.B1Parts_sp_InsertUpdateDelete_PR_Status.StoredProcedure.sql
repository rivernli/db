USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_PR_Status]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_PR_Status] 	
		@ID INT=NULL,
		@Applicant_No NVARCHAR(50), 
		@LineCode NVARCHAR(50),
		@Purpose NVARCHAR(50),		
		@INVNO NVARCHAR(50),		
		@PRNO NVARCHAR(50),		
		@BaanNo NVARCHAR(50),		
		@Qty INT=NULL,
		@PR NVARCHAR(50),		
		@IssueDate datetime,
		@IssuePO datetime,
		@PurchasePrice float,
		@Currency NVARCHAR(50),	
		@Vendors NVARCHAR(50),	
		@DeliveryDate datetime,	
		@PONo NVARCHAR(50),	
		@Remark ntext,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_PR_Status (Applicant_No, LineCode, Purpose, INVNO, PRNO, BaanNo, Qty, PR, IssueDate, IssuePO, PurchasePrice, Currency, Vendors, DeliveryDate, PONo, Remark)
					VALUES(@Applicant_No, @LineCode, @Purpose, @INVNO, @PRNO, @BaanNo, @Qty, @PR, @IssueDate, @IssuePO, @PurchasePrice, @Currency, @Vendors, @DeliveryDate, @PONo, @Remark) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_PR_Status
		SET Applicant_No=@Applicant_No, LineCode=@LineCode, Purpose=@Purpose, INVNO=@INVNO, PRNO=@PRNO, BaanNo=@BaanNo, Qty=@Qty, PR=@PR, IssueDate=@IssueDate, 
            IssuePO=@IssuePO, PurchasePrice=@PurchasePrice, Currency=@Currency, Vendors=@Vendors, DeliveryDate=@DeliveryDate, 
			PONo=@PONo, Remark=@Remark 
		WHERE ID=@ID 	
	return @ID 
	END















GO

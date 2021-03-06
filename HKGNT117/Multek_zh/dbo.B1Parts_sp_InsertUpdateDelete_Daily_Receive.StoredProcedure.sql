USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Daily_Receive]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Daily_Receive] 	
		@ID INT=NULL,		
		@PartNO NVARCHAR(50),
		@ReceivedDate DATETIME=NULL,
		@ReceivedQty float,
		@ReceivedPrice float,
		@Currency NVARCHAR(50),
		@VendorNo NVARCHAR(50), 
		@PO NVARCHAR(50),
		@PR NVARCHAR(50),
		@DNNo NVARCHAR(50),
		@Remark ntext,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Daily_Receive_List (PartNO, ReceivedDate, ReceivedQty, ReceivedPrice, Currency, VendorNo, PO, PR, DNNo, Remark)
					VALUES(@PartNO, @ReceivedDate, @ReceivedQty, @ReceivedPrice, @Currency, @VendorNo, @PO, @PR, @DNNo, @Remark) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Daily_Receive_List
		SET PartNO=@PartNO, ReceivedDate=@ReceivedDate, ReceivedQty=@ReceivedQty, ReceivedPrice=@ReceivedPrice, 
			Currency=@Currency, VendorNo=@VendorNo, PO=@PO, PR=@PR, DNNo=@DNNo, Remark=@Remark 
		WHERE ID=@ID 	
	return @ID 
	END













GO

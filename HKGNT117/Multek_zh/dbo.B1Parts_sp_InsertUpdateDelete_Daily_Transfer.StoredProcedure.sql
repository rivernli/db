USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Daily_Transfer]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Daily_Transfer] 	
		@ID INT=NULL,
		@Date datetime,
		@PartNO NVARCHAR(50),	
		@Item INT=NULL,
		@TransferQty float,
		@TransferTo NVARCHAR(50),
		@Price float,
		@Remark ntext,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Daily_Transfer_List (Date, PartNO, Item, TransferQty, TransferTo, Price, Remark)
					VALUES(@Date, @PartNO, @Item, @TransferQty, @TransferTo, @Price, @Remark) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Daily_Transfer_List
		SET Date=@Date, PartNO=@PartNO, Item=@Item, TransferQty=@TransferQty, TransferTo=@TransferTo, Price=@Price, Remark=@Remark 
		WHERE ID=@ID 	
	return @ID 
	END















GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Opening_Inventory_SP]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Opening_Inventory_SP] 	
		@ID INT=NULL,
		@SPNO_Opening NVARCHAR(50),
		@Stocktaking_Qty float,		
		@Stocktaking_Date DATETIME=NULL,
		@Last_Received_Date DATETIME=NULL,
		@Remark ntext,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Opening_Inventory_SP (SPNO_Opening, Stocktaking_Qty, Stocktaking_Date, Last_Received_Date, Remark)
					VALUES(@SPNO_Opening, @Stocktaking_Qty, @Stocktaking_Date, @Last_Received_Date, @Remark) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Opening_Inventory_SP
		SET SPNO_Opening=@SPNO_Opening, Stocktaking_Qty=@Stocktaking_Qty, Stocktaking_Date=@Stocktaking_Date, Last_Received_Date=@Last_Received_Date, Remark=@Remark
		WHERE ID=@ID 	
	return @ID 
	END












GO

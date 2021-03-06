USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Delivery_sp_InsertUpdateDelete_Delivery]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Delivery_sp_InsertUpdateDelete_Delivery]
	@ID INT=NULL,
	@Vendor NVARCHAR(50)=NULL,
	@Material_Numbers VARCHAR(50)=NULL,
	@Name NVARCHAR(50)=NULL,
	@StoreType NVARCHAR(50)=NULL,
	@Units NVARCHAR(50)=NULL,
	@Quantity varchar(10)=NULL,
	@Date_requested datetime,
	@Note NVARCHAR(max)=NULL,
	@Operation_dates datetime,
	@Operation_people NVARCHAR(50)=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

DECLARE @NewID INT 

IF @Operation='Insert' 
	BEGIN
		INSERT INTO Delivery_tblDelivery (Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,Operation_people)
			VALUES(@Vendor,@Material_Numbers,@Name,@StoreType,@Units,@Quantity,@Date_requested,@Note,@Operation_dates,@Operation_people)
	SET @NewID=@@identity

	--Insert Store		
		INSERT INTO Delivery_tblStore (DeliveryID,Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,Operation_people)
			VALUES(@NewID,@Vendor,@Material_Numbers,@Name,@StoreType,@Units,@Quantity,@Date_requested,@Note,@Operation_dates,@Operation_people)
	
	END

IF @Operation='Update' 
	BEGIN
		UPDATE Delivery_tblDelivery
		SET Vendor=@Vendor,Material_Numbers=@Material_Numbers,[Name]=@Name,StoreType=@StoreType,Units=@Units,Quantity=@Quantity,
		Date_requested=@Date_requested,Note=@Note,Operation_dates=@Operation_dates,Operation_people=@Operation_people  
		WHERE ID=@ID

	--Update Store
		UPDATE Delivery_tblStore
		SET Vendor=@Vendor,Material_Numbers=@Material_Numbers,[Name]=@Name,StoreType=@StoreType,Units=@Units,Quantity=@Quantity,
		Date_requested=@Date_requested,Note=@Note,Operation_dates=@Operation_dates,Operation_people=@Operation_people 
		WHERE DeliveryID=@ID
	END 







GO

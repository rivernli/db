USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Delivery_sp_Insert_Split_Store]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Delivery_sp_Insert_Split_Store]
	@ID INT=NULL,
	@DeliveryID INT=NULL,
	@Vendor NVARCHAR(50)=NULL,
	@Material_Numbers VARCHAR(50)=NULL,
	@Name NVARCHAR(50)=NULL,
	@StoreType NVARCHAR(50)=NULL,
	@Units NVARCHAR(50)=NULL,
	@Quantity varchar(10)=NULL,
	@Sqlit_Quantity varchar(10)=NULL,
	@Date_requested datetime,
	@Note NVARCHAR(max)=NULL,
	@Operation_dates datetime,
	@Operation_people NVARCHAR(50)=NULL,
	@DNNO NVARCHAR(100)=NULL 
AS

BEGIN		

		INSERT INTO Delivery_tblStore (P_ID,DeliveryID,Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,Operation_people,DN_NO)
			VALUES(@ID,@DeliveryID,@Vendor,@Material_Numbers,@Name,@StoreType,@Units,@Sqlit_Quantity,@Date_requested,@Note,@Operation_dates,@Operation_people,@DNNO) 
		
		UPDATE Delivery_tblStore SET Quantity=@Quantity WHERE ID=@ID 
END 
 



GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Delivery_sp_Send_material_Store]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Delivery_sp_Send_material_Store]
	@ID INT=NULL,	
	@Send_material VARCHAR(20)=NULL,
	@Send_material_people NVARCHAR(20)=NULL,
	@Send_material_Date datetime=NULL,
	@process VARCHAR(50)=NULL,
	@MRU NVARCHAR(20)=NULL,
	@Remainder NVARCHAR(50)=NULL 
AS

BEGIN
	UPDATE Delivery_tblStore SET Remainder=@Remainder WHERE ID=@ID
	
	--Insert tblDelivery_Logs
--	INSERT INTO tblDelivery_Logs (
--			ID,P_ID,DeliveryID,Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,
--			Operation_people,State,Effective_date,Actual_receiving,Tax_Category,Confirm_receipt,Confirm_Date,Confirmor,Send_material,
--			Send_material_people,Send_material_Date,process,MRU,Remainder) 
--	(select ID,P_ID,DeliveryID,Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,
--			Operation_people,State,Effective_date,Actual_receiving,Tax_Category,Confirm_receipt,Confirm_Date,Confirmor,@Send_material,
--			@Send_material_people,@Send_material_Date,@process,@MRU,Remainder from tblStore WHERE ID=@ID)

IF @Remainder<>'0'
	BEGIN
		INSERT INTO Delivery_tblStore (
				P_ID,DeliveryID,Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,
				Operation_people,State,Effective_date,Tax_Category,Confirm_receipt,Confirm_Date,Confirmor,Send_material,
				Send_material_people,Send_material_Date,process,MRU,Remainder,Completion,DN_NO) 
		(select ID,DeliveryID,Vendor,Material_Numbers,[Name],StoreType,Units,Quantity,Date_requested,Note,Operation_dates,
				Operation_people,State,Effective_date,Tax_Category,Confirm_receipt,Confirm_Date,Confirmor,@Send_material,
				@Send_material_people,@Send_material_Date,@process,@MRU,@Remainder,1,DN_NO from Delivery_tblStore WHERE ID=@ID)

	END
ELSE
	BEGIN
		UPDATE Delivery_tblStore SET Send_material=@Send_material,Send_material_people=@Send_material_people,Send_material_Date=@Send_material_Date,
		process=@process,MRU=@MRU,Remainder=@Remainder,Completion='1' WHERE ID=@ID 
	END
	
	--Delete tblDelivery
	DELETE FROM Delivery_tblDelivery WHERE ID IN (select DeliveryID from Delivery_tblStore WHERE Remainder='0' AND ID=@ID)	
END 












GO

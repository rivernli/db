USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Delivery_sp_Receiving_material_Store]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[Delivery_sp_Receiving_material_Store]
	@ID INT=NULL,	
	@DNNO NVARCHAR(100)=NULL,
	@Receivingdate datetime=NULL,
	@Effective_date datetime=NULL,
	@Actual_receiving VARCHAR(20)=NULL,
	@Tax_Category NVARCHAR(20)=NULL,
	@Modeoftransport NVARCHAR(50)=NULL,
	@Confirm_receipt NVARCHAR(1)=NULL,
	@Confirm_Date DateTime=NULL,
	@Confirmor NVARCHAR(50)
AS

BEGIN
	UPDATE Delivery_tblStore SET Receivingdate=@Receivingdate,Effective_date=@Effective_date,Actual_receiving=@Actual_receiving,Tax_Category=@Tax_Category,Modeoftransport=@Modeoftransport, 
	Remainder=@Actual_receiving,Confirm_receipt=@Confirm_receipt,Confirm_Date=@Confirm_Date,Confirmor=@Confirmor,DN_NO=@DNNO WHERE ID=@ID	
END













GO

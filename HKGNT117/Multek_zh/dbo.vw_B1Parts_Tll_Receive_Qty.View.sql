USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Tll_Receive_Qty]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_B1Parts_Tll_Receive_Qty]
as
select B1Parts_Daily_Receive_List.PartNo,SUM(B1Parts_Daily_Receive_List.ReceivedQty) AS TllReceiveQty from B1Parts_Supplier_List 
INNER JOIN B1Parts_Daily_Receive_List ON B1Parts_Daily_Receive_List.VendorNo=B1Parts_Supplier_List.VendorNo
INNER JOIN B1Parts_SP_Part_List ON B1Parts_SP_Part_List.NewPN=B1Parts_Daily_Receive_List.PartNo 
INNER JOIN B1Parts_Exchange_Rate_List ON B1Parts_Exchange_Rate_List.CC=B1Parts_Daily_Receive_List.Currency 
GROUP BY B1Parts_Daily_Receive_List.PartNo

GO

USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Re_Date_Min]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_B1Parts_Re_Date_Min]
as
select B1Parts_Daily_Receive_List.PartNo,B1Parts_SP_Part_List.NewDescription,
Max(B1Parts_Daily_Receive_List.ReceivedDate) as ReceivedDateOfMax, 
Max(B1Parts_Daily_Receive_List.PO) as POOfMax, Max(B1Parts_Daily_Receive_List.VendorNo) as VendorNoOfLast 
from B1Parts_Supplier_List 
INNER JOIN B1Parts_Daily_Receive_List on B1Parts_Daily_Receive_List.Vendorno=B1Parts_Supplier_List.Vendorno
INNER JOIN B1Parts_SP_Part_List on B1Parts_SP_Part_List.NewPN=B1Parts_Daily_Receive_List.PartNO
GROUP BY B1Parts_Daily_Receive_List.PartNo, B1Parts_SP_Part_List.NewDescription 


GO

USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Tll_Transfer_Qty]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_B1Parts_Tll_Transfer_Qty]
AS
select B1Parts_Daily_Transfer_List.PartNO,SUM(B1Parts_Daily_Transfer_List.TransferQty) AS TllTransferredQty 
from B1Parts_SP_Part_List INNER JOIN B1Parts_Daily_Transfer_List 
ON B1Parts_SP_Part_List.NewPN=B1Parts_Daily_Transfer_List.PartNO 
GROUP BY B1Parts_Daily_Transfer_List.PartNO 
GO

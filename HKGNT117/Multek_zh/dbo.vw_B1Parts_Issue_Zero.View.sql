USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Issue_Zero]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_B1Parts_Issue_Zero]  
as
select B1Parts_SP_Part_List.ID,B1Parts_SP_Part_List.NewPN,B1Parts_SP_Part_List.NewDescription,
isnull(TllReceiveQty,0) as TllReceiveQty,isnull(TllissueQty,0) as TllissueQty,B1Parts_SP_Part_List.Unit,B1Parts_SP_Part_List.Location,
--(isnull(TllReceiveQty,0)-isnull(TllissueQty,0)) as On_hand,
((ISNULL(Stocktaking_Qty,0)+ISNULL(TllReceiveQty,0))-ISNULL(TllIssueQty,0)-ISNULL(TllTransferredQty,0)) as On_hand, 
B1Parts_SP_Part_List.Baanrice
from B1Parts_SP_Part_List left join vw_B1Parts_Tll_Issue_Qty on B1Parts_SP_Part_List.NewPN=vw_B1Parts_Tll_Issue_Qty.Partno 
left join vw_B1Parts_Tll_Receive_Qty on vw_B1Parts_Tll_Receive_Qty.Partno=B1Parts_SP_Part_List.NewPN
LEFT JOIN vw_B1Parts_Tll_Transfer_Qty ON B1Parts_SP_Part_List.NewPN=vw_B1Parts_Tll_Transfer_Qty.PartNO 
LEFT JOIN B1Parts_Opening_Inventory_SP ON B1Parts_SP_Part_List.NewPN=B1Parts_Opening_Inventory_SP.SPNO_Opening 

GROUP BY B1Parts_SP_Part_List.ID, B1Parts_SP_Part_List.NewPN, B1Parts_SP_Part_List.NewDescription, 
isnull(TllReceiveQty,0),isnull(TllissueQty,0),ISNULL(Stocktaking_Qty,0),ISNULL(TllTransferredQty,0),
B1Parts_SP_Part_List.Unit,B1Parts_SP_Part_List.Location,
B1Parts_SP_Part_List.Baanrice,vw_B1Parts_Tll_Issue_Qty.PartNo,vw_B1Parts_Tll_Receive_Qty.PartNo 
HAVING isnull(TllReceiveQty,0)<>0
GO

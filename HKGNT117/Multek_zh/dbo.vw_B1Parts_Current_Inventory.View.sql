USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Current_Inventory]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_B1Parts_Current_Inventory]
as 
select NewPN AS SPPN,NewDescription,Baanrice,Opening,[In],[Out],TransferOut,
((Opening+[In])-[Out]-TransferOut) as Closing,Unit,Location,ABC, [Max], [Min],Belongto from (
select B1Parts_SP_Part_List.NewPN,B1Parts_SP_Part_List.NewDescription,B1Parts_SP_Part_List.Baanrice, 
(CASE WHEN Stocktaking_Qty IS NULL THEN '0' ELSE Stocktaking_Qty END) AS Opening,
(CASE WHEN TllReceiveQty IS NULL THEN '0' ELSE TllReceiveQty END) AS [In],
(CASE WHEN TllIssueQty IS NULL THEN '0' ELSE TllIssueQty END) AS Out,
(CASE WHEN TllTransferredQty IS NULL THEN '0' ELSE TllTransferredQty END) AS TransferOut,
B1Parts_SP_Part_List.Unit,B1Parts_SP_Part_List.Location,B1Parts_SP_Part_List.ABC,
B1Parts_SP_Part_List.[Max],B1Parts_SP_Part_List.[Min],B1Parts_SP_Part_List.Belongto 
 from B1Parts_SP_Part_List LEFT JOIN vw_B1Parts_Tll_Receive_Qty ON B1Parts_SP_Part_List.NewPN=vw_B1Parts_Tll_Receive_Qty.PartNo
LEFT JOIN vw_B1Parts_Tll_Issue_Qty ON B1Parts_SP_Part_List.NewPN=vw_B1Parts_Tll_Issue_Qty.PartNO 
LEFT JOIN vw_B1Parts_Tll_Transfer_Qty ON B1Parts_SP_Part_List.NewPN=vw_B1Parts_Tll_Transfer_Qty.PartNO 
LEFT JOIN B1Parts_Opening_Inventory_SP ON B1Parts_SP_Part_List.NewPN=B1Parts_Opening_Inventory_SP.SPNO_Opening 
) a  
 GROUP BY NewPN,NewDescription,Baanrice,Opening,[In],[Out],TransferOut, 
((Opening+[In])-[Out]-TransferOut),Unit,Location,ABC, [Max], [Min],Belongto

GO

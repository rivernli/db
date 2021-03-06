USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Tll_Issue_Qty]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_B1Parts_Tll_Issue_Qty]  
as
select B1Parts_Daily_Issue_List.PartNo,SUM(B1Parts_Daily_Issue_List.IssuedQty) AS TllissueQty  
from B1Parts_SP_Part_List 
INNER JOIN B1Parts_Daily_Issue_List ON B1Parts_SP_Part_List.NewPN=B1Parts_Daily_Issue_List.PartNo 
LEFT JOIN B1Parts_FES_Engineers ON B1Parts_FES_Engineers.ESUserNo=B1Parts_Daily_Issue_List.UserNo 
--LEFT JOIN B1Parts_Equipment_List ON B1Parts_Equipment_List.EqNo=B1Parts_Daily_Issue_List.WorkCenter
--LEFT JOIN B1Parts_Line_List ON B1Parts_Line_List.EqAr=B1Parts_Equipment_List.EqAr 
GROUP BY B1Parts_Daily_Issue_List.PartNO

GO

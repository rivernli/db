USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Issue_Qty_By_WC_Year_Month]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_B1Parts_Issue_Qty_By_WC_Year_Month]
as 
select B1Parts_Daily_Issue_List.PartNo,B1Parts_SP_Part_List.NewDescription,B1Parts_Daily_Issue_List.WorkCenter,
B1Parts_Equipment_List.EqDe,B1Parts_SP_Part_List.Unit,IssuedQty,
(CONVERT(varchar(4),B1Parts_Daily_Issue_List.[Date], 120 )+'/'+substring(CONVERT(varchar(10),B1Parts_Daily_Issue_List.[Date],120),6,2)) AS Date_YM 
 from B1Parts_SP_Part_List
INNER JOIN B1Parts_Daily_Issue_List ON B1Parts_Daily_Issue_List.PartNO=B1Parts_SP_Part_List.NewPN
INNER JOIN B1Parts_Equipment_List ON B1Parts_Equipment_List.EqNo=B1Parts_Daily_Issue_List.WorkCenter

GO

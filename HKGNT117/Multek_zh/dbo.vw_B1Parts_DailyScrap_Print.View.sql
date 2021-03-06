USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_DailyScrap_Print]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_B1Parts_DailyScrap_Print]
as
select B1Parts_Daily_Issue_List.ID,B1Parts_Daily_Issue_List.PartNO,
(CASE WHEN LEN(B1Parts_SP_Part_List.NewDescription)>32 THEN Left(B1Parts_SP_Part_List.NewDescription,32) + '...' ELSE B1Parts_SP_Part_List.NewDescription END) as NewDescription,
B1Parts_Daily_Issue_List.Date,
 B1Parts_Daily_Issue_List.IssuedQty,B1Parts_Daily_Issue_List.ScarpQty,B1Parts_FES_Engineers.ESUserName,
 B1Parts_Daily_Issue_List.SerialNo,
(CASE WHEN LEN(B1Parts_Daily_Issue_List.Remark)>10 THEN Left(B1Parts_Daily_Issue_List.Remark,10) + '...' ELSE B1Parts_Daily_Issue_List.Remark END) as Remark 
                         from B1Parts_SP_Part_List 
                        INNER JOIN B1Parts_Daily_Issue_List ON B1Parts_Daily_Issue_List.PartNO=B1Parts_SP_Part_List.NewPN
                        INNER JOIN B1Parts_Equipment_List ON B1Parts_Equipment_List.EqNo=B1Parts_Daily_Issue_List.WorkCenter
                        INNER JOIN B1Parts_FES_Engineers ON B1Parts_FES_Engineers.ESUserNo=B1Parts_Daily_Issue_List.UserNo
                        INNER JOIN B1Parts_Line_List ON B1Parts_Line_List.EqAr=B1Parts_Equipment_List.EqAr

GO

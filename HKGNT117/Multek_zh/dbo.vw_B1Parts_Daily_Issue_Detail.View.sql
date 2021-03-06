USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Daily_Issue_Detail]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_B1Parts_Daily_Issue_Detail]
AS
select B1Parts_Daily_Issue_List.ID,B1Parts_Daily_Issue_List.Date,B1Parts_Daily_Issue_List.PartNo,B1Parts_SP_Part_List.NewDescription,
                    B1Parts_Daily_Issue_List.WorkCenter,B1Parts_Equipment_List.EqDe,B1Parts_Daily_Issue_List.SerialNo,B1Parts_Daily_Issue_List.Item,
                    B1Parts_Daily_Issue_List.IssuedQty,B1Parts_Daily_Issue_List.ScarpQty,B1Parts_SP_Part_List.Unit,B1Parts_SP_Part_List.Baanrice,
                    (Baanrice*IssuedQty) AS IssueCost,B1Parts_Daily_Issue_List.PDSigned,B1Parts_Daily_Issue_List.UserNo,B1Parts_FES_Engineers.ESUserName,
                    B1Parts_Daily_Issue_List.MaintainNo,B1Parts_Daily_Issue_List.MaintainCausation,B1Parts_Equipment_List.EqAr,B1Parts_Line_List.EqAde,
                    B1Parts_SP_Part_List.ABC,B1Parts_Daily_Issue_List.[Count],B1Parts_Daily_Issue_List.Remark
                     from B1Parts_SP_Part_List 
                    INNER JOIN B1Parts_Daily_Issue_List ON  B1Parts_Daily_Issue_List.PartNO=B1Parts_SP_Part_List.NewPN
                    INNER JOIN B1Parts_Equipment_List ON  B1Parts_Equipment_List.EqNo=B1Parts_Daily_Issue_List.WorkCenter
                    INNER JOIN B1Parts_FES_Engineers ON B1Parts_FES_Engineers.ESUserNo=B1Parts_Daily_Issue_List.UserNo
                    INNER JOIN B1Parts_Line_List ON B1Parts_Line_List.EqAr=B1Parts_Equipment_List.EqAr 

GO

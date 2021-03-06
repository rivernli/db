USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_FeedBack_Status_PD]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_B1Parts_FeedBack_Status_PD]
AS
select B1Parts_Daily_Issue_List.ID,B1Parts_Daily_Issue_List.Date,B1Parts_Daily_Issue_List.WorkCenter,B1Parts_Daily_Issue_List.SerialNo,B1Parts_Daily_Issue_List.PartNo,
                        B1Parts_SP_Part_List.NewDescription,B1Parts_Daily_Issue_List.IssuedQty,B1Parts_Daily_Issue_List.ScarpQty,(ScarpQty-IssuedQty) AS Variance,
                        (CASE WHEN PDSigned = '1' THEN 'YES' ELSE 'NO' END) AS PDSigned,B1Parts_Daily_Issue_List.Remark,B1Parts_FES_Engineers.ESUserName,
                        B1Parts_Daily_Issue_List.MaintainNo,B1Parts_Daily_Issue_List.MaintainCausation
                         from B1Parts_SP_Part_List
                        INNER JOIN B1Parts_Daily_Issue_List ON  B1Parts_Daily_Issue_List.PartNO=B1Parts_SP_Part_List.NewPN
                        INNER JOIN B1Parts_FES_Engineers ON B1Parts_FES_Engineers.ESUserNo=B1Parts_Daily_Issue_List.UserNo



GO

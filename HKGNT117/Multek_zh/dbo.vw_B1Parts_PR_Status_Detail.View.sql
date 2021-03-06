USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_PR_Status_Detail]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_B1Parts_PR_Status_Detail]
as
select  B1Parts_PR_Status.ID,B1Parts_PR_Status.Applicant_No,B1Parts_FES_Engineers.ESUserName,B1Parts_SP_Part_List.[Type],B1Parts_FES_Engineers.PhoneNo,
B1Parts_PR_Status.PRNO,B1Parts_PR_Status.BaanNo,B1Parts_SP_Part_List.NewDescription, 
B1Parts_PR_Status.Qty,B1Parts_SP_Part_List.Unit,B1Parts_Local_and_Oversea_List.Local_Oversea_PR_ch ,
B1Parts_PR_Status.IssueDate,B1Parts_PR_Status.DeliveryDate,B1Parts_PR_Status.Purpose,B1Parts_PR_Status.INVNO, 
B1Parts_PR_Status.PONo,B1Parts_PR_Status.Vendors,B1Parts_Supplier_List.VendorName,B1Parts_SP_Part_List.[Max],
B1Parts_PR_Status.Currency,B1Parts_PR_Status.IssuePO,B1Parts_PR_Status.[Count],B1Parts_PR_Status.PurchasePrice, 
B1Parts_SP_Part_List.Baanrice,B1Parts_SP_Part_List.[Min],vw_B1Parts_Current_Inventory.Closing,B1Parts_PR_Status.LineCode,
B1Parts_Line_List.EqAde,B1Parts_PR_Status.PR 
 from B1Parts_Supplier_List 
RIGHT JOIN B1Parts_PR_Status ON B1Parts_PR_Status.Vendors=B1Parts_Supplier_List.VendorNo 
 INNER JOIN B1Parts_FES_Engineers ON B1Parts_FES_Engineers.ESUserNo=B1Parts_PR_Status.Applicant_No
INNER JOIN B1Parts_Local_and_Oversea_List ON B1Parts_Local_and_Oversea_List.Code=B1Parts_PR_Status.PR 
INNER JOIN B1Parts_SP_Part_List ON B1Parts_SP_Part_List.NewPN=B1Parts_PR_Status.BaanNo
LEFT JOIN vw_B1Parts_Current_Inventory ON vw_B1Parts_Current_Inventory.SPPN =B1Parts_SP_Part_List.NewPN 
INNER JOIN B1Parts_Line_List ON B1Parts_Line_List.EqAr=B1Parts_PR_Status.LineCode 
GROUP BY B1Parts_PR_Status.ID,B1Parts_PR_Status.Applicant_No,B1Parts_FES_Engineers.ESUserName,B1Parts_SP_Part_List.[Type],B1Parts_FES_Engineers.PhoneNo,
B1Parts_PR_Status.PRNO,B1Parts_PR_Status.BaanNo,B1Parts_SP_Part_List.NewDescription, 
B1Parts_PR_Status.Qty,B1Parts_SP_Part_List.Unit,B1Parts_Local_and_Oversea_List.Local_Oversea_PR_ch,
B1Parts_PR_Status.IssueDate,B1Parts_PR_Status.DeliveryDate,B1Parts_PR_Status.Purpose,B1Parts_PR_Status.INVNO, 
B1Parts_PR_Status.PONo,B1Parts_PR_Status.Vendors,B1Parts_Supplier_List.VendorName,B1Parts_SP_Part_List.[Max],
B1Parts_PR_Status.Currency,B1Parts_PR_Status.IssuePO,B1Parts_PR_Status.[Count],B1Parts_PR_Status.PurchasePrice, 
B1Parts_SP_Part_List.Baanrice,B1Parts_SP_Part_List.[Min],vw_B1Parts_Current_Inventory.Closing,B1Parts_PR_Status.LineCode,
B1Parts_Line_List.EqAde,B1Parts_PR_Status.PR

GO

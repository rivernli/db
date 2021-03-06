USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vMKT_Shipment_CN_New]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vMKT_Shipment_CN_New]
as
SELECT     CONVERT(nvarchar(10), a.T$ORNO) AS BaaN_SO, a.T$ITEM AS Prj_No, a.T$CUPN AS Part_No, a.T$EONO AS PO_No, CONVERT(INT, a.T$INVN) 
                      AS Invoice_No, a.T$DQUA AS Del_Qty, CONVERT(datetime, a.T$INVD, 101) AS Invoice_Date, a.T$PRIC AS UnitPrice, a.T$CCUR AS Currency, 
                      a.T$AMNT AS Del_Amt_USD, a.T$AREA AS Del_SqFt, a.T$CODA AS Ship_To_Cty, a.T$CUNO AS Cust_Code, a.T$ENDC AS OEM_NAME, 
                      a.T$CDSC AS CEM_NAME, a.T$REFA AS AST_SO, CONVERT(datetime, a.T$PODT, 101) AS PO_Date, CONVERT(datetime, a.T$RQDT, 101) AS Cust_Req_Date, 
                      a.T$COTP AS Order_type, a.T$CWAR AS Warehouse, b.T$PLNT AS Plant, 'CN' AS Site, a.T$STYP AS SALE_TYPE, a.T$FIDS AS Financial_Group, 
                      a.T$PSPL AS Unit_Panel, a.T$PRDN AS Product_Name, a.T$FLEX AS Flex_Order, a.T$ISEG AS Segment, a.T$DESC AS Segment_Description, 
                      a.T$CDEL AS Del_Code, a.T$OTYP AS Project_Type
FROM         vTFSOLP101180 AS a INNER JOIN
                      shipment_backlog_wh AS b ON a.T$CWAR = b.T$CWAR
WHERE     (a.T$INVD >= '01/01/2004')
UNION ALL
SELECT     CONVERT(nvarchar(10), T$ORNO) AS BaaN_SO, T$ITEM AS Prj_No, T$CUPN AS Part_No, T$EONO AS PO_No, CONVERT(INT, T$INVN) AS Invoice_No, 
                      T$DQUA AS Del_Qty, CONVERT(char, T$INVD, 101) AS Invoice_Date, T$PRIC AS UnitPrice, T$CCUR AS Currency, T$AMNT AS Del_Amt_USD, 
                      T$AREA AS Del_SqFt, T$CODA AS Ship_To_Cty, T$CUNO AS Cust_Code, T$ENDC AS OEM_NAME, T$CDSC AS CEM_NAME, T$REFA AS AST_SO, 
                      CONVERT(datetime, T$PODT, 101) AS PO_Date, CONVERT(datetime, T$RQDT, 101) AS Cust_Req_Date, T$COTP AS Order_type, T$CWAR AS Warehouse, 
                      '' AS Plant, 'CN' AS Site, T$STYP AS SALE_TYPE, T$FIDS AS Financial_Group, T$PSPL AS Unit_Panel, T$PRDN AS Product_Name, 
                      T$FLEX AS Flex_Order, T$ISEG AS Segment, T$DESC AS Segment_Description, T$CDEL AS Del_Code, '' AS Project_Type
FROM         vTFSOLP101180
WHERE     (T$INVD >= '01/01/2004') AND (T$CWAR = '')

GO

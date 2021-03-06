USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vMKT_Backlog_BR_New]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[vMKT_Backlog_BR_New]
AS 
 select  
--CONVERT(INT,substring([SO Number],2,10))   AS BaaN_SO,
convert(nvarchar(10), [SO Number] )  AS BaaN_SO,
 ''   AS  AST_SO,
 [Customer Order]  AS PO_No,
  Item   AS Prj_No,
 [CustomerPartNumber]  AS  Part_No,
  CONVERT(char,[Order date] ,101) AS PO_date,
  CONVERT(char,[Planned Delivery Date],101) AS Committed_Date,
  CONVERT(char,[Planned Delivery Date],101)  AS Cust_Req_Date,
  [Qty Ordered]  AS Order_Qty,
 [QtyOpen]  AS Bklog_Qty,
  Currency  AS Currency,
  Price   AS UnitPrice,
  round([QtyOpen] * Price,3,2)   AS  Bklog_Amt_US,
  0   AS  Bklog_SqFt,
  Country  AS  Ship_To_Cty,
  Customer_CEM_CODE    AS  Cust_Code,
  Customer_OEM  AS OEM_NAME,
  Customer_CEM  AS CEM_NAME,
  ''  AS Order_type,
  ''  AS Warehouse,
  ''  AS  Plant,
  'BR'     AS  Site,
  ''  AS SALE_TYPE,
 '' AS Unit_Panel,
'' AS Product_Name,
'' AS  Flex_Order,
'' AS  Segment,
'' AS Segment_Description,
''  AS Del_Code,
''  AS Project_Type
 FROM HKGNT137.MultekChi.dbo.vc_mkt_Backlog

GO

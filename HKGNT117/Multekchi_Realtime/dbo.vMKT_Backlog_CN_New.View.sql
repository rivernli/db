USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vMKT_Backlog_CN_New]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[vMKT_Backlog_CN_New]
AS 
SELECT  
--CONVERT(INT,T$ORNO) AS BaaN_SO,
convert(nvarchar(10), T$ORNO )  AS BaaN_SO,
 T$REFA AS AST_SO,
 T$EONO AS PO_No,
 T$ITEM AS Prj_No,
T$CUPN AS Part_No,
 T$PODT   AS PO_Date,
  T$DDTA  AS Committed_Date,
--  CONVERT(varchar(11),T$RQDT) AS Cust_Req_Date,
 T$RQDT AS Cust_Req_Date,
 T$OQUA AS Order_Qty,
  T$BQUA AS Bklog_Qty,
  T$CCUR AS Currency,
 T$PRIC AS UnitPrice,
  round(T$AMNT,3,2) AS Bklog_Amt_US,
T$AREA AS Bklog_SqFt,
T$ADDR AS Ship_To_Cty,
 T$CUNO AS Cust_Code,
T$ECDT AS OEM_NAME,
 T$CDSC AS CEM_NAME,
 T$COTP AS Order_type,
 a.T$CWAR AS Warehouse,
 b.T$PLNT  AS  Plant,
  'CN'  AS Site,
 T$STYP  AS SALE_TYPE,
T$PSPL AS Unit_Panel,
T$PRDN AS Product_Name,
T$FLEX AS  Flex_Order,
T$ISEG AS  Segment,
T$DESC AS Segment_Description,
T$CDEL AS Del_Code,
T$OTYP AS Project_Type
 FROM vTFSOLP100180  a, TFSCPP201180 b  where a.T$CWAR = b.T$CWAR
GO

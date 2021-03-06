USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vMKT_Shipment_CN]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vMKT_Shipment_CN]
as
 SELECT  
		--CONVERT(INT,T$ORNO) AS BaaN_SO,
		convert(nvarchar(10), T$ORNO )  AS BaaN_SO,
		--T$ORNO  AS BaaN_SO,
		T$ITEM AS Prj_No,
		T$CUPN AS Part_No,
		T$EONO AS PO_No,
	CONVERT(INT,T$INVN) AS Invoice_No,
		T$DQUA AS Del_Qty,
		CONVERT(char,T$INVD,101)  AS Invoice_Date,
		T$PRIC AS UnitPrice,
		T$CCUR AS Currency,
		T$AMNT AS Del_Amt_USD,
		T$AREA AS Del_SqFt,
		T$CODA AS Ship_To_Cty,
		T$CUNO AS Cust_Code,
		T$ENDC AS OEM_NAME,
		T$CDSC AS CEM_NAME,
		T$REFA AS AST_SO,
		CONVERT(char,T$PODT,101) AS PO_Date,
		CONVERT(char,T$RQDT,101) AS Cust_Req_Date,
		  T$COTP AS Order_type,
		 a.T$CWAR  AS Warehouse,
		b.T$PLNT  AS  Plant,
		 'CN'  AS Site, 
		T$STYP  AS SALE_TYPE,
		T$FIDS AS  Financial_Group,
		T$PSPL   AS Unit_Panel,
		T$PRDN AS  Product_Name,
		T$FLEX AS  Flex_Order,
		T$ISEG AS  Segment,
		T$DESC AS Segment_Description,
		T$CDEL AS Del_Code
	FROM dbo.vt_TFSOLP101180   a, TFSCPP201180 b 
 	WHERE	T$INVD >=  '01/01/2004'  and  a.T$CWAR = b.T$CWAR

GO

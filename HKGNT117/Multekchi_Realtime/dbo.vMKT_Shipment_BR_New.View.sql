USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vMKT_Shipment_BR_New]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vMKT_Shipment_BR_New]
as
SELECT  
		--CONVERT(INT,substring([SO Number],2,10)) AS BaaN_SO,
		--ltrim([SO Number] ,10)  AS BaaN_SO
		convert(nvarchar(10), [SO Number] )  AS BaaN_SO,
		Item			AS Prj_No,
		[CustomerPartNumber] 	AS Part_No,
		[Customer Order]	AS PO_No,
	CONVERT(INT,[Invoice Number])	AS Invoice_No,
		[Qty Shipped]		AS Del_Qty,
		CONVERT(datetime,[Invoice Date],101) AS Invoice_Date,
		Price			AS UnitPrice,
		Currency 		AS Currency,
		round([Qty Shipped] * Price,3,2) 	AS Del_Amt_USD,
		0 			AS Del_SqFt,
		Country			AS Ship_To_Cty,
		[Customer_CEM_CODE]		AS Cust_Code,
		[Customer_OEM]		AS OEM_NAME,
		[Customer_CEM]		AS CEM_NAME,
		''			AS AST_SO,
		 CONVERT(char,[Order Date],101) AS PO_Date,
		 CONVERT(char,[Planned Delivery Date],101) AS Cust_Req_Date,
		  ''  AS Order_type,
		  ''  AS Warehouse,
		  ''  AS  Plant,
		 'BR'  		AS Site,
		'' AS SALE_TYPE,
		'' AS  Financial_Group,
		'' AS Unit_Panel,
		'' AS  Product_Name,
		'' AS  Flex_Order,
		'' AS  Segment,
		'' AS Segment_Description,
		'' AS Del_Code,
		 '' AS Project_Type
 FROM HKGNT137.MultekChi.dbo.vc_mkt_Shipment
 WHERE	[Invoice Date]	>=  '12-01-2004'
GO

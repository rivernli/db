USE [multekChi_Realtime]
GO
/****** Object:  View [dbo].[vcr_Shipped_All_China]    Script Date: 11/06/2014 15:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vcr_Shipped_All_China]
AS

/*  
	这个VIEW很关键,是珠海SHIPPED_ALL的总源头.
	划分了每个字段的使用范围, 可以增加字段,不可以修改字段
	更新后,最好把117和FRANK上的同时更新, 这样保证117,111,FRANK上看到的数据都是一致的
*/
SELECT    
		--1. 开始  这是给FRANK上的VCR_SHIPPED_ALL用的字段 		
		T$LOCA AS Loc,
		T$ORNO AS SONum,
		T$PONO AS SOPos,
		T$DRCT AS DD,
		T$DDAT AS SHDate,				
		T$S1DA AS Sh1Date,
		T$SH11 AS Sh1,
		T$SHTM AS ShTime,	
		T$CUST AS CustNum,				
		T$BAD1 AS [Customer Name],		
		T$SHCU AS ShCust,
		T$SHCN AS ShCustName,
		T$CUNO AS InvCust,
		T$INSN AS InvCustName,			
		T$EONO AS CustPONum,
		T$BUSN AS BusSegNum,
		T$SEGM AS BusSeg,
		T$DUDT AS CDueDate,
		T$DODT AS DocDate,
		T$CUPN AS CPartNum,
		T$PARV AS CPartRev,
		T$CPID AS CprtID,
		T$PRIY AS Priority,
		T$ORDS AS OrdBrds,
		T$DQUA AS ShBrds,				
		CONVERT(DECIMAL(28,4),T$AMNT) AS ShDols,				
		T$NREE AS NRE,
		CONVERT(DECIMAL(28,4),T$AMNT) AS TtlSales,
		CONVERT(DECIMAL(28,4),T$PRIB) AS PriceB,
		CONVERT(DECIMAL(28,4),T$COST) AS CostB,
		CONVERT(DECIMAL(28,4),T$PROF) AS ProfitB,
		T$UPRI AS UP,
		CONVERT(DECIMAL(28,4),T$PRIP) AS PriceP,
		CONVERT(DECIMAL(28,4),T$COSP) AS CostP,
		CONVERT(DECIMAL(28,4),T$PROP) AS ProfitP,
		CONVERT(DECIMAL(28,4),T$PROT) AS ProfitPct,
		CONVERT(DECIMAL(28,4),T$PROI) AS ProfitT,
		CONVERT(VARCHAR(10),T$SODT,120) AS SODate,
		CONVERT(VARCHAR(8),T$SODT,108) AS SOTime,
		T$COTP AS SOType,
		T$ORDT AS OrdStat,
		T$INNU AS InRepNum,
		T$NAMA AS InRepName,
		T$ORNU AS OutRepNum,
		T$USNM AS OutRepName,
		T$CONN AS ContactNum,
		T$CONA AS ContactName,
		T$ITEM AS BaanItemNum,			
		CONVERT(FLOAT,T$PRON) AS ProToolNum,
		T$OEMM AS OEM,
		T$ENDC AS [OEM Name],			
		T$CARR AS Carrier,
		T$TRAN AS TrackNum,
		CONVERT(INT,T$LAYS) AS Lays,					
		T$SELC AS SelCode,
		CONVERT(DECIMAL(28,4),T$SHPA) AS ShPan,
		CONVERT(DECIMAL(28,4),T$SHLY) AS ShLays,
		CONVERT(DECIMAL(28,4),T$WIDB) AS WidthB,
		CONVERT(DECIMAL(28,4),T$LENB) AS LengthB,
		CONVERT(DECIMAL(28,4),T$AREB) AS AreaB,
		CONVERT(DECIMAL(28,4),T$WIDP) AS WidthP,
		CONVERT(DECIMAL(28,4),T$LENP) AS LengthP,
		CONVERT(DECIMAL(28,4),T$AREP) AS AreaP,
		T$SUBS AS Subs,
		T$BASM AS BaseMtl,
		T$HOLB AS HolesB,
		T$HOLP AS HolesP,
		T$SMAH AS SmallHole,
		T$THIC AS Thick,
		T$ASPR AS AspRatio,
		T$SHBD AS ShBrdsDD,
		T$SHDD AS ShPanDD,
		T$SHAY AS ShLaysDD,
		CONVERT(DECIMAL(28,4),T$AMNT) AS ShDolsDD,           
		T$ATLC AS ATLCusNum,
		T$SHPN AS ShipName,
		T$UPAR AS UPArr,
		T$BRAR AS BrdPerArr,
		CONVERT(DECIMAL(28,4),T$AREA) AS AreaA,
		T$CRRT AS CPRTSID,
		T$INVB AS InvBP,
		--CONVERT(VARCHAR(20),CONVERT(NUMERIC(20,0),T$INVN)) AS InvBPName,
		'' AS InvBPName,
		T$CPRT AS CprtID_PDDim,
		T$PRTP AS ProToolNum_PDDim,
		T$SOSE AS SOSeq,
		CONVERT(DECIMAL(28,4),T$AMNT) AS ShDols_loc,
		T$NREL AS NRE_loc,
		CONVERT(DECIMAL(28,4),T$AMNT) AS TtlSales_loc,
		CONVERT(DECIMAL(28,4),T$PRIB) AS PriceB_loc,
		CONVERT(DECIMAL(28,4),T$COSL) AS CostB_loc,				
		CONVERT(DECIMAL(28,4),T$PROL) AS ProfitB_loc,
		CONVERT(DECIMAL(28,4),T$PRIL) AS PriceP_loc,
		CONVERT(DECIMAL(28,4),T$COPL) AS CostP_loc,
		CONVERT(DECIMAL(28,4),T$PRPL) AS ProfitP_loc,
		CONVERT(DECIMAL(28,4),T$PRFP) AS ProfitPct_loc,
		CONVERT(DECIMAL(28,4),T$PRFL) AS ProfitT_loc,
		CONVERT(DECIMAL(28,4),T$AMNT) AS ShDolsDD_loc,          
		T$ITEM AS Item,
		CONVERT(VARCHAR(10),T$DDAT,120) AS ShDateTime,
		t$srnb AS ShipID,					
		T$PLNT AS Plant,					
		T$BUSU AS Bus_Unit,
		--1. 结束  这是给FRANK上的VCR_SHIPPED_ALL用的字段 
				
		--2. 开始  这是给FRANK上的SHIP ADDRESS用的字段 	
		ISNULL(t$namb,'') AS ShAddr1,
		ISNULL(t$namc,'') AS ShAddr2,
		ISNULL(t$namd,'') AS ShAddr3,
		ISNULL(t$name,'') AS ShCity,
		ISNULL(t$namf,'') AS ShAaddr4,
		--ISNULL(t$cste,'') AS ShState,  --102中没有这个字段,等待CHARLIE添加
		'' AS ShState,					 --102中没有这个字段,等待CHARLIE添加, FRANK中是直接赋""
		ISNULL(t$pstc,'') AS ShZip,
		ISNULL(t$ccty,'') AS ShCountry,
		ISNULL(t$crte,'') AS ShRoute,
		ISNULL(t$cadr,'') AS ShAddrCode,
		--2. 结束  这是给FRANK上的SHIP ADDRESS用的字段 	
		
		--3. 开始 FOR MKT SHIPMENT
		T$INVD AS Invoice_Date,
		T$PRIC AS UnitPrice,
		T$CCUR AS Currency, 
		T$CODA AS Ship_To_Cty, 
		T$CDSC AS CEM_NAME, 
		T$REFA AS AST_SO, 
		CONVERT(datetime, T$PODT,101) AS PO_Date, 
		CONVERT(datetime, T$RQDT, 101) AS Cust_Req_Date, 
		T$CWAR AS Warehouse, 
		T$STYP AS SALE_TYPE, 
		T$FIDS AS Financial_Group, 
		T$PSPL AS Unit_Panel, 
		T$PRDN AS Product_Name, 
		T$FLEX AS Flex_Order, 
		T$CDEL AS Del_Code, 
		ISNULL(T$OTYP, '') AS Project_Type, 
		T$INVN AS InvoiceNum,
		T$ISEG as Product_Line_Code , 
		T$DESC as Product_Line_Desc,		
		--3. 结束 FOR MKT SHIPMNT
		
		T$NAMA AS SalesMan
FROM    multekChi_Realtime.dbo.TFSOLP102180
/*
WHERE T$ITEM NOT LIKE '18%'   --这些单是内部交易，买卖材料的，要过滤掉
	AND NOT (T$ORNO LIKE '7%' AND T$COMP = '180'  )  --过滤掉180的SCRAP SALES 
*/
WHERE t$cotp <>'SCS'
	AND t$cotp <>'SL8'
	AND t$cotp <>'RSS'
	AND t$cotp <>'SNE'		-- Cancel it by rivern 2013-06-03 from OP request , it's internal sales
	AND t$cotp <>'MSS'		-- Cancel by rivern 2014-08-28 B2F卖材料给内部的
	AND t$cotp <>'MRS'		-- Cancel by rivern 2014-08-28 B2F卖材料给内部的
GO

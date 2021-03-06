USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_GetRawData]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_GetRawData] 
	@RptDate DATETIME
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT 
       [T$ORNO] AS SO#
      ,[T$PONO] AS POS#
      ,[T$YDSC] AS FiscalYear
      ,[T$PRID] AS FiscalPeriod
      ,[T$CUDL] AS CustDel#
      ,[T$CODE] AS CustCode
      ,[T$CUST] AS CustomerName
      ,[T$ITEM] AS Project
      ,[T$PRDN] AS ProjectName
      ,[T$OEMA] AS OEM
      ,[T$DSCA] AS CustPN
      ,[T$CRFN] AS CRF#
      ,[T$COTP] AS OrderType
      ,[T$CWAR] AS 'W/H'
      ,[T$DDTA] AS PMCCommitDate
      ,
		(CASE
			WHEN [T$SFLG]=1 THEN 'shipment'
			WHEN [T$SSTA]=1 THEN 'production'
		END) AS OnHoldType
      ,[T$QTYA] AS OnHoldQty
      ,[T$AMNT] AS Amount
      ,[T$SQFT] AS Sqft
      ,[T$PLNT] AS Plant
      ,[T$OHDT] AS OnHoldDate
      ,[T$OHNO] AS RefNO
      ,REPLACE([T$DPAT],'FIN','Payment past due') AS Department
      ,[T$CSMA] AS CS
      ,[T$SALM] AS SalesMan
      ,[T$EONO] AS CustPO
      ,[T$DIM1] AS Dimension
      --,[T$REFCNTD]
      --,[T$REFCNTU]
  FROM [dbo].[TFSOLP120180]
  WHERE T$DATE = @RptDate - 1

END

GO

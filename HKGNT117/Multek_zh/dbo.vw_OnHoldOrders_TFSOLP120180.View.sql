USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_OnHoldOrders_TFSOLP120180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[vw_OnHoldOrders_TFSOLP120180]
AS
--SELECT [T$DATE]
--      ,[T$ORNO]
--      ,[T$PONO]
--      ,[T$YDSC]
--      ,[T$PRID]
--      ,[T$CUDL]
--      ,[T$CODE]
--      ,[T$CUST]
--      ,[T$ITEM]
--      ,[T$PRDN]
--      ,[T$OEMA]
--      ,[T$DSCA]
--      ,[T$CRFN]
--      ,[T$COTP]
--      ,[T$CWAR]
--      ,[T$DDTA]
--      ,[T$SFLG]
--      ,[T$SSTA]
--      ,[T$QTYA]
--      ,[T$AMNT]
--      ,[T$SQFT]
--      ,[T$PLNT]
--      ,[T$OHDT]
--      ,[T$OHNO]
--      ,[T$DPAT]
--      ,[T$CSMA]
--      ,[T$SALM]
--      ,[T$EONO]
--      ,[T$DIM1]
--      ,[T$REFCNTD]
--      ,[T$REFCNTU]
--      ,'On Hold' AS [T$FLAG]
--  FROM [TFSOLP120180]
--  UNION ALL
  SELECT [T$DATE]
      ,[T$ORNO]
      ,[T$PONO]
      ,[T$YDSC]
      ,[T$PRID]
      ,[T$CUDL]
      ,[T$CODE]
      ,[T$CUST]
      ,[T$ITEM]
      ,[T$PRDN]
      ,[T$OEMA]
      ,[T$DSCA]
      ,[T$CRFN]
      ,[T$COTP]
      ,[T$CWAR]
      ,[T$DDTA]
      ,(CASE [T$SSTA] WHEN 'Production' THEN 1 ELSE 0 END) AS [T$SFLG]
      ,(CASE [T$SSTA] WHEN 'Shipment' THEN 1 ELSE 0 END) AS [T$SSTA]
      ,[T$QTYA]
      ,[T$AMNT]
      ,[T$SQFT]
      ,REPLACE(REPLACE(REPLACE([T$PLNT],'2F','B2F'),'P2','B1'),'HK','VVI') AS [T$PLNT]
      ,[T$OHDT]
      ,[T$OHNO]
      ,[T$DPAT]
      ,[T$CSMA]
      ,[T$SALM]
      ,[T$EONO]
      ,[T$DIM1]
      ,[T$REFCNTD]
      ,[T$REFCNTU]
      ,REPLACE([T$FLAG],'Onhold','On Hold') AS [T$FLAG]
  FROM [TFSOLP123180]







GO

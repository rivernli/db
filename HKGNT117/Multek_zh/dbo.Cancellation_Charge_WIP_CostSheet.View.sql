USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Cancellation_Charge_WIP_CostSheet]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Cancellation_Charge_WIP_CostSheet]
AS
SELECT (CASE LEFT(RIGHT(T$PJNO,2),1) WHEN 'W' THEN 'B3' 
									WHEN 'F'  THEN '2F'
									WHEN 'P'  THEN 'B3'
									WHEN 'V'  THEN 'B4'
									WHEN 'M'  THEN 'B5'
									WHEN 'Z'  THEN 'HK'
									WHEN 'X'  THEN 'B1'
									WHEN 'Y'  THEN 'B1' END) as T$PLNT,
	LEFT(T$PJNO,8) AS T$PJNO,LEFT(T$CWOC,3) AS T$CWOC,T$PONO,CAST(T$AMTR AS DECIMAL(18,4)) AS T$AMTR
FROM FactoryLoading.dbo.TFSBOM422180
GO

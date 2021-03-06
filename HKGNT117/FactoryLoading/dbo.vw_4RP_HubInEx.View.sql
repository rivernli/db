USE [FactoryLoading]
GO
/****** Object:  View [dbo].[vw_4RP_HubInEx]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_4RP_HubInEx]
AS
SELECT     CONVERT(varchar(8), T$DATE, 112) AS iDate, T$LOCA AS location, T$DACA AS OEM, T$CSGS AS cusId, T$ITEM AS partNumber, T$AMNT AS amount, T$CCTY AS region,
                       CASE WHEN T$PLNT = 'p2' THEN 'B1' ELSE t$plnt END AS plant, CONVERT(varchar(8), T$HKDT, 112) AS HKDate
FROM         dbo.TFSOLP104180


GO

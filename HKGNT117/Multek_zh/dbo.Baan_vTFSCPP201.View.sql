USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Baan_vTFSCPP201]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Baan_vTFSCPP201]
AS
SELECT * FROM FactoryLoading.dbo.TFSCPP201180
UNION ALL
SELECT * FROM FactoryLoading.dbo.TFSCPP201183
GO

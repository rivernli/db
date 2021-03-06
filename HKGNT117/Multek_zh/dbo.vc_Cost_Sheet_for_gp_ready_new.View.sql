USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_Cost_Sheet_for_gp_ready_new]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vc_Cost_Sheet_for_gp_ready_new]
AS
SELECT	T$PJNO,
		T$SERN,
		T$PLNT,
		CAST(T$BOMC AS DECIMAL(18,2)) AS BOMC ,
		CAST(T$SQFT AS DECIMAL(18,2)) AS SQFT,
		CAST(T$BUSP AS DECIMAL(18,2)) AS T$BUSP,
		CAST(T$EDMC AS DECIMAL(18,2)) AS EDMCost,
		CAST(T$MRBY AS DECIMAL(18,2)) AS MRB_Yield,
		CAST(T$DLIU AS DECIMAL(18,2)) AS T$DLIU,
		CAST(T$SUBVAR AS DECIMAL(18,2)) AS VAR_MOH,
		CAST(T$DEPRE AS DECIMAL(18,2)) AS Depreciation,
		CAST(T$GSRU AS DECIMAL(18,2)) AS GA,
		CAST(T$FIXC AS DECIMAL(18,2)) AS IDL_COST
FROM dbo.TFSOLP150180

GO

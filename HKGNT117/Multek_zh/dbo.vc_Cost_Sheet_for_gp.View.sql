USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_Cost_Sheet_for_gp]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vc_Cost_Sheet_for_gp]
AS
SELECT	A.T$PJNO,
		A.T$SERN,
		T$PLNT,
		CAST((T$BOMC/(T$UNST*T$CBPN)) AS DECIMAL(18,2)) AS BOMC ,
		CAST((T$AREA / T$CBPN / T$UNST) AS DECIMAL(18,2)) AS SQFT,
		CAST((100-T$BUSP) AS DECIMAL(18,2)) AS T$BUSP,
		CAST((EDMCost/((100-T$BUSP)/100)) AS DECIMAL(18,2)) AS EDMCost,
		cast((CAST((T$BOMC/(T$UNST*T$CBPN)) AS DECIMAL(18,4))/((100-T$BUSP)/100)-CAST((T$BOMC/(T$UNST*T$CBPN)) AS DECIMAL(18,4))) AS DECIMAL(18,2)) AS MRB_Yield,
		CAST((T$DLIU*0.85/((100-T$BUSP)/100)*1.14) AS DECIMAL(18,2)) AS T$DLIU,
		--CAST((T$MDSU+T$LDIU+T$LDMU)*0.85/((100-T$BUSP)/100)-0 AS DECIMAL(18,2))AS VAR_MOH,  --need to - c28
		CAST(VAR_MOH/(T$UNST*T$CBPN) AS DECIMAL(18,2)) AS VAR_MOH,
		CAST(DA_Cost/(T$UNST*T$CBPN) AS DECIMAL(18,2)) AS Depreciation,
		CAST(T$GSRU  AS DECIMAL(18,2)) AS GA,
		CAST(IDL_COST/(T$UNST*T$CBPN) AS DECIMAL(18,2)) AS IDL_COST
		FROM dbo.Cost_Sheet_Query_TFSBOM400180 AS A,
		(
			SELECT T$PJNO,MAX(T$SERN) AS T$SERN FROM dbo.Cost_Sheet_Query_TFSBOM400180 GROUP BY T$PJNO
		) B
WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN
--AND A.T$PJNO = '$1AT34U3P1' 
GO

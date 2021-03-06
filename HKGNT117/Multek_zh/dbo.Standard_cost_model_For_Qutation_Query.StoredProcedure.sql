USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Standard_cost_model_For_Qutation_Query]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Standard_cost_model_For_Qutation_Query] 
	-- Add the parameters for the stored procedure here
--@Project	NVARCHAR(13)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Get ALL standard cost project
		TRUNCATE TABLE dbo.Standard_Cost_Model_fsbom400
		INSERT INTO dbo.Standard_Cost_Model_fsbom400
		(
			T$PJNO,T$SERN,T$CRID,T$CRDT,T$LCDT,T$STAT,T$MBSP,T$ODSP,T$STSP,T$MASP,T$BUSP,T$CESU,T$CESP,T$CESS,T$CISU,
			T$CISP,T$CISS,T$DLIU,T$DLIP,T$DLIS,T$ILIU,T$ILIP,T$ILIS,T$MDSU,T$MDSP,T$MDSS,T$LDIU,T$LDIP,T$LDIS,T$LDMU,
			T$LDMP,T$LDMS,T$TCIU,T$TCIP,T$TCIS,T$GSRU,T$GSRP,T$GSRS,T$PRIC,T$MCSR,T$PRMG,T$PMGR,T$EPRP,T$EPPP,T$EPPC,
			T$VERS,T$AVER,T$TCUU,T$TCUP,T$TCUS,T$FDIR,T$BTYP,T$ATYP,T$TQTY,T$MRB1,T$MRB4,T$MR12,T$MR13,T$TXTA,T$PLNT,
			T$UFLG,T$SCRE,T$DCFA,T$CODA,T$COTI,T$PVER,T$MVER,T$OU13,T$APRJ,T$TSCU,T$TSCP,T$TSCS,T$QSTA,T$PLEN,T$PWID,
			T$UNST,T$STPL,T$PLUP
		)
		SELECT  
			T$PJNO,T$SERN,T$CRID,T$CRDT,T$LCDT,T$STAT,T$MBSP,T$ODSP,T$STSP,T$MASP,T$BUSP,T$CESU,T$CESP,T$CESS,T$CISU,
			T$CISP,T$CISS,T$DLIU,T$DLIP,T$DLIS,T$ILIU,T$ILIP,T$ILIS,T$MDSU,T$MDSP,T$MDSS,T$LDIU,T$LDIP,T$LDIS,T$LDMU,
			T$LDMP,T$LDMS,T$TCIU,T$TCIP,T$TCIS,T$GSRU,T$GSRP,T$GSRS,T$PRIC,T$MCSR,T$PRMG,T$PMGR,T$EPRP,T$EPPP,T$EPPC,
			T$VERS,T$AVER,T$TCUU,T$TCUP,T$TCUS,T$FDIR,T$BTYP,T$ATYP,T$TQTY,T$MRB1,T$MRB4,T$MR12,T$MR13,T$TXTA,T$PLNT,
			T$UFLG,T$SCRE,T$DCFA,T$CODA,T$COTI,T$PVER,T$MVER,T$OU13,T$APRJ,T$TSCU,T$TSCP,T$TSCS,T$QSTA,T$PLEN,T$PWID,
			T$UNST,T$STPL,T$PLUP		
		FROM FACTORYLOADING.DBO.TFSBOM400180 
		WHERE T$APRJ <> ''

	-- get MI information 
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#TempMI') AND TYPE = 'U')
			DROP TABLE #TempMI

		SELECT MIN(T$SIDE) AS SIDE,LEFT(T$PJNO,10) AS PJNO,0 AS UNST,0 AS PANW,0 AS PANL,0 AS AREA,0 AS CBPN,0 AS PNWN,0 AS PNLN
		INTO #TempMI
		FROM factoryloading.dbo.tfsami002180 
		WHERE LEFT(T$PJNO,10) IN (SELECT T$APRJ FROM dbo.Standard_Cost_Model_fsbom400)
		GROUP BY T$PJNO

		ALTER TABLE #TempMI	  ALTER COLUMN PANW FLOAT
		ALTER TABLE #TempMI   ALTER COLUMN PANL FLOAT
		ALTER TABLE #TempMI   ALTER COLUMN AREA FLOAT
		ALTER TABLE #TempMI   ALTER COLUMN PNWN FLOAT
		ALTER TABLE #TempMI   ALTER COLUMN PNLN FLOAT
		ALTER TABLE #TempMI	  ADD T$CUTN	NVARCHAR(100)
		ALTER TABLE #TempMI	  ADD UTIL	FLOAT

		UPDATE #TempMI SET	UNST = T$UNST,
							PANW = T$PANW,
							PANL = T$PANL,
							AREA =CAST(T$PANL * T$PANW / 92900 AS DECIMAL(18,4)),
							CBPN = T$CBPN,
							PNWN = CAST(T$PANW/ 25.4 AS DECIMAL(18,4)),
							PNLN = CAST(T$PANL/ 25.4 AS DECIMAL(18,4)),
							T$CUTN = A.T$CUTN,
							UTIL = A.T$BRDL * A.T$BRDW * A.T$CBPN * 100 / T$PANL 
		FROM #TempMI,FACTORYLOADING.DBO.TFSAMI002180 AS A
		WHERE #TempMI.SIDE = A.T$SIDE AND #TempMI.PJNO = LEFT(A.T$PJNO,10)

	-- Update MI information 
		UPDATE Standard_Cost_Model_fsbom400 SET MI_UNST = A.UNST,
												MI_PANW = A.PANW,
												MI_PANL = A.PANL,
												MI_AREA = A.AREA,
												MI_CBPN = A.CBPN,
												MI_PNWN = A.PNWN,
												MI_PNLN = A.PNLN,
												MI_UTIL = A.UTIL
		FROM	#TempMI AS A,Standard_Cost_Model_fsbom400 AS B
		WHERE	A.PJNO = B.T$APRJ

	-- GET BOM COST , ABOUT 16S
		UPDATE Standard_Cost_Model_fsbom400 SET BOM_COST_UNIT = B.BOM_COST_Unit,
												BOM_COST_PNL  = B.BOM_COST_Pnl,
												BOM_COST_SQFT = B.BOM_COST_SQFT
		FROM Standard_Cost_Model_fsbom400 AS A,
		(
			SELECT T$PJNO,T$SERN,CAST(SUM(T$COSU) AS DECIMAL(18,4)) AS BOM_COST_Unit,CAST(SUM(T$COSP) AS DECIMAL(18,4))AS BOM_COST_Pnl,CAST(SUM(T$COSS) AS DECIMAL(18,4)) AS BOM_COST_SQFT
			FROM FACTORYLOADING.DBO.TFSBOM401180
			WHERE T$META IN('Copper Foil','Laminate','Prepreg','RCC Foil','Coin','Adhesive','FCCL','Coverlay','Stiffener','Sheildling Film','SMD') 
			GROUP BY T$PJNO,T$SERN
		) AS B
		WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

	-- GET EDM COST , ABOUT 16S
		UPDATE Standard_Cost_Model_fsbom400 SET EDM_COST_UNIT = B.EDM_COST_Unit,
												EDM_COST_PNL  = B.EDM_COST_Pnl,
												EDM_COST_SQFT = B.EDM_COST_SQFT
		FROM Standard_Cost_Model_fsbom400 AS A,
		(
			SELECT T$PJNO,T$SERN,CAST(SUM(T$COSU) AS DECIMAL(18,4)) AS EDM_COST_Unit,CAST(SUM(T$COSP) AS DECIMAL(18,4))AS EDM_COST_Pnl,CAST(SUM(T$COSS) AS DECIMAL(18,4)) AS EDM_COST_SQFT
			FROM FACTORYLOADING.DBO.TFSBOM401180
			WHERE T$META NOT IN('Copper Foil','Laminate','Prepreg','RCC Foil','Coin','Adhesive','FCCL','Coverlay','Stiffener','Sheildling Film','SMD') 
			GROUP BY T$PJNO,T$SERN
		) AS B
		WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

	-- Get direct labor cost 
		UPDATE Standard_Cost_Model_fsbom400 SET DL_COST_PNL = B.DL_COST_PNL
		FROM	Standard_Cost_Model_fsbom400 AS A,dbo.Cost_Sheet_Query_TFSBOM421180 AS B
		WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

	-- Get variable MOH cost 
		UPDATE Standard_Cost_Model_fsbom400 SET VAR_MOH_UNIT = B.VAR_MOH
		FROM	Standard_Cost_Model_fsbom400 AS A,dbo.Cost_Sheet_Query_TFSBOM421180 AS B
		WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

	-- Get indirect labor cost 
		UPDATE Standard_Cost_Model_fsbom400 SET IDL_COST_PNL = B.IDL_COST_PNL
		FROM	Standard_Cost_Model_fsbom400 AS A,dbo.Cost_Sheet_Query_TFSBOM421180 AS B
		WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

	-- Update 

	-- Get Depreciation cost 
		UPDATE Standard_Cost_Model_fsbom400 SET DA_COST_PNL = B.DA_COST_PNL
		FROM	Standard_Cost_Model_fsbom400 AS A,dbo.Cost_Sheet_Query_TFSBOM421180 AS B
		WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

	-- Update Subtotal fiexed cost
		UPDATE Standard_Cost_Model_fsbom400 SET SUB_FIX_PNL = IDL_COST_PNL + DA_COST_PNL + T$GSRP 

	-- Update Totals cost
		UPDATE Standard_Cost_Model_fsbom400 SET TOT_COST_PNL = BOM_COST_PNL + EDM_COST_PNL + DL_COST_PNL +SUBCON_PNL + SUB_FIX_PNL

	-- Get Subcontract information

END


GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_AutoUpdate_V_fsbom40X180]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Sheet_Query_AutoUpdate_V_fsbom40X180]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@COUNT INT

    -- Insert statements for procedure here
	-- Update tfsbom401180 from factory loading
		SELECT @COUNT = COUNT(*) FROM FactoryLoading.dbo.TFSBOM401180

		IF @COUNT > 0
			BEGIN
				TRUNCATE TABLE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM401180

				INSERT INTO Cost_Sheet_Query_TFSBOM401180
				SELECT	T401.T$PJNO,T401.T$SERN,T400.T$AVER,T400.T$VERS,T401.T$SQNO,T401.T$META,
						CAST(T401.T$COSP AS DECIMAL(18,4)) AS T$COSP,
						CAST(T401.T$COSU AS DECIMAL(18,4)) AS T$COSU,
						CAST(T401.T$COSS AS DECIMAL(18,4)) AS T$COSS,
						CAST(T401.T$COPR AS DECIMAL(18,2)) AS T$COPR
				FROM	FactoryLoading.dbo.TFSBOM401180 AS T401
					LEFT JOIN FactoryLoading.dbo.TFSBOM400180 AS T400
					ON	T401.T$PJNO = T400.T$PJNO
					AND	T401.T$SERN = T400.T$SERN
				ORDER BY T401.T$PJNO,T401.T$SERN,T401.T$SQNO
			END
--		END

	--  Update tfsbom400180
		SET @COUNT = 0
		SELECT @COUNT = COUNT(*) FROM FactoryLoading.dbo.TFSBOM400180
		IF @COUNT > 0
			BEGIN
				TRUNCATE TABLE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#Temp') AND TYPE = 'U')
					DROP TABLE #TEMP
				
				-- GET MI DATA
				SELECT MIN(T$SIDE) AS SIDE,LEFT(T$PJNO,10) AS PJNO,0 AS UNST,0 AS PANW,0 AS PANL,0 AS AREA,0 AS CBPN,0 AS PNWN,0 AS PNLN
				INTO #TEMP
				FROM factoryloading.dbo.tfsami002180 GROUP BY T$PJNO
				ALTER TABLE #TEMP	ALTER COLUMN PANW FLOAT
				ALTER TABLE #TEMP   ALTER COLUMN PANL FLOAT
				ALTER TABLE #TEMP   ALTER COLUMN AREA FLOAT
				ALTER TABLE #TEMP   ALTER COLUMN PNWN FLOAT
				ALTER TABLE #TEMP   ALTER COLUMN PNLN FLOAT
				ALTER TABLE #TEMP	ADD T$CUTN	NVARCHAR(100)

				UPDATE #TEMP SET UNST = T$UNST,PANW = T$PANW,PANL = T$PANL,AREA =CAST(T$PANL * T$PANW / 92900 AS DECIMAL(18,4)),CBPN = T$CBPN,PNWN = CAST(T$PANW/ 25.4 AS DECIMAL(18,4)),PNLN = CAST(T$PANL/ 25.4 AS DECIMAL(18,4)),T$CUTN = A.T$CUTN
				FROM #TEMP,FACTORYLOADING.DBO.TFSAMI002180 AS A
				WHERE #TEMP.SIDE = A.T$SIDE AND #TEMP.PJNO = LEFT(A.T$PJNO,10)

				INSERT INTO Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				(	
					T$PJNO,	T$SERN,	T$CRID,	T$CRDT,	T$LCDT,	T$STAT,	T$MBSP,	T$ODSP,	T$STSP,	T$MASP,	
					T$BUSP,	T$CESU,	T$CESP,	T$CESS,	T$CISU,	T$CISP,	T$CISS,	T$DLIU,	T$DLIP,	T$DLIS,	
					T$ILIU,	T$ILIP,	T$ILIS,	T$MDSU,	T$MDSP,	T$MDSS,	T$LDIU,	T$LDIP,	T$LDIS,	T$LDMU,	
					T$LDMP,	T$LDMS,	T$TCIU,	T$TCIP,	T$TCIS,	T$GSRU,	T$GSRP,	T$GSRS,	T$PRIC,	T$MCSR,	
					T$PRMG,	T$PMGR,	T$EPRP,	T$EPPP,	T$EPPC,	T$VERS,	T$AVER,	T$TCUU,	T$TCUP,	T$TCUS,	
					T$FDIR,	T$BTYP,	T$ATYP,	T$TQTY,	T$MRB1,	T$MRB4,	T$MR12,	T$MR13,	T$TXTA,	T$PLNT,	
					T$UFLG,	T$SCRE,	T$DCFA,	T$CODA,	T$COTI,	T$PVER,	T$MVER,	T$OU13, T$REFCNTD,T$REFCNTU,
					T$CSGP,	T$DSCA, T$APRJ, T$PLUP, T$STPL,	T$TSCU,	T$TSCP,	T$TSCS

				)
				SELECT 
					A.T$PJNO,	A.T$SERN,	A.T$CRID,	A.T$CRDT,	A.T$LCDT,	A.T$STAT,	A.T$MBSP,	A.T$ODSP,	A.T$STSP,	A.T$MASP,	
					A.T$BUSP,	A.T$CESU,	A.T$CESP,	A.T$CESS,	A.T$CISU,	A.T$CISP,	A.T$CISS,	A.T$DLIU,	A.T$DLIP,	A.T$DLIS,	
					A.T$ILIU,	A.T$ILIP,	A.T$ILIS,	A.T$MDSU,	A.T$MDSP,	A.T$MDSS,	A.T$LDIU,	A.T$LDIP,	A.T$LDIS,	A.T$LDMU,	
					A.T$LDMP,	A.T$LDMS,	A.T$TCIU,	A.T$TCIP,	A.T$TCIS,	A.T$GSRU,	A.T$GSRP,	A.T$GSRS,	A.T$PRIC,	A.T$MCSR,	
					A.T$PRMG,	A.T$PMGR,	A.T$EPRP,	A.T$EPPP,	A.T$EPPC,	A.T$VERS,	A.T$AVER,	A.T$TCUU,	A.T$TCUP,	A.T$TCUS,	
					A.T$FDIR,	A.T$BTYP,	A.T$ATYP,	A.T$TQTY,	A.T$MRB1,	A.T$MRB4,	A.T$MR12,	A.T$MR13,	A.T$TXTA,	A.T$PLNT,	
					A.T$UFLG,	A.T$SCRE,	A.T$DCFA,	A.T$CODA,	A.T$COTI,	A.T$PVER,	A.T$MVER,	A.T$OU13,	A.T$REFCNTD,A.T$REFCNTU,
					C.T$CSGP,C.T$DSCA,A.T$APRJ,A.T$PLUP,A.T$STPL,	A.T$TSCU,	A.T$TSCP,	A.T$TSCS
					FROM FactoryLoading.dbo.TFSBOM400180 AS A
						LEFT JOIN  FactoryLoading.dbo.TTIITM001180 AS B ON LEFT(A.T$PJNO,8) = B.T$ITEM
						LEFT JOIN  FactoryLoading.dbo.TTCMCS044180 AS C	ON C.T$CSGP = B.T$CSGS
				
				-- Insert MI data to final table 
				UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET T$UNST = A.UNST,
					T$PANW = A.PANW,
					T$PANL = A.PANL,
					T$AREA = A.AREA,
					T$CBPN = A.CBPN,
					T$PNWN = A.PNWN,
					T$PNLN = A.PNLN,
					T$CUTN = A.T$CUTN
				FROM #TEMP AS A,Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS B
				WHERE LEFT(A.PJNO,10) = B.T$PJNO
				
				---- Insert Standard cost sheet MI data
				--UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				--SET T$UNST = A.UNST,
				--	T$PANW = A.PANW,
				--	T$PANL = A.PANL,
				--	T$AREA = A.AREA,
				--	T$CBPN = A.CBPN,
				--	T$PNWN = A.PNWN,
				--	T$PNLN = A.PNLN
				--FROM #TEMP AS A,Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS B
				--WHERE LEFT(A.PJNO,10) = B.T$APRJ AND B.T$APRJ IS NOT NULL AND B.T$APRJ <> ''
				
				-- Insert cost sheet detail others data
				UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET	T$BOMC = CAST(A.BomCost AS DECIMAL(18,4)),
					DA_Cost = CAST(A.DA_COST_PNL AS DECIMAL(18,4)),
					VAR_MOH = CAST(A.VAR_MOH AS DECIMAL(18,4)),
					IDL_COST = CAST(A.IDL_COST_PNL AS DECIMAL(18,4))
				FROM	Multek_ZH.dbo.Cost_Sheet_Query_TFSBOM421180 AS A,
						Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS C
				WHERE	A.T$PJNO = C.T$PJNO AND A.T$SERN = C.T$SERN

				-- UPDATE STANDARD BOM COST 
				UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET	T$BOMC = CAST(A.BomCost AS DECIMAL(18,4)),
					DA_Cost = CAST(A.DA_COST_PNL AS DECIMAL(18,4)),
					VAR_MOH = CAST(A.VAR_MOH AS DECIMAL(18,4))
				FROM	Multek_ZH.dbo.Cost_Sheet_Query_TFSBOM421180 AS A,
						Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS C
				WHERE	A.T$PJNO = C.T$APRJ AND A.T$SERN = C.T$SERN AND C.T$APRJ <> ''

				-- udpate edm cost 
				UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET EDMCost = B.T$COSU
				FROM	Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS A,
					(
						SELECT T$PJNO,T$SERN,SUM(T$COSU) AS T$COSU FROM dbo.Cost_Sheet_Query_TFSBOM401180 
						WHERE	T$META NOT IN ('Copper Foil','Laminate','Prepreg','RCC Foil','Coin','Adhesive','FCCL','Coverlay','Stiffener','Sheildling Film','SMD')
						GROUP BY T$PJNO,T$SERN
					) B
				WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN

				-- udpate bom calc date
				UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET	T$DATE = B.T$DATE
				FROM	Multek_ZH.dbo.Cost_Sheet_Query_TFSBOM202180 AS B,
						Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS C
				WHERE	(B.T$PITM = C.T$PJNO+'-00' OR B.T$PITM = C.T$APRJ+'-00') AND B.T$VERS = C.T$VERS
				
				-- update quick cost mi information
				UPDATE  Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET T$UNST = US,
					T$PANW = A.T$WRAP,
					T$PANL = A.T$FILL,
					T$AREA = CAST((A.T$WRAP * A.T$FILL)/92900 AS DECIMAL(18,4)),
					T$CBPN = PANLSET,
					T$PNWN = CAST((A.T$WRAP/25.4) AS DECIMAL(18,4)),
					T$PNLN = CAST((A.T$FILL/25.4) AS DECIMAL(18,4))
				FROM dbo.vc_Quick_Cost_MI AS A,Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS B,dbo.vc_Quick_Cost_TFSBOM400180 AS C
				WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN
				AND	  A.T$PJNO = C.T$PJNO AND A.T$SERN = C.T$SERN
				
				-- update simple cost mi information
				UPDATE  Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET T$UNST = A.T$UNST,
					T$PANW = A.T$PWID,
					T$PANL = A.T$PLEN,
					T$AREA = CAST((A.T$PWID * A.T$PLEN)/92900 AS DECIMAL(18,4)),
					T$CBPN = A.T$STPL,
					T$PNWN = CAST((A.T$PWID/25.4) AS DECIMAL(18,4)),
					T$PNLN = CAST((A.T$PLEN/25.4) AS DECIMAL(18,4))
				FROM Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS B,FactoryLoading.dbo.TFSBOM400180 AS A,dbo.vc_Simple_Cost_TFSBOM400180 AS C
				WHERE	A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN
				AND		A.T$PJNO = C.T$PJNO AND A.T$SERN = C.T$SERN
				
				-- UPDATE STANDARD MI DATA
				UPDATE Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180
				SET T$UNST = A.UNST,
					T$PANW = A.PANW,
					T$PANL = A.PANL,
					T$AREA = A.AREA,
					T$CBPN = A.CBPN,
					T$PNWN = A.PNWN,
					T$PNLN = A.PNLN
				FROM #TEMP AS A,Multek_ZH.DBO.Cost_Sheet_Query_TFSBOM400180 AS B
				WHERE LEFT(A.PJNO,10) = B.T$APRJ and B.T$APRJ <> ''

			END
END










GO

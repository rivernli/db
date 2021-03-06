USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Cost_Sheet_for_gp]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- used table 
/*
	TFSBOM400180
	TFSBOM401180
	TFSBOM421180
	TFSBOM422180
	TFSAMI002180
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Cost_Sheet_for_gp]
	-- Add the parameters for the stored procedure here
@Project	NVARCHAR(10)
AS
BEGIN
	DECLARE @SqlString	VARCHAR(MAX)
	DECLARE @SERN		VARCHAR(4)
	DECLARE @VARCOST	TABLE(COST DECIMAL(18,2))
	DECLARE @COST421	TABLE(DL_COST_PNL DECIMAL(18,2),IDL_COST_PNL DECIMAL(18,2),DA_COST_PNL DECIMAL(18,2),VAR_MOH DECIMAL(18,2))
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#Temp') AND TYPE = 'U')
		DROP TABLE #Temp

		SELECT T$PJNO,T$SERN,T$PLNT,T$APRJ,T$BUSP,T$DLIU,T$GSRU INTO 	#TEMP	FROM FactoryLoading.DBO.TFSBOM400180 WHERE 1 <> 1
    -- Get Bom summary Information 
		SET @SqlString = '
			SELECT *
			FROM OPENQUERY
			(
				AS1P1,'+''''+'SELECT A.T$PJNO,A.T$SERN,T$PLNT,T$APRJ,T$BUSP,T$DLIU,T$GSRU
						FROM BAAN.TFSBOM400180 A,
						(
							SELECT T$PJNO , MAX(T$SERN) AS T$SERN FROM BAAN.TFSBOM400180 
							WHERE T$PJNO = '''''+@Project+'''''
							GROUP BY T$PJNO
						) B
						WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN
				'+''''+'
			)
		'
		INSERT INTO #TEMP
		EXEC(@SqlString)

		ALTER TABLE #Temp ADD BOM_COST	DECIMAL(18,2)
		ALTER TABLE #Temp ADD EDM_COST	DECIMAL(18,2)
		ALTER TABLE #Temp ADD MRB_Yield DECIMAL(18,2)
		ALTER TABLE #Temp ADD VAR_MOH	DECIMAL(18,2)
		ALTER TABLE #Temp ADD Depreciation	DECIMAL(18,2)
		ALTER TABLE #Temp ADD IDL_COST	DECIMAL(18,2)

		SELECT @SERN = T$SERN FROM #TEMP
	-- Get Bom Cost
		SET @SqlString = '
			SELECT * 
			FROM OPENQUERY
			(
				AS1P1,'+''''+'SELECT CAST(SUM(T$COSU) AS DECIMAL(18,2)) AS BOM_COST
						FROM BAAN.TFSBOM401180
						WHERE T$META IN (''''Copper Foil'''',''''Laminate'''',''''Prepreg'''',''''RCC Foil'''',''''Coin'''',''''Adhesive'''',''''FCCL'''',''''Coverlay'''',''''Stiffener'''',''''Sheildling Film'''',''''SMD'''')
						AND T$PJNO = '''''+@Project+''''' AND T$SERN = '''''+@SERN+'''''
						GROUP BY T$PJNO,T$SERN
				'+''''+'
			)
		'
		INSERT INTO @VARCOST
		EXEC(@SqlString)
		UPDATE #TEMP SET BOM_COST = COST FROM @VARCOST

	-- Get EDM Cost
		SET @SqlString = '
			SELECT * 
			FROM OPENQUERY
			(
				AS1P1,'+''''+'SELECT CAST(SUM(T$COSU) AS DECIMAL(18,2)) AS EDM_COST
						FROM BAAN.TFSBOM401180
						WHERE T$META NOT IN (''''Copper Foil'''',''''Laminate'''',''''Prepreg'''',''''RCC Foil'''',''''Coin'''',''''Adhesive'''',''''FCCL'''',''''Coverlay'''',''''Stiffener'''',''''Sheildling Film'''',''''SMD'''')
						AND T$PJNO = '''''+@Project+''''' AND T$SERN = '''''+@SERN+'''''
						GROUP BY T$PJNO,T$SERN
				'+''''+'
			)
		'
		DELETE FROM @VARCOST
		INSERT INTO @VARCOST
		EXEC(@SqlString)
		UPDATE #TEMP SET EDM_COST = COST/((100-T$BUSP)/100) FROM @VARCOST

	-- Get Var Moh
		SET @SqlString = '
			SELECT * 
			FROM OPENQUERY
			(
				AS1P1,'+''''+'SELECT SUM(T$DLCT) AS DL_COST_PNL,SUM(T$ILCT) AS IDL_COST_PNL,SUM(T$DPAM) AS DA_COST_PNL,	(SUM(T$EQEX)+SUM(T$FAUT)+SUM(T$CMPT)+SUM(T$SUPP)+SUM(T$TREN)+SUM(T$OTER)) AS VAR_MOH
						FROM BAAN.TFSBOM421180
						WHERE T$PJNO = '''''+@Project+''''' AND T$SERN = '''''+@SERN+'''''
						GROUP BY T$PJNO,T$SERN
				'+''''+'
			)
		'
		INSERT INTO @COST421
		EXEC(@SqlString)
		UPDATE #TEMP SET	VAR_MOH = A.VAR_MOH ,
							Depreciation = A.DA_Cost_PNL,
							IDL_COST = A.IDL_COST_PNL
		FROM @COST421 AS A

	-- Get MRB Yield 
		UPDATE #TEMP SET	MRB_Yield = BOM_COST/((100-T$BUSP)/100) - BOM_COST,
							T$DLIU = CAST((T$DLIU*0.85/((100-T$BUSP)/100)*1.14) AS DECIMAL(18,2))

--	Show result
		SELECT * FROM #TEMP
END

GO

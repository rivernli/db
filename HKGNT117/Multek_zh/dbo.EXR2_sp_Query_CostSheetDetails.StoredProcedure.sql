USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_CostSheetDetails]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =======================================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_CostSheetDetails]
@Plant		nvarchar(10),
@Project	nvarchar(30),
@FYear		nvarchar(10),
@FPeriod	nvarchar(10)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE	@sqlString		NVARCHAR(MAX),@Period INT
	DECLARE	@Confirm_date	DATETIME

	SET @Plant	 = ISNULL(@Plant,  '')
	SET	@Plant	 = LTRIM(RTRIM(@Plant))
	SET @Project = ISNULL(@Project,'')
	SET	@Project = LTRIM(RTRIM(@Project))
	SET @FYear	 = ISNULL(@FYear,  '')
	SET	@FYear	 = LTRIM(RTRIM(@FYear))
	SET @FPeriod = ISNULL(@FPeriod,'')

	IF len(@FPeriod) = 3
		SET @Period = SUBSTRING(@FPeriod,2,2)
	ELSE
		SET @Period = SUBSTRING(@FPeriod,2,1)

	SELECT TOP 1 @Confirm_date = calenderDate FROM ce3p1179.dbo.Calender WHERE FiscalYearDesc = @FYear AND FiscalPeriod = @Period ORDER BY calenderDate DESC

	IF @Plant = 'B1' 
		SET @Plant = 'P2'
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempbom') AND TYPE = 'U')
		DROP TABLE #tempbom

	SELECT T$PJNO,	T$SERN,T$CRID,'            ' AS T$CRDT,'            ' AS T$LCDT,'          ' as T$STAT,T$MBSP,T$ODSP,T$STSP,	T$MASP,	T$BUSP,	T$CESU,	T$CESP,	T$CESS,	T$CISU,	T$CISP,	T$CISS,	T$DLIU,	T$DLIP,	T$DLIS,	T$ILIU,	T$ILIP,	T$ILIS,	T$MDSU,	T$MDSP,	T$MDSS,	T$LDIU,	T$LDIP,	T$LDIS,	T$LDMU,	T$LDMP,	T$LDMS,	T$TCIU,	T$TCIP,	T$TCIS,	T$GSRU,	T$GSRP,	T$GSRS,	T$PRIC,	T$MCSR,	T$PRMG,	T$PMGR,	T$EPRP,	T$EPPP,	T$EPPC,	T$VERS,	T$AVER,	T$TCUU,	T$TCUP,	T$TCUS,	T$FDIR,	T$BTYP,	T$ATYP,	T$TQTY,	T$MRB1,T$MRB4 ,T$MR12 ,T$MR13,T$TXTA,T$PLNT,T$UFLG,T$SCRE,T$DCFA,T$CODA,T$COTI,T$PVER,T$MVER,T$REFCNTD,T$REFCNTU INTO #tempbom FROM FactoryLoading.dbo.TFSBOM400180  WHERE 1 <> 1

	INSERT INTO #tempbom
	SELECT TOP 1 
			T$PJNO,
			T$SERN,
			T$CRID,
			CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,
			T$LCDT,
			CASE T$STAT when 2 then 'Confirm' else 'unconfirm' end as T$STAT,
			CAST(T$MBSP AS DECIMAL(18,2)) AS T$MBSP,
			T$ODSP,
			T$STSP,
			CAST(T$MASP AS DECIMAL(18,2)) AS T$MASP,
			CAST(T$BUSP AS DECIMAL(18,2)) AS T$BUSP,
			T$CESU,
			T$CESP,
			T$CESS,
			T$CISU,
			T$CISP,
			T$CISS,
			T$DLIU,
			T$DLIP,
			T$DLIS,
			T$ILIU,
			T$ILIP,
			T$ILIS,
			T$MDSU,
			T$MDSP,
			T$MDSS,
			T$LDIU,
			T$LDIP,
			T$LDIS,
			T$LDMU,
			T$LDMP,
			T$LDMS,
			T$TCIU,
			T$TCIP,
			T$TCIS,
			T$GSRU,
			T$GSRP,
			T$GSRS,
			T$PRIC,
			T$MCSR,
			T$PRMG,
			T$PMGR,
			T$EPRP,
			T$EPPP,
			T$EPPC,
			T$VERS,
			T$AVER,
			T$TCUU,
			T$TCUP,
			T$TCUS,
			T$FDIR,
			T$BTYP,
			T$ATYP,
			T$TQTY,
			CAST(T$MRB1 as decimal(18,2)) AS T$MRB1,
			CAST(T$MRB4 as decimal(18,2)) AS T$MRB4,
			CAST(T$MR12 as decimal(18,2)) AS T$MR12,
			CAST(T$MR13 as decimal(18,2)) AS T$MR13,
			T$TXTA,
			T$PLNT,
			T$UFLG,
			T$SCRE,
			T$DCFA,
			T$CODA,
			T$COTI,
			T$PVER,
			T$MVER,
			T$REFCNTD,
			T$REFCNTU
	FROM FactoryLoading.dbo.TFSBOM400180 
	WHERE T$PLNT = @Plant
	AND T$PJNO LIKE @Project+'%'
	AND	T$STAT = 2
	AND	T$LCDT <= @Confirm_date
	ORDER BY T$LCDT DESC,T$SERN DESC

	IF NOT EXISTS(SELECT * FROM #tempbom)
		BEGIN
			INSERT INTO #tempbom
			SELECT TOP 1 
			T$PJNO,
			T$SERN,
			T$CRID,
			CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,
			T$LCDT,
			CASE T$STAT when 2 then 'Confirm' else 'unconfirm' end as T$STAT,
			T$MBSP,
			T$ODSP,
			T$STSP,
			T$MASP,
			T$BUSP,
			T$CESU,
			T$CESP,
			T$CESS,
			T$CISU,
			T$CISP,
			T$CISS,
			T$DLIU,
			T$DLIP,
			T$DLIS,
			T$ILIU,
			T$ILIP,
			T$ILIS,
			T$MDSU,
			T$MDSP,
			T$MDSS,
			T$LDIU,
			T$LDIP,
			T$LDIS,
			T$LDMU,
			T$LDMP,
			T$LDMS,
			T$TCIU,
			T$TCIP,
			T$TCIS,
			T$GSRU,
			T$GSRP,
			T$GSRS,
			T$PRIC,
			T$MCSR,
			T$PRMG,
			T$PMGR,
			T$EPRP,
			T$EPPP,
			T$EPPC,
			T$VERS,
			T$AVER,
			T$TCUU,
			T$TCUP,
			T$TCUS,
			T$FDIR,
			T$BTYP,
			T$ATYP,
			T$TQTY,
			CAST(T$MRB1 as decimal(18,2)) as T$MRB1,
			CAST(T$MRB4 as decimal(18,2)) as T$MRB4,
			CAST(T$MR12 as decimal(18,2)) as T$MR12,
			CAST(T$MR13 as decimal(18,2)) as T$MR13,
			T$TXTA,
			T$PLNT,
			T$UFLG,
			T$SCRE,
			T$DCFA,
			T$CODA,
			T$COTI,
			T$PVER,
			T$MVER,
			T$REFCNTD,
			T$REFCNTU
			FROM FactoryLoading.dbo.TFSBOM400180 
			WHERE T$PLNT = @Plant
			AND T$PJNO LIKE @Project+'%'
			AND	T$STAT = 2
			AND	T$LCDT >= @Confirm_date
			ORDER BY T$LCDT	ASC,T$SERN ASC
		END

	SELECT * FROM #tempbom
END











GO

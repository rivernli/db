USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Quick_Cost_Query_Project_Details]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Quick_Cost_Query_Project_Details]
@Project	NVARCHAR(15),
@Version	NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE	@PROJECT4	NVARCHAR(4)
	SET @Project = ISNULL(@Project,'')
	SET @Version = ISNULL(@Version,'')
	IF(@Project='')
		BEGIN
			RAISERROR('There is no Project code!',16,1)
			RETURN
		END
	IF(@Version='')
		BEGIN
			RAISERROR('There is no version',16,1)
			RETURN
		END

	--SET @PROJECT4 = SUBSTRING(@Project,4,4)

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('tempdb.#BOM_COST_DETAILS') AND TYPE ='U')
		DROP TABLE #BOM_COST_DETAILS

    -- Insert statements for procedure here
	SELECT		T$PJNO,
				T$SERN,
				T$CRID,
				CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,
				CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,
				CASE T$STAT when 2 then 'Confirm' else 'unconfirm' end as T$STAT,
				T$MBSP,
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
				CAST(T$TQTY as decimal(18,4)) AS T$TQTY,
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
				CAST(T$UNST AS DECIMAL(18,0)) AS T$UNST,	
				T$PANW,
				T$PANL,
				T$AREA,
				CAST(T$CBPN AS DECIMAL(18,0)) AS T$CBPN,
				T$PNWN,
				T$PNLN,
				CAST(T$BOMC/(T$UNST*T$CBPN) AS DECIMAL(18,4)) AS T$BOMC,
				CONVERT(NVARCHAR,T$DATE,111) AS T$DATE
		INTO #BOM_COST_DETAILS
		FROM	dbo.vc_Quick_Cost_TFSBOM400180
		WHERE	T$PJNO = @Project
		AND		T$SERN = @Version

	-- Return table
		SELECT * FROM #BOM_COST_DETAILS
		DROP TABLE #BOM_COST_DETAILS
END





GO

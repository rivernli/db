USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Simple_Cost_Query_Project_Details]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Simple_Cost_Query_Project_Details]
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
	SELECT		A.T$PJNO,
				A.T$SERN,
				A.T$CRID,
				CONVERT(NVARCHAR,A.T$CRDT,111) AS T$CRDT,
				CONVERT(NVARCHAR,A.T$LCDT,111) AS T$LCDT,
				CASE A.T$STAT when 2 then 'Confirm' else 'unconfirm' end as T$STAT,
				A.T$MBSP,
				A.T$ODSP,
				A.T$STSP,
				CAST(A.T$MASP AS DECIMAL(18,2)) AS T$MASP,
				CAST(A.T$BUSP AS DECIMAL(18,2)) AS T$BUSP,
				A.T$CESU,
				A.T$CESP,
				A.T$CESS,
				A.T$CISU,
				A.T$CISP,
				A.T$CISS,
				A.T$DLIU,
				A.T$DLIP,
				A.T$DLIS,
				A.T$ILIU,
				A.T$ILIP,
				A.T$ILIS,
				A.T$MDSU,
				A.T$MDSP,
				A.T$MDSS,
				A.T$LDIU,
				A.T$LDIP,
				A.T$LDIS,
				A.T$LDMU,
				A.T$LDMP,
				A.T$LDMS,
				A.T$TCIU,
				A.T$TCIP,
				A.T$TCIS,
				A.T$GSRU,
				A.T$GSRP,
				A.T$GSRS,
				A.T$PRIC,
				A.T$MCSR,
				A.T$PRMG,
				A.T$PMGR,
				A.T$EPRP,
				A.T$EPPP,
				A.T$EPPC,
				A.T$VERS,
				A.T$AVER,
				A.T$TCUU,
				A.T$TCUP,
				A.T$TCUS,
				A.T$FDIR,
				A.T$BTYP,
				A.T$ATYP,
				CAST(A.T$TQTY as decimal(18,4)) AS T$TQTY,
				CAST(A.T$MRB1 as decimal(18,2)) AS T$MRB1,
				CAST(A.T$MRB4 as decimal(18,2)) AS T$MRB4,
				CAST(A.T$MR12 as decimal(18,2)) AS T$MR12,
				CAST(A.T$MR13 as decimal(18,2)) AS T$MR13,
				A.T$TXTA,
				A.T$PLNT,
				A.T$UFLG,
				A.T$SCRE,
				A.T$DCFA,
				A.T$CODA,
				A.T$COTI,
				A.T$PVER,
				A.T$MVER,
				CAST(A.T$UNST AS DECIMAL(18,0)) AS T$UNST,
				A.T$PANW,
				A.T$PANL,
				A.T$AREA,
				CAST(A.T$CBPN AS DECIMAL(18,0)) AS T$CBPN,
				A.T$PNWN,
				A.T$PNLN,
				CAST(A.T$BOMC/(A.T$UNST*A.T$CBPN) AS DECIMAL(18,4)) AS T$BOMC,
				CONVERT(NVARCHAR,A.T$DATE,111) AS T$DATE,
				A.T$PLUP,
				B.T$REMK,
				CAST(A.SUGGEST as decimal(18,2)) as SUGGEST
				
		INTO #BOM_COST_DETAILS
		FROM	dbo.vc_Simple_Cost_TFSBOM400180 AS A ,dbo.TFSBOM465180 AS B
		WHERE	A.T$PJNO = @Project
		AND		A.T$SERN = @Version
		AND		A.T$PLNT = B.T$PLNT 
		AND		B.T$PDTY = A.T$ATYP 
		AND		B.T$PLUP = A.T$PLUP 
		AND		B.T$MTYP = 'DYM1'
		
	-- Return table
		SELECT * FROM #BOM_COST_DETAILS
		DROP TABLE #BOM_COST_DETAILS
END






GO

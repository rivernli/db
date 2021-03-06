USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_Project_List_bk20130327]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Sheet_Query_Project_List_bk20130327]
@Project		NVARCHAR(12),
@Top			NVARCHAR(5),
@Account		VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE	@SQL_STRING	NVARCHAR(MAX)
	DECLARE	@Condition  NVARCHAR(1000)

	SET NOCOUNT ON;
	SET @Project = ISNULL(@Project,'')
	SET @Top	 = ISNULL(@Top,'0')
	
	SET @Account = ISNULL(@Account,'')
--	IF @Account = ''
--		BEGIN
--			RAISERROR('Session timeout!',16,1)
--			return
--		END

	IF @Project = ''
		BEGIN
			RAISERROR('Please enter project first !',16,1)
			RETURN
		END

--	IF EXISTS(SELECT TOP 1 * FROM dbo.Cost_Sheet_Query_CS_OEM_Authority WHERE ACCOUNT = @Account)
--		BEGIN
--			SET @Condition  = ' FROM Cost_Sheet_Query_by_UserOEM_TFSBOM400'
--			SET @Condition = @Condition + ' WHERE	T$PJNO LIKE N'+''''+'%'+@Project+'%'+''''
--			SET @Condition = @Condition + ' AND		Account ='+''''+@Account+''''
--			SET @Condition = @Condition + ' ORDER BY T$SERN DESC,T$VERS Desc'
--		END
--	ELSE
		BEGIN
			SET @Condition = ' FROM Cost_Sheet_Query_TFSBOM400180'
			SET @Condition = @Condition + ' WHERE	T$PJNO LIKE N'+''''+'%'+@Project+'%'+''''
			SET @Condition = @Condition + ' AND T$PJNO NOT LIKE N'+''''+'@%'+''''
			SET @Condition = @Condition + ' AND T$PJNO NOT LIKE N'+''''+'$%'+''''
			--SET @Condition = @Condition + ' AND (T$PJNO IS NULL OR T$PJNO = '''')'
			SET @Condition = @Condition + ' ORDER BY T$SERN DESC,T$VERS Desc'
		END	
	


    -- Insert statements for procedure here
	IF @Top = 0
		BEGIN
			SET @SQL_STRING = 'SELECT T$PLNT,T$PJNO,T$SERN,T$VERS,T$ATYP,T$CRID,
					CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,
					CASE T$STAT when 2 then '+''''+'Confirm'+''''+' else '+''''+'unconfirm'+''''+' end as T$STAT,
					T$CESU '+@Condition
		END
	ELSE
		BEGIN
			SET @SQL_STRING = 'SELECT TOP '+@Top+'T$PLNT,T$PJNO,T$SERN,T$VERS,T$ATYP,T$CRID,
					CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,
					CASE T$STAT when 2 then '+''''+'Confirm'+''''+' else '+''''+'unconfirm'+''''+' end as T$STAT,
					T$CESU '+@Condition
		END
	EXECUTE(@SQL_STRING)
--	IF @Top = 0 
--		BEGIN
--			SET @SQL_STRING = '
--				SELECT	T$PJNO,
--						T$SERN,
--						T$CRID,
--						CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,
--						CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,
--						CASE T$STAT when 2 then '+''''+'Confirm'+''''+' else '+''''+'unconfirm'+''''+' end as T$STAT,
--						T$MBSP,
--						T$ODSP,
--						T$STSP,
--						T$MASP,
--						T$BUSP,
--						T$CESU,
--						T$CESP,
--						T$CESS,
--						T$CISU,
--						T$CISP,
--						T$CISS,
--						T$DLIU,
--						T$DLIP,
--						T$DLIS,
--						T$ILIU,
--						T$ILIP,
--						T$ILIS,
--						T$MDSU,
--						T$MDSP,
--						T$MDSS,
--						T$LDIU,
--						T$LDIP,
--						T$LDIS,
--						T$LDMU,
--						T$LDMP,
--						T$LDMS,
--						T$TCIU,
--						T$TCIP,
--						T$TCIS,
--						T$GSRU,
--						T$GSRP,
--						T$GSRS,
--						T$PRIC,
--						T$MCSR,
--						T$PRMG,
--						T$PMGR,
--						T$EPRP,
--						T$EPPP,
--						T$EPPC,
--						T$VERS,
--						T$AVER,
--						T$TCUU,
--						T$TCUP,
--						T$TCUS,
--						T$FDIR,
--						T$BTYP,
--						T$ATYP,
--						T$TQTY,
--						CAST(T$MRB1 as decimal(18,2)) AS T$MRB1,
--						CAST(T$MRB4 as decimal(18,2)) AS T$MRB4,
--						CAST(T$MR12 as decimal(18,2)) AS T$MR12,
--						CAST(T$MR13 as decimal(18,2)) AS T$MR13,
--						T$TXTA,
--						T$PLNT,
--						T$UFLG,
--						T$SCRE,
--						T$DCFA,
--						T$CODA,
--						T$COTI,
--						T$PVER,
--						T$MVER'
--						+@Condition
--		END
--	ELSE
--		BEGIN
--			SET @SQL_STRING =
--					'SELECT TOP '+@Top+'
--						T$PJNO,
--						T$SERN,
--						T$CRID,
--						CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,
--						T$LCDT,
--						CASE T$STAT when 2 then '+''''+'Confirm'+''''+' else '+''''+'unconfirm'+''''+' end as T$STAT,
--						T$MBSP,
--						T$ODSP,
--						T$STSP,
--						T$MASP,
--						T$BUSP,
--						T$CESU,
--						T$CESP,
--						T$CESS,
--						T$CISU,
--						T$CISP,
--						T$CISS,
--						T$DLIU,
--						T$DLIP,
--						T$DLIS,
--						T$ILIU,
--						T$ILIP,
--						T$ILIS,
--						T$MDSU,
--						T$MDSP,
--						T$MDSS,
--						T$LDIU,
--						T$LDIP,
--						T$LDIS,
--						T$LDMU,
--						T$LDMP,
--						T$LDMS,
--						T$TCIU,
--						T$TCIP,
--						T$TCIS,
--						T$GSRU,
--						T$GSRP,
--						T$GSRS,
--						T$PRIC,
--						T$MCSR,
--						T$PRMG,
--						T$PMGR,
--						T$EPRP,
--						T$EPPP,
--						T$EPPC,
--						T$VERS,
--						T$AVER,
--						T$TCUU,
--						T$TCUP,
--						T$TCUS,
--						T$FDIR,
--						T$BTYP,
--						T$ATYP,
--						T$TQTY,
--						T$MRB1,
--						T$MRB4,
--						T$MR12,
--						T$MR13,
--						T$TXTA,
--						T$PLNT,
--						T$UFLG,
--						T$SCRE,
--						T$DCFA,
--						T$CODA,
--						T$COTI,
--						T$PVER,
--						T$MVER'
--						+@Condition
--		END
--	EXECUTE(@SQL_STRING)
END





GO

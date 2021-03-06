USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_For_Quotation_Query_Project_Details]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_For_Quotation_Query_Project_Details]
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

    -- Insert statements for procedure here
	SELECT		T$PLNT,																--PLANT
				T$PJNO,																--Project No
				T$ATYP,																--Product Type
				T$SERN,																--Cost version
				T$VERS,																--BOM VERS
				T$CRID,																--Creator 
				CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,								--Create date
				CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,								--Last Calc date
				T$SUNST,															--Unit / set
				T$SPANW,															--Pnl width(mm)
				T$SPANL,															--pnl length(mm)
				T$SAREA,															--pnl area(sqft)
				T$SCBPN,															--Sets/Wk_pnl
				T$SPNWN,															--Pnl width(inch)
				T$SPNLN,															--Pnl length(inch)
				CAST(T$SUTIL AS DECIMAL(18,1)) T$SUTIL,															--Pnl Utilization
				T$MR13,																--History Scrao Rate
				T$MASP,																--Me Input Scrap Rate
				T$BUSP,																--Scrap rate being used
				T$SCRE,																--Remark
				T$PVER,
				T$MVER,
				CASE T$QSTA when 2 then 'Confirm' else 'unconfirm' end as T$QSTA,	--Cost Status
				T$APRJ,
				CAST(T$OU13 AS DECIMAL(18,4)) T$OU13,								-- Total output 
				CAST(T$BOMU AS DECIMAL(18,4)) T$BOMU,
				CAST(T$BOMP AS DECIMAL(18,4)) T$BOMP,
				CAST(T$BOMS AS DECIMAL(18,4)) T$BOMS,
				CAST(T$EDMU AS DECIMAL(18,4)) T$EDMU,
				CAST(T$EDMP AS DECIMAL(18,4)) T$EDMP,
				CAST(T$EDMS AS DECIMAL(18,4)) T$EDMS,
				CAST(T$DLU AS DECIMAL(18,4)) T$DLU,
				CAST(T$DLP AS DECIMAL(18,4)) T$DLP,
				CAST(T$DLS AS DECIMAL(18,4)) T$DLS,
				CAST(T$VARMOHU AS DECIMAL(18,4)) T$VARMOHU,
				CAST(T$VARMOHP AS DECIMAL(18,4)) T$VARMOHP,
				CAST(T$VARMOHS AS DECIMAL(18,4)) T$VARMOHS,
				CAST(T$SUBCONU AS DECIMAL(18,4)) T$SUBCONU,
				CAST(T$SUBCONP AS DECIMAL(18,4)) T$SUBCONP,
				CAST(T$SUBCONS AS DECIMAL(18,4)) T$SUBCONS,
				CAST(T$SUBVARU AS DECIMAL(18,4)) T$SUBVARU,
				CAST(T$SUBVARP AS DECIMAL(18,4)) T$SUBVARP,
				CAST(T$SUBVARS AS DECIMAL(18,4)) T$SUBVARS,
				CAST(T$IDLU AS DECIMAL(18,4)) T$IDLU,
				CAST(T$IDLP AS DECIMAL(18,4)) T$IDLP,
				CAST(T$IDLS AS DECIMAL(18,4)) T$IDLS,
				CAST(T$DAU AS DECIMAL(18,4)) T$DAU,
				CAST(T$DAP AS DECIMAL(18,4)) T$DAP,
				CAST(T$DAS AS DECIMAL(18,4)) T$DAS,
				CAST(T$GSRU AS DECIMAL(18,4)) T$GSRU,
				CAST(T$GSRP AS DECIMAL(18,4)) T$GSRP,
				CAST(T$GSRS AS DECIMAL(18,4)) T$GSRS,
				CAST(T$SUBFIXU AS DECIMAL(18,4)) T$SUBFIXU,
				CAST(T$SUBFIXP AS DECIMAL(18,4)) T$SUBFIXP,
				CAST(T$SUBFIXS AS DECIMAL(18,4)) T$SUBFIXS,
				CAST(T$TOTU AS DECIMAL(18,4)) T$TOTU,
				CAST(T$TOTP AS DECIMAL(18,4)) T$TOTP,
				CAST(T$TOTS AS DECIMAL(18,4)) T$TOTS
		FROM	TFSOLP151180
		WHERE	T$PJNO = @Project
		AND		T$SERN = @Version

END






GO

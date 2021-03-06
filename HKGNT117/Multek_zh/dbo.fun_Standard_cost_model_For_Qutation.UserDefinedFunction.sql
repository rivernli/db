USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Standard_cost_model_For_Qutation]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Standard_cost_model_For_Qutation]
(
	-- Add the parameters for the function here
	@fsbom400_t$plnt	nvarchar(2),
	@fsbom400_t$pjno	nvarchar(10),
	@fsbom400_t$sern	int,
	@fsbom400_t$atyp	nvarchar(40)
)
RETURNS 
@tab TABLE 
(
	SUBCON_COST		DECIMAL(18,4),
	Normal_cost		DECIMAL(18,4),
	Subcon_bom_pnl	DECIMAL(18,4),
	Subcon_dem_pnl	DECIMAL(18,4),
	Subcon_dl_pnl	DECIMAL(18,4),
	Subcon_idl_pnl	DECIMAL(18,4),
	Subcon_var_pnl	DECIMAL(18,4),
	Subcon_da_pnl	DECIMAL(18,4)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	DECLARE
		@SUBCON_COST		DECIMAL(18,4),
		@Normal_cost		DECIMAL(18,4),
		@Subcon_bom_pnl		DECIMAL(18,4),
		@Subcon_dem_pnl		DECIMAL(18,4),
		@Subcon_dl_pnl		DECIMAL(18,4),
		@Subcon_idl_pnl		DECIMAL(18,4),
		@Subcon_var_pnl		DECIMAL(18,4),
		@Subcon_da_pnl		DECIMAL(18,4)

	-- get Mass lam - SUBCON_COST
		SELECT @SUBCON_COST = SUM(T$COST) FROM dbo.TFSBOM461180 WHERE T$TYPE = 1 AND T$PJNO IN
			(
				SELECT T$PITM FROM dbo.TFSBOM462180 WHERE T$SELE = 1 AND T$TYPE = 1 AND T$PJNO = @fsbom400_t$pjno AND T$SERN = @fsbom400_t$sern GROUP BY T$PITM
			)
		AND	T$PLNT = @fsbom400_t$plnt

		SELECT	@Normal_cost =    SUM(T$MTRC+T$PSMC+T$DOSC+T$DLCT+T$ILCT+T$MDCT+T$MMCT+T$DPAM+T$EQEX+T$FAUT+T$CMPT+T$SUPP+T$TREN+T$OTER),
				@Subcon_bom_pnl = SUM(T$BOMC),
				@Subcon_dem_pnl = SUM(T$MTRC+T$PSMC+T$DOSC-T$BOMC),
				@Subcon_dl_pnl =  SUM(T$DLCT),
				@Subcon_idl_pnl = SUM(T$ILCT) ,
				@Subcon_var_pnl = SUM(T$EQEX+T$FAUT+T$CMPT+T$SUPP+T$TREN+T$OTER) ,
				@Subcon_da_pnl =  SUM(T$DPAM) 
			FROM FACTORYLOADING.DBO.TFSBOM421180 WHERE T$ITEM IN
				(
					SELECT T$PITM FROM dbo.TFSBOM462180 WHERE T$SELE = 1 AND T$TYPE = 1 AND T$PJNO = @fsbom400_t$pjno AND T$SERN = @fsbom400_t$sern GROUP BY T$PITM
				)
			AND	T$PJNO = @fsbom400_t$pjno
			AND	T$SERN = @fsbom400_t$sern

	-- get external subcontract
		IF NOT EXISTS(SELECT T$PITM FROM dbo.TFSBOM462180 WHERE T$SELE = 1 AND T$TYPE = 1 AND T$PJNO = @fsbom400_t$pjno AND T$SERN = @fsbom400_t$sern)
			BEGIN
				SELECT @SUBCON_COST = SUM(A.T$COST) FROM dbo.TFSBOM461180 A, dbo.TFSBOM462180 B
				WHERE	A.T$TYPE = 2 
				AND		A.T$PLNT = @fsbom400_t$plnt
				AND		A.T$PJNO = B.T$PITM
				AND		A.T$CWOC = B.T$MNWC
				AND		B.T$SELE = 1 
				AND		B.T$TYPE = 2
				AND		B.T$PJNO = @fsbom400_t$pjno
				AND		B.T$SERN = @fsbom400_t$sern

				IF @SUBCON_COST = 0 OR @SUBCON_COST = NULL 
					BEGIN
						SELECT TOP 1 @SUBCON_COST = A.T$COST FROM dbo.TFSBOM461180 A, dbo.TFSBOM462180 B
						WHERE	A.T$TYPE = 2 
						AND		A.T$PLNT = @fsbom400_t$plnt
						AND		A.T$PJNO BETWEEN LEFT(B.T$PITM,9)+'1'+RIGHT(B.T$PITM,3) AND LEFT(B.T$PITM,9)+'Z'+RIGHT(B.T$PITM,3) 
						AND		A.T$CWOC = B.T$MNWC
						AND		B.T$SELE = 1 
						AND		B.T$TYPE = 2
						AND		B.T$PJNO = @fsbom400_t$pjno
						AND		B.T$SERN = @fsbom400_t$sern
					END

				IF @SUBCON_COST = 0 OR @SUBCON_COST = NULL 
					BEGIN
						SELECT TOP 1 @SUBCON_COST = A.T$COST FROM dbo.TFSBOM461180 A, dbo.TFSBOM462180 B
						WHERE	A.T$TYPE = 2 
						AND		A.T$PLNT = @fsbom400_t$plnt
						AND		A.T$PJNO BETWEEN LEFT(B.T$PITM,9)+'1'+RIGHT(B.T$PITM,3) AND LEFT(B.T$PITM,9)+'Z'+RIGHT(B.T$PITM,3) 
						AND		A.T$CWOC = B.T$MNWC
						AND		A.T$PTYP = @fsbom400_t$atyp
						AND		B.T$SELE = 1 
						AND		B.T$TYPE = 2
						AND		B.T$PJNO = @fsbom400_t$pjno
						AND		B.T$SERN = @fsbom400_t$sern
					END

				SELECT	@Normal_cost =    SUM(T$MTRC+T$PSMC+T$DOSC+T$DLCT+T$ILCT+T$MDCT+T$MMCT+T$DPAM+T$EQEX+T$FAUT+T$CMPT+T$SUPP+T$TREN+T$OTER),
						@Subcon_bom_pnl = SUM(T$BOMC),
						@Subcon_dem_pnl = SUM(T$MTRC+T$PSMC+T$DOSC-T$BOMC),
						@Subcon_dl_pnl =  SUM(T$DLCT),
						@Subcon_idl_pnl = SUM(T$ILCT) ,
						@Subcon_var_pnl = SUM(T$EQEX+T$FAUT+T$CMPT+T$SUPP+T$TREN+T$OTER) ,
						@Subcon_da_pnl =  SUM(T$DPAM) 
					FROM FACTORYLOADING.DBO.TFSBOM421180 WHERE T$ITEM+T$MNWC IN
						(
							SELECT T$PITM+T$MNWC FROM dbo.TFSBOM462180 WHERE T$SELE = 1 AND T$TYPE = 1 AND T$PJNO = @fsbom400_t$pjno AND T$SERN = @fsbom400_t$sern GROUP BY T$PITM,T$MNWC
						)
					AND	T$PJNO = @fsbom400_t$pjno
					AND	T$SERN = @fsbom400_t$sern
			END
	-- get internal subcontract
		IF NOT EXISTS(SELECT T$PITM FROM dbo.TFSBOM462180 WHERE T$SELE = 1 AND (T$TYPE = 1 OR T$TYPE = 2) AND T$PJNO = @fsbom400_t$pjno AND T$SERN = @fsbom400_t$sern)
			BEGIN
				--?


				SELECT	@Normal_cost =    SUM(T$MTRC+T$PSMC+T$DOSC+T$DLCT+T$ILCT+T$MDCT+T$MMCT+T$DPAM+T$EQEX+T$FAUT+T$CMPT+T$SUPP+T$TREN+T$OTER),
						@Subcon_bom_pnl = SUM(T$BOMC),
						@Subcon_dem_pnl = SUM(T$MTRC+T$PSMC+T$DOSC-T$BOMC),
						@Subcon_dl_pnl =  SUM(T$DLCT),
						@Subcon_idl_pnl = SUM(T$ILCT) ,
						@Subcon_var_pnl = SUM(T$EQEX+T$FAUT+T$CMPT+T$SUPP+T$TREN+T$OTER) ,
						@Subcon_da_pnl =  SUM(T$DPAM) 
					FROM FACTORYLOADING.DBO.TFSBOM421180 WHERE T$ITEM+T$MNWC IN
						(
							SELECT T$PITM+T$MNWC FROM dbo.TFSBOM462180 WHERE T$SELE = 1 AND T$TYPE = 3 AND T$PJNO = @fsbom400_t$pjno AND T$SERN = @fsbom400_t$sern AND T$PLNT <> '' GROUP BY T$PITM,T$MNWC
						)
					AND	T$PJNO = @fsbom400_t$pjno
					AND	T$SERN = @fsbom400_t$sern
			END

	INSERT INTO @tab SELECT @SUBCON_COST,@Normal_cost,@Subcon_bom_pnl,@Subcon_dem_pnl,@Subcon_dl_pnl,@Subcon_idl_pnl,@Subcon_var_pnl,@Subcon_da_pnl

	RETURN 
END

GO

USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[quotutation_flow_sp_get_cost_details]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[quotutation_flow_sp_get_cost_details]
	-- Add the parameters for the stored procedure here
@Item	nvarchar(32)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		DECLARE	@Proj_area	DECIMAL(18,4),@Proj_cbpn DECIMAL(18,4),@Proj_unst decimal(18,4),@temp_unit int,@max_sern	int
		DECLARE	@Pnl_size	DECIMAL(18,4)
		DECLARE	@lmt		DECIMAL(18,4),@ppg	DECIMAL(18,4),@cfl	DECIMAL(18,4),@rcc	DECIMAL(18,4),@drl	DECIMAL(18,4)
		DECLARE	@dry		DECIMAL(18,4),@smcm DECIMAL(18,4),@bev	DECIMAL(18,4),@cou	DECIMAL(18,4),@mil	DECIMAL(18,4)
		DECLARE	@rou		DECIMAL(18,4),@gold	DECIMAL(18,4),@edm	DECIMAL(18,4),@coin	DECIMAL(18,4),@fccl	DECIMAL(18,4)
		DECLARE	@cov		DECIMAL(18,4),@adh	DECIMAL(18,4),@sti	DECIMAL(18,4),@she	DECIMAL(18,4),@Plant nvarchar(2)
		DECLARE	@dlct		DECIMAL(18,4),@ilct	DECIMAL(18,4),@dpam DECIMAL(18,4),@eqex DECIMAL(18,4),@faut	DECIMAL(18,4)
		DECLARE	@cmpt		DECIMAL(18,4),@supp DECIMAL(18,4),@tren	DECIMAL(18,4),@oter DECIMAL(18,4),@Sern	NVARCHAR(12)
		DECLARE	@matl		DECIMAL(18,4)


		SET @Proj_area = 0
		SET @temp_unit = 1

    -- Insert statements for procedure here
	IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#Result') AND TYPE = 'U')
		DROP TABLE #Result

	CREATE TABLE #Result
	(
		Plant						nvarchar(2),
		Project						nvarchar(10),
		MOH_Version					nvarchar(8),
		Cost_Version				int,
		BOM_version					int,
		Creation_Date				datetime,
		Creation_User				nvarchar(10),
		Last_Calculate_Date			datetime,
		Cost_Sheet_Status			nvarchar(15),
		Unit_Set					decimal(18,4),
		Set_PNL						decimal(18,4),
		PNL_area					decimal(18,4),
		Scrap_Rate_Being_Used		decimal(18,2),
		Laminate					decimal(18,4),
		Prepreg						decimal(18,4),
		Copper_Foil					decimal(18,4),
		RCC_Foil					decimal(18,4),
		Coin						decimal(18,4),
		Dry_Film					decimal(18,4),
		SMCM						decimal(18,4),
		FCCL						decimal(18,4),
		Coverlay					decimal(18,4),
		Adhesive					decimal(18,4),
		Stiffener					decimal(18,4),
		Sheildling_Film				decimal(18,4),
		Gold						decimal(18,4),
		Drill_Bit					decimal(18,4),
		Bevelling_Tool				decimal(18,4),
		Countersink					decimal(18,4),
		Miling_Tool					decimal(18,4),
		Router						decimal(18,4),
		Other_EDM_Mat				decimal(18,4),
		Total_Material_Cost			decimal(18,4),
		Direct_Labor				decimal(18,4),
		Indirect_Salaries_Benefit	decimal(18,4),
		Depreciation_Amortization	decimal(18,4),
		Equipment_Expenses			decimal(18,4),
		Facilities_Utilities		decimal(18,4),
		Computer_Related			decimal(18,4),
		Supplies					decimal(18,4),
		Travel_Entertainment		decimal(18,4),
		Other_Expenses				decimal(18,4),
		SGA_Cost					decimal(18,4),
		Calculate_Unit				nvarchar(10)
	)

	-- add new logic, if item is upload by manual,then used it first
		INSERT INTO #Result
		SELECT TOP 1
			Plant,
			ProjectNo,
			FromSern,
			NewCostModelVers,
			FromBOM,
			UploadDate,
			UploadUser,
			CalculateDate,
			NULL,
			UnitSet,
			SetPNL,
			PNLArea,
			ScrapRateBeingUsed,
			Laminate,
			Prepreg,
			CopperFoil,
			RCCFoil,
			Coin,
			DryFilm,
			SMCM,
			FCCL,
			Coverlay,
			Adhesive,
			Stiffener,
			SheildlingFilm,
			Gold,
			DrillBit,
			BevellingTool,
			Countersink,
			MilingTool,
			Router,
			OtherEDMMat,
			TotalMaterialCost,
			DirectLabor,
			IndirectSalariesBenefit,
			DepreciationAmortization,
			EquipmentExpenses,
			FacilitiesUtilities,
			ComputerRelated,
			Supplies,
			TravelEntertainment,
			OtherExpenses,
			SGACost,
			CalculateUnit	
		FROM Quotation_Detailed WHERE ProjectNo = @Item ORDER BY ID DESC
	-- end

	IF NOT EXISTS(SELECT TOP 1 * FROM #Result)
		BEGIN
			IF LEFT(LTRIM(@ITEM),1) = '$'			-- Quick cost
				BEGIN
					SELECT @max_sern = MAX(T$SERN) FROM vw_tfsbom400180 WHERE	T$PJNO = @ITEM 

					-- Calculate MI Information
						IF EXISTS(SELECT TOP 1 T$PLNT FROM vw_tfsbom400180 WHERE T$PJNO = @ITEM AND T$PLNT = '2F')
							BEGIN
								SELECT TOP 1 @Proj_area =  CAST(T$PANL * T$PANW *1.0 / 92900 AS DECIMAL(18,4)),
									@Proj_cbpn = t$cbpn,@Proj_unst = t$unst
								FROM vw_TFSAMI002180
								WHERE	LEFT(T$PJNO,10) = @ITEM
								AND		T$PRJ4 = RIGHT(LEFT(@ITEM,7),4)
								ORDER BY T$SIDE ASC
							END
						ELSE
							BEGIN
								SELECT TOP 1 @Proj_area =  CAST(T$PANL * T$PANW *1.0 / 92900 AS DECIMAL(18,4)),
									@Proj_cbpn = t$cbpn,@Proj_unst = t$unst 
								FROM vw_TFSAMI002180
								WHERE	T$PJNO = LTRIM(RTRIM(@ITEM))+'-00'
							END

							IF @Proj_area = 0 OR @Proj_area IS NULL
								BEGIN
									SELECT	@Pnl_size = T$ASTR
									FROM	vw_tfsbom457180
									WHERE	T$ATTR = 'PC  '
									AND		T$PJNO = @item 
									AND		T$SERN = @max_sern

									SELECT	@Proj_cbpn = T$ASTR
									FROM	vw_tfsbom457180
									WHERE	T$ATTR ='SP  '
									AND		T$PJNO = @item 
									AND		T$SERN = @max_sern

									SELECT	@Proj_unst = T$ASTR
									FROM	vw_tfsbom457180
									WHERE	T$ATTR ='US  '
									AND		T$PJNO = @item 
									AND		T$SERN = @max_sern
								END

							SET @temp_unit = @Proj_cbpn * @Proj_unst

							IF @Pnl_size <> 0 
								BEGIN
									SELECT @Proj_area = T$FILL * T$WRAP * 1.0 / 92900
									FROM	vw_tfsami111180
									WHERE	t$code = @Pnl_size
								END

							IF @temp_unit = 0 OR @temp_unit IS NULL
								SET @temp_unit = 1

					-- Get Quick cost Information
						--SELECT	t$plnt,
						--		t$pjno,
						--		t$mver,
						--		t$sern,
						--		t$vers,
						--		t$crdt,
						--		t$crid,
						--		t$lcdt,
						--		t$stat,
						--		@Proj_cbpn,
						--		@Proj_unst,
						--		@Proj_area,
						--		t$ou13,
						--		t$mr13,
						--		t$masp,
						--		t$busp,
						--		cast(t$cesp/@temp_unit as decimal(18,4)),
						--		cast(t$cisp/@temp_unit as decimal(18,4)),
						--		cast(t$dlip/@temp_unit as decimal(18,4)),
						--		cast(t$ilip/@temp_unit as decimal(18,4)),
						--		cast(t$mdsp/@temp_unit as decimal(18,4)),
						--		cast(t$ldip/@temp_unit as decimal(18,4)),
						--		cast(t$ldmp/@temp_unit as decimal(18,4)),
						--		cast(t$tcip/@temp_unit as decimal(18,4)),
						--		cast(t$gsrp as decimal(18,4)),
						--		cast(t$tcup/@temp_unit as decimal(18,4))
						--FROM vw_tfsbom400180 
						--WHERE	T$PJNO = @ITEM 
						--AND		T$SERN = @max_sern

						/* system not support pivot
						SELECT 'aaa' AS item,[5],[10],[15],[20],[25],[30],[35],[40],[45],[50],[55],[60],[65],[70],[81],[82],[83],[84],[85] 
						FROM
						(
								SELECT	T$SQNO,SUM(T$COSP) AS T$COSP 
								FROM	vw_tfsbom401180
								WHERE	T$PJNO = '$21021FAY1'
								AND		T$SERN = 1
								GROUP BY T$SQNO
						) AS A
						PIVOT
						(
							SUM(T$COSP)
							FOR T$SQNO in([5],[10],[15],[20],[25],[30],[35],[40],[45],[50],[55],[60],[65],[70],[81],[82],[83],[84],[85])
						) AS P
						*/

						IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempMalCost') AND TYPE = 'U')
							DROP TABLE #tempMalCost

						SELECT	T$SQNO,SUM(T$COSP) AS T$COSP
						INTO	#tempMalCost
						FROM	vw_tfsbom401180
						WHERE	T$PJNO = @ITEM
						AND		T$SERN = @max_sern
						GROUP BY T$SQNO

						SELECT @lmt  = T$COSP FROM #tempMalCost WHERE T$SQNO = 5
						SELECT @ppg  = T$COSP FROM #tempMalCost WHERE T$SQNO = 10
						SELECT @cfl  = T$COSP FROM #tempMalCost WHERE T$SQNO = 15
						SELECT @rcc  = T$COSP FROM #tempMalCost WHERE T$SQNO = 20
						SELECT @drl  = T$COSP FROM #tempMalCost WHERE T$SQNO = 25
						SELECT @dry  = T$COSP FROM #tempMalCost WHERE T$SQNO = 30
						SELECT @smcm = T$COSP FROM #tempMalCost WHERE T$SQNO = 35
						SELECT @bev  = T$COSP FROM #tempMalCost WHERE T$SQNO = 40
						SELECT @cou  = T$COSP FROM #tempMalCost WHERE T$SQNO = 45
						SELECT @mil  = T$COSP FROM #tempMalCost WHERE T$SQNO = 50
						SELECT @rou  = T$COSP FROM #tempMalCost WHERE T$SQNO = 55
						SELECT @gold = T$COSP FROM #tempMalCost WHERE T$SQNO = 60
						SELECT @edm  = T$COSP FROM #tempMalCost WHERE T$SQNO = 65
						SELECT @coin = T$COSP FROM #tempMalCost WHERE T$SQNO = 70
						SELECT @fccl = T$COSP FROM #tempMalCost WHERE T$SQNO = 81
						SELECT @cov  = T$COSP FROM #tempMalCost WHERE T$SQNO = 82
						SELECT @adh  = T$COSP FROM #tempMalCost WHERE T$SQNO = 83
						SELECT @sti  = T$COSP FROM #tempMalCost WHERE T$SQNO = 84
						SELECT @she  = T$COSP FROM #tempMalCost WHERE T$SQNO = 85

						SELECT	@dlct = SUM(T$DLCT),
								@ilct = SUM(T$ILCT),
								@dpam = SUM(T$DPAM),
								@eqex = SUM(T$EQEX),
								@faut = SUM(T$FAUT),
								@cmpt = SUM(T$CMPT),
								@supp = SUM(T$SUPP),
								@tren = SUM(T$TREN),
								@oter = SUM(T$OTER)
						FROM	vw_tfsbom421180
						WHERE	T$PJNO = @ITEM
						AND		T$SERN = @max_sern	

						INSERT INTO #Result
						SELECT	T$PLNT,
								T$PJNO,
								T$MVER,
								T$SERN,
								T$VERS,
								T$CRDT,
								T$CRID,
								T$LCDT,
								T$STAT,
								@Proj_cbpn,
								@Proj_unst,
								@Proj_area,
								T$BUSP,
								CAST(ISNULL(@lmt,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@ppg,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@cfl,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@rcc,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@coin,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@dry,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@smcm,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@fccl,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@cov,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@adh,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@sti,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@she,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@gold,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@drl,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@bev,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@cou,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@mil,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@rou,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@edm,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(T$CESP/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@dlct,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@ilct,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@dpam,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@eqex,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@faut,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@cmpt,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@supp,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@tren,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(ISNULL(@oter,0)/@temp_unit AS DECIMAL(18,4)),
								CAST(T$GSRP/@temp_unit AS DECIMAL(18,4)),
								''
						FROM	vw_tfsbom400180
						WHERE T$PJNO = @Item AND T$SERN = @max_sern
				

				END
			-- Standard cost from re-calculate from fsbom4172m000
			ELSE									-- Standard cost
				BEGIN
					SELECT TOP 1 @Sern =  T$USRN,@Plant = T$PLNT
					FROM [dbo].[vw_tfsbom473180] WHERE T$PJNO = @Item ORDER BY T$USRN DESC

					-- Get MI Information
					IF @Plant <> '2F'
						BEGIN
							SELECT TOP 1 @Proj_area = CAST((T$PANL *T$PANW * 1.0/92900) AS DECIMAL(18,4)),
							@Proj_cbpn = t$cbpn,@Proj_unst = t$unst
							FROM	vw_tfsami002180
							WHERE	T$PRJ4 = RIGHT(LEFT(@Item,7),4) 
							AND		LEFT(T$PJNO,10) = @Item
							ORDER BY T$SIDE ASC
						END
					ELSE
						BEGIN
							SELECT TOP 1 @Proj_area =  CAST(T$PANL * T$PANW *1.0 / 92900 AS DECIMAL(18,4)),
										@Proj_cbpn = t$cbpn,
										@Proj_unst = t$unst 
							FROM vw_TFSAMI002180
							WHERE	T$PJNO = LTRIM(RTRIM(@ITEM))+'-00'
						END

					-- Get Cost sheet information
						IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempMalCost0') AND TYPE = 'U')
							DROP TABLE #tempMalCost0

						SELECT B.T$MATS,SUM(A.T$COST) AS T$COST
						INTO #tempMalCost0
						FROM	[dbo].[vw_tfsbom499180] AS A,[dbo].[vw_tfsatt010180] AS B
						WHERE	A.T$USRN = @Sern
						AND		A.T$PJNO = @Item
						AND		A.T$CITG = ' IG008'
						AND		A.T$ITEM = B.T$ITEM
						GROUP BY B.T$MATS

						SELECT @drl = T$COST FROM #tempMalCost0 WHERE T$MATS = 'DRILL BIT'
						SELECT @mil = T$COST FROM #tempMalCost0 WHERE T$MATS = 'MILING TOOL'
						SELECT @rou = T$COST FROM #tempMalCost0 WHERE T$MATS = 'ROUTER'
						SELECT @cou = T$COST FROM #tempMalCost0 WHERE T$MATS = 'COUNTERSINK'
						SELECT @bev = T$COST FROM #tempMalCost0 WHERE T$MATS = 'BEVELLING TOOL'

						SET @drl = ISNULL(@drl,0)
						SET @mil = ISNULL(@mil,0)
						SET @rou = ISNULL(@rou,0)
						SET @cou = ISNULL(@cou,0)
						SET @bev = ISNULL(@bev,0)

						IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempMalCost1') AND TYPE = 'U')
							DROP TABLE #tempMalCost1

						SELECT T$CITG,SUM(T$COST) AS T$COST
						INTO #tempMalCost1
						FROM	[dbo].[vw_tfsbom499180]
						WHERE	T$USRN = @Sern
						AND		T$PJNO = @Item
						GROUP BY T$CITG

						SELECT @cfl  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG002'
						SELECT @dry  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG003'
						SELECT @lmt  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG004'
						SELECT @ppg  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG005'
						SELECT @rcc  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG006'
						SELECT @smcm = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG007'
						SELECT @coin = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG207'
						SELECT @fccl = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG011'
						SELECT @cov  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG012'
						SELECT @adh  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG013'
						SELECT @sti  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG014'
						SELECT @she  = T$COST FROM #tempMalCost1 WHERE LTRIM(RTRIM(T$CITG)) = 'IG015'

						SELECT	@gold = SUM(T$COCO),
								@edm  = SUM(T$PSMC),
								@dlct = SUM(T$DLCT),
								@ilct = SUM(T$ILCT),
								@dpam = SUM(T$DPAM),
								@eqex = SUM(T$EQEX),
								@faut = SUM(T$FAUT),
								@cmpt = SUM(T$CMPT),
								@supp = SUM(T$SUPP),
								@tren = SUM(T$TREN),
								@oter = SUM(T$OTER)
						FROM	[dbo].[vw_tfsbom474180]
						WHERE	T$USRN = @SERN
						AND		T$PJNO = @ITEM

						SET @matl =  @lmt + @ppg + @cfl + @rcc + @drl + @dry + @smcm + @bev + @cou + @mil +	@rou + @gold + @edm + @fccl + @cov + @adh + @sti + @she + @coin	

						INSERT INTO #Result
						SELECT	T$PLNT,
								T$PJNO,
								T$NMVS,
								T$SERN,
								T$VERS,
								NULL,
								NULL,
								NULL,
								NULL,
								ISNULL(@Proj_unst,0),
								ISNULL(@Proj_cbpn,0),
								ISNULL(@proj_area,0),
								ISNULL(T$BUSP*100,0)/100,
								ISNULL(@lmt,0),
								ISNULL(@ppg,0),
								ISNULL(@cfl,0),
								ISNULL(@rcc,0),
								ISNULL(@coin,0),
								ISNULL(@dry,0),
								ISNULL(@smcm,0),
								ISNULL(@fccl,0),
								ISNULL(@cov,0),
								ISNULL(@adh,0),
								ISNULL(@sti,0),
								ISNULL(@she,0),
								ISNULL(@gold,0),
								ISNULL(@drl,0),
								ISNULL(@bev,0),
								ISNULL(@cou,0),
								ISNULL(@mil,0),
								ISNULL(@rou,0),
								ISNULL(@edm,0),
								ISNULL(@matl,0),
								ISNULL(@dlct,0),
								ISNULL(@ilct,0),
								ISNULL(@dpam,0),
								ISNULL(@eqex,0),
								ISNULL(@faut,0),
								ISNULL(@cmpt,0),
								ISNULL(@supp,0),
								ISNULL(@tren,0),
								ISNULL(@oter,0),
								ISNULL(T$GSRP,0),
								''
						FROM	[dbo].[vw_tfsbom473180]
						WHERE	T$USRN = @SERN
						AND		T$PJNO = @ITEM
				END
		END
	SELECT * FROM #Result
END
GO

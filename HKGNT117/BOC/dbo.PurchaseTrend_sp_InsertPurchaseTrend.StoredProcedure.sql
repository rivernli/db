USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseTrend_sp_InsertPurchaseTrend]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*=============================================
 Author:		<Author,,Rivern Li>
 Create date: <Create Date,2010/03/26,>
 Description:	<Description,Purchase Report,>
-- =============================================*/

CREATE proc [dbo].[PurchaseTrend_sp_InsertPurchaseTrend]
	@TransType				NVARCHAR(5),
	@YearFROM				NVARCHAR(5),
	@YearTo					NVARCHAR(5),
	@PeriodFROM				NVARCHAR(5),
	@PeriodTo				NVARCHAR(5),
	@Item_Group_FROM		NVARCHAR(5),
	@Item_Group_To			NVARCHAR(5),
	@Vendor_FROM			NVARCHAR(5),
	@Vendor_To				NVARCHAR(5),
	@Plant_FROM				NVARCHAR(5),
	@Plant_To				NVARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;

/******************************* Valiable declaration section ***************************
declaration

	table	ttdinv700	|4602865
	table	tfscpp700	|4
	table	tfscpp790	|52
	table	ttfgld005	|221
	table	ttiitm001	|115913
	table	ttdpur040	|128060
	table	ttdpur030	|156852
	table	ttccom020	|4402
	table	ttcmcs008	|721
	table	tfsbom316	|18

****************************** field section ******************************************/

	SET @YearFROM =				ISNULL(@yearFROM,'')
	SET @YearTo =				ISNULL(@YearTo,'')
	SET @PeriodFROM =			ISNULL(@PeriodFROM,'')
	SET @PeriodTo =				ISNULL(@PeriodTo,'')
	SET @Item_Group_FROM =		ISNULL(@Item_Group_FROM,'')
	SET @Item_Group_To =		ISNULL(@Item_Group_To,'')
	SET @Vendor_FROM =			ISNULL(@Vendor_FROM,'')
	SET @Vendor_To =			ISNULL(@Vendor_To,'')
	SET @Plant_FROM =			ISNULL(@Plant_FROM,'')
	SET @Plant_To =				ISNULL(@Plant_To,'')
	SET @TransType =			ISNULL(@TransType,'')
	
	DECLARE @Start_Date			DATETIME
	DECLARE @End_Date			DATETIME
	DECLARE @Last_Start_Date	DATETIME
	DECLARE @Last_End_Date		DATETIME
	DECLARE @MAXID				INT
	DECLARE @LOOP				INT
	DECLARE @ITEM				INT
	DECLARE	@Sum_Iqty			DECIMAL(18,2)
	DECLARE	@Total_rqty			DECIMAL(18,2)
	DECLARE	@AVG_PRICE			DECIMAL(18,2)
	DECLARE	@Total_samt			DECIMAL(18,2)
	DECLARE	@Total_sqty			DECIMAL(18,2)
	DECLARE	@Total_umnt			DECIMAL(18,2)
	DECLARE	@ISSUE_AMNT			DECIMAL(18,2)
	DECLARE	@AVG_T_PRICE		DECIMAL(18,2)
	DECLARE	@AVG_CU_PRIC		DECIMAL(18,2)
	DECLARE	@Total_amnt			DECIMAL(18,2)
	DECLARE	@SUNO				NVARCHAR(30)

--****************************** choice section ******************************************

--	IF NOT EXISTS(SELECT TOP 1 t$ptyp FROM TTFGLD005180 WHERE t$ptyp = 1 AND t$year = @YearFROM AND t$prno = @PeriodFROM)
--		BEGIN
--			RAISERROR('Base On Range Error!',16,1) RETURN
--		END
--
--	IF NOT EXISTS(SELECT TOP 1 t$ptyp FROM TTFGLD005180 WHERE t$ptyp = 1 AND t$year = @YearTo AND t$prno = @PeriodTo)
--		BEGIN
--			RAISERROR('Base On Range Error!',16,1)	RETURN
--		END
	
	IF @YearFROM > @YearTo
		BEGIN
			RAISERROR('Base On Range Error!',16,1)	RETURN
		END

	IF @YearFROM = @YearTo AND @PeriodFROM > @PeriodTo
		BEGIN
			RAISERROR('Base On Range Error!',16,1)	RETURN
		END		

	IF @YearFROM = 0 OR @YearTo = 0 
		BEGIN
			RAISERROR('Year cannot be empty!',16,1)	RETURN
		END

	IF @PeriodFROM = 0 OR @PeriodTo = 0
		BEGIN
			RAISERROR('Period cannot be empty!',16,1) RETURN
		END	

--****************************** choice section ******************************************
--Functions
	
	SELECT	 A.T$ITEM,B.T$CITG,C.T$PLNT,SUM(A.T$QUAN) AS Sum_Iqty into #temp_tdinv700180
	FROM	 FactoryLoading.dbo.TTDINV700180 AS A LEFT JOIN FactoryLoading.dbo.TTIITM001180 AS B
	ON		 A.T$ITEM = B.T$ITEM LEFT JOIN TFSBOM316180 AS C 
	ON		 A.T$CWAR = C.T$CWAR
	WHERE	 A.T$TRDT BETWEEN @Start_Date and @End_Date
	AND		 A.T$KOST = @TransType
	AND		 C.T$PLNT BETWEEN @Plant_FROM AND @Plant_TO
	AND		 B.T$CITG BETWEEN @Item_Group_FROM AND @Item_Group_TO
	GROUP BY A.T$ITEM,B.T$CITG,C.T$PLNT
	ORDER BY A.T$ITEM ASC

	DELETE #temp_tdinv700180 WHERE Sum_Iqty = 0
	ALTER TABLE #temp_tdinv700180 ADD ID INT IDENTITY
	CREATE INDEX pk_#temp_tdinv700180 ON #temp_tdinv700180 (ID,T$ITEM)

	SELECT @MAXID = MAX(ID) FROM #temp_tdinv700180
	SET @LOOP = 1
	WHILE(@LOOP <= @MAXID)
		BEGIN
			SELECT @ITEM = A.T$ITEM,@Sum_Iqty = Sum_Iqty FROM #temp_tdinv700180 WHERE ID = @LOOP

			SELECT TOP 1 @SUNO = T$SUNO FROM TTDPUR030180 WHERE T$SUNO BETWEEN @Vendor_FROM AND @Vendor_To AND T$ITEM = @ITEM ORDER BY T$STDT DESC

--			-- Get Last 3 Period Price
--			SELECT	A.T$DQUA,A.T$PRIC,A.T$DISC,B.T$RATP,
--				@Total_rqty = SUM(T$A.DQUA),
--				@Total_amnt = SUM(A.T$DQUA * A.T$PRIC * B.T$RATP * (100-A.T$DISC/100)),
--				@Total_umnt = SUM(A.T$DQUA * A.T$PRIC * (100 - A.T$DISC/100))
--			FROM	TTDPUR045180 AS A LEFT JOIN TTDPUR040180		AS B
--			ON		A.T$ORNO = B.T$ORNO LEFT JOIN TFSBOM316180		AS C 
--			ON		A.T$CWAR = C.CWAR LEFT JOIN #temp_tdinv700180	AS D
--			ON		A.T$ITEM = D.T$ITEM
--			WHERE	A.T$DATE BETWEEN @Last_Start_Date and @Last_End_date
--			AND		A.T$ITEM = @ITEM
--			AND		A.T$DQUA <> 0
--			AND		A.T$DATE <> 0
--			AND		A.T$SRNB <> 0
--			GROUP BY A.T$DQUA,A.T$PRIC,A.T$DISC,B.T$RATP

			IF @Total_rqty <> 0 
				BEGIN
					SET @AVG_PRICE   = CAST(@Total_amnt/@Total_rqty AS DECIMAL(18,1))
					SET @AVG_T_PRICE = CAST(@Total_umnt/@Total_rqty AS DECIMAL(18,1))
					SET @ISSUE_AMNT  = CAST(@Sum_Iqty * @AVG_PRICE AS DECIMAL (18,1))
				END
			ELSE
				BEGIN
					SELECT @AVG_PRICE = T$COPR FROM TTIITM001180 WHERE T$ITEM = @ITEM
					SET @ISSUE_AMNT  = CAST(@Sum_Iqty * @AVG_PRICE AS DECIMAL (18,1))

					SELECT @AVG_T_PRICE = CAST(@AVG_PRICE / T$RATP AS DECIMAL(18,1)) FROM TTCCOM020180 AS A LEFT JOIN TTCMCS008180 AS B
					ON A.CCUR = B.T$CCUR
					WHERE A.T$SUNO = @SUNO
				END

--			-- Get Current Price
--			SELECT	A.T$DQUA,A.T$PRIC,A.T$DISC,B.T$RATP,
--				@Total_sqty = SUM(T$A.DQUA),
--				@Total_samt = SUM(A.T$DQUA * A.T$PRIC * B.T$RATP * (100-A.T$DISC/100)),
--				Total_dmnt  = SUM(A.T$DQUA * A.T$PRIC * (100 - A.T$DISC/100))
--			FROM	TTDPUR045180 AS A LEFT JOIN TTDPUR040180		AS B
--			ON		A.T$ORNO = B.T$ORNO LEFT JOIN TFSBOM316180		AS C 
--			ON		A.T$CWAR = C.CWAR LEFT JOIN #temp_tdinv700180	AS D
--			ON		A.T$ITEM = D.T$ITEM
--			WHERE	A.T$DATE BETWEEN @Start_Date and @End_date
--			AND		A.T$ITEM = @ITEM
--			AND		A.T$DQUA <> 0
--			AND		A.T$DATE <> 0
--			AND		A.T$SRNB <> 0
			
			IF @Total_sqty <> 0 
				BEGIN
					SET @AVG_CU_PRIC = CAST(@Total_samt/@Total_sqty AS DECIMAL(18,2))
					
				END
		END
END
GO

USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrend_New]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/03/26,>
-- Description:	<Description,Purchase Report,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrend_New]
	@YearFROM		NVARCHAR(5),
	@YearTo		NVARCHAR(5),
	@PeriodFROM	NVARCHAR(5),
	@PeriodTo		NVARCHAR(5),
	@Item_Group_FROM		NVARCHAR(5),
	@Item_Group_To			NVARCHAR(5),
	@Vendor_FROM			NVARCHAR(5),
	@Vendor_To				NVARCHAR(5),
	@Plant_FROM				NVARCHAR(5),
	@Plant_To				NVARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;
--****************************** Valiable declaration section ***************************
--declaration
	DECLARE @Temp_Fyear		INT
	DECLARE @Temp_Period	INT
	DECLARE @Period_Count	INT
	DECLARE @sqlString		NVARCHAR(500)

--	table	ttdinv700	|4602865
--	table	tfscpp700	|4
--	table	tfscpp790	|52
--	table	ttfgld005	|221
--	table	ttiitm001	|115913
--	table	ttdpur040	|128060
--	table	ttdpur030	|156852
--	table	ttccom020	|4402
--	table	ttcmcs008	|721
--	table	tfsbom316	|18

--****************************** field section ******************************************

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

--****************************** choice section ******************************************

--	IF NOT EXISTS(SELECT TOP 1 t$ptyp FROM TTFGLD005180 WHERE t$ptyp = 1 AND t$year = @YearFROM AND t$prno = @PeriodFROM)
--		BEGIN
--			RAISERROR('Base On Range Error!',16,1)
--			RETURN
--		END
--
--	IF NOT EXISTS(SELECT TOP 1 t$ptyp FROM TTFGLD005180 WHERE t$ptyp = 1 AND t$year = @YearTo AND t$prno = @PeriodTo)
--		BEGIN
--			RAISERROR('Base On Range Error!',16,1)
--			RETURN
--		END
	
	IF @YearFROM > @YearTo
		BEGIN
			RAISERROR('Base On Range Error!',16,1)
			RETURN
		END

	IF @YearFROM = @YearTo AND @PeriodFROM > @PeriodTo
		BEGIN
			RAISERROR('Base On Range Error!',16,1)
			RETURN
		END		
END

GO

USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Saving_Query_Base_On_Range]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Saving_Query_Base_On_Range]
	@Plant			NVARCHAR(10),
	@YearFrom		INT,
	@PeriodFrom		INT,
	@YearTo			INT,
	@PeriodTo		INT,
	@YearBaseon		INT,
	@PeriodBaseOn	INT,
	@Range			INT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @DateFrom		DATETIME
	DECLARE @DateTo			DATETIME

	SET @Plant = LTRIM(RTRIM(@Plant))
	SET @Plant = ISNULL(@Plant,'')
	
	--  Paramater data check
	IF @PeriodFrom > 12
		BEGIN
			RAISERROR('Period can not more then 12 !',16,1)
			RETURN
		END
	IF @PeriodTo > 12 
		BEGIN
			RAISERROR('Period can not more then 12 !',16,1)
			RETURN
		END
	IF @PeriodBaseOn > 12
		BEGIN
			RAISERROR('Period can not more then 12 !',16,1)
			RETURN
		END

	-- Get Date Range	
--	SELECT @DateFrom = T$STDT FROM dbo.TTFGLD005180 WHERE T$YEAR = @YearFrom AND T$PRNO = @PeriodFrom AND T$PTYP = 1
--	SELECT @DateTo   = T$STDT FROM dbo.TTFGLD005180 WHERE T$YEAR = @YearTo   AND T$PRNO = @PeriodTo   AND T$PTYP = 1

END

GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Quarterly_OEM]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Quarterly_OEM]
	@Year INT,
	@Quarter INT,
	@Type VARCHAR(50),
	@ZF CHAR(1)=NULL,
	@TargetOEM VARCHAR(100)=NULL
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateFrom DATE,@DateTo DATE
    SET @DateFrom=(SELECT TOP 1 FiscalQuarterFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter)
    SET @DateTo=(SELECT TOP 1 FiscalQuarterTo FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter)

	SELECT *,
		(B1+B3+B4+B5+VVI) AS TotalEXB2F,
		(B1+B2F+B3+B4+B5+VVI) AS Total
	INTO #Temp
	FROM (
			SELECT a.T$DESC AS Type,a.T$CSGS AS OEM,
				CONVERT(NUMERIC(19,4),(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='P2' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
				)) AS B1,
				CONVERT(NUMERIC(19,4),(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='2F' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
				)) AS B2F,
				CONVERT(NUMERIC(19,4),(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B3' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
				)) AS B3,
				CONVERT(NUMERIC(19,4),(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B4' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
				)) AS B4,
				CONVERT(NUMERIC(19,4),(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B5' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
				)) AS B5,
				CONVERT(NUMERIC(19,4),(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='HK' AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
				)) AS VVI
			FROM TFSOLP121180 a
			WHERE a.T$TRDT  BETWEEN @DateFrom AND @DateTo
			GROUP BY a.T$DESC,a.T$CSGS
		) c
	WHERE (B1<>0 OR B2F<>0 OR B3<>0 OR B4<>0 OR B5<>0 OR VVI<>0) 
		AND Type=@Type
	ORDER BY c.Type DESC,(B1+B2F+B3+B4+B5+VVI) DESC,c.OEM ASC

	SELECT * INTO #Temp1 FROM #Temp 
	DELETE #Temp1
	
	IF @ZF='Z'
		BEGIN
			INSERT INTO #Temp1
			SELECT *  FROM #Temp WHERE Total>=0 ORDER BY OEM
		END
	IF @ZF='F'
		BEGIN
			INSERT INTO #Temp1
			SELECT * FROM #Temp WHERE Total<0 ORDER BY OEM
		END
	IF @ZF IS NULL
		BEGIN
			INSERT INTO #Temp1
			SELECT * FROM #Temp  ORDER BY OEM
		END

	IF @TargetOEM IS NULL
		BEGIN
			SELECT * FROM #Temp1  
		END
	ELSE
		BEGIN
			SELECT * FROM #Temp1 WHERE OEM LIKE RTRIM(LTRIM(@TargetOEM))+'%' 
			UNION ALL
			SELECT * FROM #Temp1 WHERE OEM NOT LIKE RTRIM(LTRIM(@TargetOEM))+'%' 
		END
END
GO

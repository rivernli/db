USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_OEM1_F_P_TOPX_MRB_P]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_OEM1_F_P_TOPX_MRB_P]
	@y1		INT,
	@y2		INT,
	@x1		INT=0,
	@x2		INT=0,
	@topx	INT,
	@topc	VARCHAR(MAX),
	@uom	VARCHAR(15),
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @a1 INT, @a2 INT

	SET @a1=@y1*100+@x1
	SET @a2=@y2*100+@x2

	
	--FG OUT FOR CUSTOMER TOTAL
	SELECT
		T$CSGS AS A
		,FiscalPeriodDesc AS B
		,SUM(T$DOLS) Z
	INTO #TEMP1
	FROM TFSOLP105180_HKG111_New
	WHERE
		FiscalYear*100+FiscalPeriod BETWEEN @a1 AND @a2
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$CSGS,FiscalPeriodDesc
	
	--MRB FOR CUSTOMER TOTAL
	SELECT
		T$OEMN AS A
		,FiscalPeriodDesc AS B
		,SUM(T$MCOS) AS Z
	INTO #TEMP2
	FROM MRB_TFSOLP128180_New
	WHERE
		FiscalYear*100+FiscalPeriod BETWEEN @a1 AND @a2
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$OEMN,FiscalPeriodDesc
	
	-- MRB/FG OUT
	SELECT
		A
		,Z
		,ROW_NUMBER() OVER(ORDER BY Z DESC) AS ROWID
	INTO #TEMP
	FROM (
		SELECT
			t1.A
			,t2.Z/t1.Z AS Z
		FROM
			(SELECT A,SUM(Z) AS Z FROM #TEMP1 GROUP BY A) t1,
			(SELECT A,SUM(Z) AS Z FROM #TEMP2 GROUP BY A) t2
		WHERE t1.A=t2.A
	) A

	--GET TOP CUSTOMER
	IF @topx=0
		SELECT @topx=COUNT(*) FROM #TEMP
	
	--SUMMARY
	SELECT
		t1.A
		,t1.B
		,(t2.Z/t1.Z)*100 AS Z
	FROM #TEMP1 t1,#TEMP2 t2
	WHERE
		t1.A=t2.A AND t1.B=t2.B
	AND
		t1.A IN (SELECT A FROM #TEMP WHERE ROWID<=@topx)
END









GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_OEM2_C_P_TOPX]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_OEM2_C_P_TOPX]
	@y1		INT,
	@y2		INT,
	@x1		INT=0,
	@x2		INT=0,
	@topx	INT,
	@topc	VARCHAR(MAX),
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @a1 INT, @a2 INT

	SET @a1=@y1*100+@x1
	SET @a2=@y2*100+@x2
	
	SELECT
		A,
		Z,
		ROW_NUMBER() OVER(ORDER BY Z DESC) AS ROWID
	INTO #TEMP
	FROM (
		SELECT
			T$OEMN AS A
			,SUM(T$MSQF) AS Z
		FROM MRB_TFSOLP128180_New
		WHERE
			calenderYear*100+calenderMonth BETWEEN @a1 AND @a2
		AND
			T$PLNT=@st
		GROUP BY T$OEMN
	) A

	--
	IF @topx=0
		SELECT @topx=COUNT(*) FROM #TEMP
	
	--
	SELECT
		T$OEMN AS A
		,calenderMonthDesc AS B
		,SUM(T$MSQF) AS Z
	FROM MRB_TFSOLP128180_New
	WHERE
		calenderYear*100+calenderMonth BETWEEN @a1 AND @a2
	AND
		T$PLNT=@st
	AND
		T$OEMN IN (SELECT A FROM #TEMP WHERE ROWID<=@topx)
	GROUP BY T$OEMN,calenderMonthDesc
END








GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Site1_Weekly_mrb_p_F]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Site1_Weekly_mrb_p_F]
	@y1		INT,
	@y2		INT,
	@q1		INT,
	@q2		INT,
	@uom	VARCHAR(15),
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	
	--FG OUT
	SELECT
		T$PLNT AS A
		,FiscalWeekDesc AS B
		,SUM(T$DOLS) Z
	INTO #TEMP1
	FROM TFSOLP105180_HKG111_New
	WHERE FiscalYear*100+FiscalWeek BETWEEN @y1*100+@q1 AND @y2*100+@q2
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$PLNT,FiscalWeekDesc


	--MRB$
	SELECT
		T$PLNT AS A
		,FiscalWeekDesc AS B
		,SUM(T$MCOS) AS Z
	INTO #TEMP2
	FROM MRB_TFSOLP128180_New
	WHERE
		FiscalYear*100+FiscalWeek BETWEEN @y1*100+@q1 AND @y2*100+@q2
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$PLNT,FiscalWeekDesc
	
	SELECT
		t2.A,
		t2.B,
		(t2.Z/t1.Z)*100 AS Z
	FROM #TEMP2 t2
	,#TEMP1 t1
	WHERE t2.A=t1.A AND t2.B=t1.B
END





GO

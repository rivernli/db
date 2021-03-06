USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Cust1_C_W_TOPC_MRB_P]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Cust1_C_W_TOPC_MRB_P]
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
	
	--
	--FG OUT
	SELECT
		T$DESC AS A
		,calenderWeekDesc AS B
		,SUM(T$DOLS) Z
	INTO #TEMP1
	FROM TFSOLP105180_HKG111_New
	WHERE
		calenderYear*100+calenderWeek BETWEEN @a1 AND @a2
	AND
		CHARINDEX(T$PLNT,@st)>0
	AND
		CHARINDEX('$'+T$DESC+'$',@topc)>0
	GROUP BY T$DESC,calenderWeekDesc


	--MRB$
	SELECT
		T$CUST AS A
		,calenderWeekDesc AS B
		,SUM(T$MCOS) AS Z
	INTO #TEMP2
	FROM MRB_TFSOLP128180_New
	WHERE
		calenderYear*100+calenderWeek BETWEEN @a1 AND @a2
	AND
		CHARINDEX(T$PLNT,@st)>0
	AND
		CHARINDEX('$'+T$CUST+'$',@topc)>0
	GROUP BY T$CUST,calenderWeekDesc
	
	--SUMMARY
	SELECT
		t2.A,
		t2.B,
		(t2.Z/t1.Z)*100 AS Z
	FROM #TEMP2 t2
	,#TEMP1 t1
	WHERE t2.A=t1.A AND t2.B=t1.B

END









GO

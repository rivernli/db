USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Site2_C_W]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Site2_C_W]
	@y1		INT,
	@y2		INT,
	@x1		INT=0,
	@x2		INT=0,
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @a1 INT, @a2 INT

	SET @a1=@y1*100+@x1
	SET @a2=@y2*100+@x2
	
	SELECT
		'Scrap (sqft)' AS A
		,calenderWeekDesc AS B
		,SUM(T$MSQF) AS Z
	FROM MRB_TFSOLP128180_New
	WHERE
		calenderYear*100+calenderWeek BETWEEN @a1 AND @a2
	AND
		T$PLNT=@st
	GROUP BY calenderWeekDesc

END








GO

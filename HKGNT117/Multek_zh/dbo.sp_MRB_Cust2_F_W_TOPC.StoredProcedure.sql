USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Cust2_F_W_TOPC]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Cust2_F_W_TOPC]
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
		T$CUST AS A
		,FiscalWeekDesc B
		,SUM(T$MSQF) AS Z
	FROM MRB_TFSOLP128180_New
	WHERE
		FiscalYear*100+FiscalWeek BETWEEN @a1 AND @a2
	AND
		T$PLNT=@st
	AND
		CHARINDEX('$'+T$CUST+'$',@topc)>0
	GROUP BY T$CUST,FiscalWeekDesc

END







GO

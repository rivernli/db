USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Site1_Quarterly_F]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Site1_Quarterly_F]
	@y1		INT,
	@y2		INT,
	@q1		INT,
	@q2		INT,
	@uom	VARCHAR(15),
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		T$PLNT AS A
		,FiscalQuarterDesc AS B
		,SUM(
			CASE @uom
				WHEN 'mrb_a' THEN T$MCOS
				WHEN 'mrb_sqft_a' THEN T$MRBQ*T$LCNT
				ELSE 0
			END
		) AS Z
	FROM MRB_TFSOLP128180_New
	WHERE
		FiscalYear*100+FiscalQuarter BETWEEN @y1*100+@q1 AND @y2*100+@q2
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$PLNT,FiscalQuarterDesc
END


GO

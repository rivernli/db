USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Site1_Yearly_F]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Site1_Yearly_F]
	@y1		INT,
	@y2		INT,
	@uom	VARCHAR(15),
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @uom='mrb_p'
	BEGIN
		SELECT
			T$PLNT AS A
			,FiscalYearDesc AS B
			,SUM(T$DOLS) Z
		INTO #TEMP
		FROM TFSOLP105180_HKG111_New
		WHERE FiscalYear BETWEEN @y1 AND @y2
		GROUP BY T$PLNT,FiscalYearDesc
	END

	SELECT
		T$PLNT AS A
		,FiscalYearDesc AS B
		,SUM(
			CASE @uom
				WHEN 'mrb_a' THEN T$MCOS
				WHEN 'mrb_sqft_a' THEN T$MRBQ*T$LCNT
				WHEN 'mrb_sqft_p' THEN 0
				WHEN 'mrb_p' THEN dbo.DistributionReport_fun_Get_Amount_HKG111(
					'Calendar',
					'Shipment',
					'Chi',
					T$PLNT,
					T$DATE,
					T$DATE,
					NULL)
				ELSE 0
			END
		) AS Z
	FROM MRB_TFSOLP128180_New
	WHERE
		FiscalYear BETWEEN @y1 AND @y2
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$PLNT,FiscalYearDesc
END


GO

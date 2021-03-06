USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_DeptDetail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_DeptDetail] 
	@CalDate		DATETIME,
	@DEPT			VARCHAR(30)
AS
BEGIN

	SET NOCOUNT ON;

	IF @DEPT='TOTAL'
	BEGIN
		SELECT
			T$OEMA AS OEM,
			T$ITEM AS PROJ,
			T$PLNT AS PLNT,
			SUM(T$AMNT) AS AMNT
		FROM TFSOLP120180 WHERE @CalDate = t$date + 1
		--WHERE T$DPAT = @DEPT
		GROUP BY T$OEMA,T$ITEM,T$PLNT
		ORDER BY T$OEMA,T$ITEM,T$PLNT
	END
	ELSE
	BEGIN
		SELECT
			T$OEMA AS OEM,
			T$ITEM AS PROJ,
			T$PLNT AS PLNT,
			SUM(T$AMNT) AS AMNT
		FROM TFSOLP120180
		WHERE @CalDate = t$date + 1
		AND T$DPAT = @DEPT
		GROUP BY T$OEMA,T$ITEM,T$PLNT
		ORDER BY T$OEMA,T$ITEM,T$PLNT
	END
	
END




GO

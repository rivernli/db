USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_DeptDetail2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_DeptDetail2] 
	@CalDate		DATETIME,
	@DEPT			VARCHAR(10),
	@oem		VARCHAR(50),
	@proj		VARCHAR(50),
	@plant		VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	IF @DEPT='TOTAL'
	BEGIN
		SELECT
			T$ORNO AS ORNO,
			T$PONO AS PONO,
			T$OHDT AS OHDT,
			DATEDIFF(DAY,T$OHDT,GETDATE()) AS OHDS
		FROM TFSOLP120180 WHERE @CalDate = t$date + 1
		--WHERE T$DPAT = @DEPT
		AND T$DPAT = @DEPT
		AND T$OEMA=@oem
		AND T$ITEM=@proj
		AND T$PLNT=@plant
		ORDER BY T$ORNO,T$PONO
	END
	ELSE
	BEGIN
		SELECT
			T$ORNO AS ORNO,
			T$PONO AS PONO,
			T$OHDT AS OHDT,
			DATEDIFF(DAY,T$OHDT,GETDATE()) AS OHDS
		FROM TFSOLP120180
		WHERE @CalDate = t$date + 1
		AND T$DPAT = @DEPT
		AND T$OEMA=@oem
		AND T$ITEM=@proj
		AND T$PLNT=@plant
		ORDER BY T$ORNO,T$PONO
	END
	
END




GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_AgingDetail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_AgingDetail] 
	@CalDate	DATETIME,
	@AGING		VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	
	
	IF @AGING='TOTAL'
	BEGIN
		SELECT
			T$OEMA AS OEM,
			T$ITEM AS PROJ,
			T$PLNT AS PLNT,
			SUM(T$AMNT) AS AMNT
		FROM (SELECT *,
		(CASE
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate)<=30 THEN 'A1' --within 1 month
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 30 AND 60 THEN 'A2' -- 1-2 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 60 AND 180 THEN 'A3' -- 2-6 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 180 AND 360 THEN 'A4' -- 6-12 months
			ELSE 'A5' -- over 1 year
		END) AS AGING FROM TFSOLP120180 WHERE @CalDate = t$date+1) A
		--WHERE AGING=@AGING
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
		FROM (SELECT *,
		(CASE
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate)<=30 THEN 'A1' --within 1 month
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 30 AND 60 THEN 'A2' -- 1-2 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 60 AND 180 THEN 'A3' -- 2-6 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 180 AND 360 THEN 'A4' -- 6-12 months
			ELSE 'A5' -- over 1 year
		END) AS AGING FROM TFSOLP120180 WHERE @CalDate = t$date+1) A
		WHERE AGING=@AGING
		GROUP BY T$OEMA,T$ITEM,T$PLNT
		ORDER BY T$OEMA,T$ITEM,T$PLNT
	END
END




GO

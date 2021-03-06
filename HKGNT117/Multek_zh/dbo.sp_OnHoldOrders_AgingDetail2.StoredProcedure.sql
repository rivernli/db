USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_AgingDetail2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_AgingDetail2] 
	@CalDate	DATETIME,
	@AGING		VARCHAR(10),
	@oem		VARCHAR(50),
	@proj		VARCHAR(50),
	@plant		VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	
	
	IF @AGING='TOTAL'
	BEGIN
		SELECT
			T$ORNO AS ORNO,
			T$PONO AS PONO,
			T$OHDT AS OHDT,
			DATEDIFF(DAY,T$OHDT,GETDATE()) AS OHDS
		FROM (SELECT *,
		(CASE
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate)<=30 THEN 'A1' --within 1 month
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 30 AND 60 THEN 'A2' -- 1-2 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 60 AND 180 THEN 'A3' -- 2-6 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 180 AND 360 THEN 'A4' -- 6-12 months
			ELSE 'A5' -- over 1 year
		END) AS AGING FROM TFSOLP120180 WHERE @CalDate = t$date+1) A
		--WHERE AGING=@AGING
		WHERE T$OEMA=@oem
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
		FROM (SELECT *,
		(CASE
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate)<=30 THEN 'A1' --within 1 month
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 30 AND 60 THEN 'A2' -- 1-2 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 60 AND 180 THEN 'A3' -- 2-6 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 180 AND 360 THEN 'A4' -- 6-12 months
			ELSE 'A5' -- over 1 year
		END) AS AGING FROM TFSOLP120180 WHERE @CalDate = t$date+1) A
		WHERE AGING=@AGING
		AND T$OEMA=@oem
		AND T$ITEM=@proj
		AND T$PLNT=@plant
		ORDER BY T$ORNO,T$PONO
	END
END




GO

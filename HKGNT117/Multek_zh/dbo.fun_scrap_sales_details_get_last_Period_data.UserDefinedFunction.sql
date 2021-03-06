USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_scrap_sales_details_get_last_Period_data]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fun_scrap_sales_details_get_last_Period_data]
(
@location	nvarchar(2),
@FYear		NVARCHAR(4),
@FPeriod	NVARCHAR(2),
@PLANT		NVARCHAR(2),
@PROJECT	NVARCHAR(32),
@Supplier	NVARCHAR(6)
)
RETURNS decimal(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result		DECIMAL(18,2),@lastFYear	NVARCHAR(4),@lastFPeriod	NVARCHAR(2)
	DECLARE	@ACTUAL		DECIMAL(18,2),@FIN_ADJUST	DECIMAL(18,2)

	-- Add the T-SQL statements to compute the return value here

	-- GET LAST FISCAL YEAR & FISCAL PERIOD

	SELECT 	TOP 1 @lastFYear = FiscalYear,@lastFPeriod = FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender 
	WHERE calenderDate = (
							SELECT MIN(CALENDERDATE)-1 FROM DataWarehouse.dbo.DW_DIM_Calender 
							WHERE FiscalYear = @FYear AND FiscalPeriod = @FPeriod
						  )
	
	SELECT @ACTUAL = SUM(B.T$AMND/1.17)
	FROM FACTORYLOADING.DBO.TFSSLS023180 AS A,FACTORYLOADING.DBO.TFSSLS024180 AS B
	WHERE A.T$ORNO = B.T$ORNO
	AND	B.T$ITEM = @Project	AND A.T$YEAR = @lastFYear AND A.T$PRNO = @lastFPeriod AND A.T$SUNO = @Supplier
	AND	A.T$STAT > 2 AND A.T$RMKA NOT LIKE '%FIN Adjustment%' AND A.T$LOCA = @location

	SELECT @FIN_ADJUST = SUM(B.T$AMND/1.17)
	FROM FACTORYLOADING.DBO.TFSSLS023180 AS A,FACTORYLOADING.DBO.TFSSLS024180 AS B
	WHERE A.T$ORNO = B.T$ORNO
	AND	B.T$ITEM = @Project	AND A.T$YEAR = @FYear AND A.T$PRNO = @FPeriod AND A.T$SUNO = @Supplier
	AND	A.T$STAT > 2 AND A.T$RMKA NOT LIKE '%FIN Adjustment%' AND A.T$LOCA = @location
	
	SET @Result = -ISNULL(@ACTUAL,0) + ISNULL(@FIN_ADJUST,0)
	
	-- Return the result of the function
	RETURN @Result
END

GO

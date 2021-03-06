USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_Trans_Data_Demo_For_Rivern]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Trans_Data_Demo_For_Rivern]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Finance_Year SMALLINT,@Finance_Period TINYINT,@Quantity BIGINT,
			@SQLString VARCHAR(MAX),@TempField VARCHAR(50)
	CREATE TABLE #Demo (Item VARCHAR(50),Delivery_Term VARCHAR(50),Quantity BIGINT)

	INSERT INTO #Demo
	SELECT Item,Delivery_Term,Quantity
	FROM Demo
	GROUP BY Item,Delivery_Term,Quantity

	DECLARE Demo_Year_Period_C CURSOR FOR
	SELECT Finance_Year,Finance_Period
	FROM Demo
	GROUP BY Finance_Year,Finance_Period
	ORDER BY Finance_Year,Finance_Period

	OPEN Demo_Year_Period_C
	FETCH NEXT FROM Demo_Year_Period_C INTO @Finance_Year,@Finance_Period

	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @TempField='FY_'+CONVERT(VARCHAR(4),@Finance_Year)+'_P_'+CONVERT(VARCHAR(2),@Finance_Period)+'_Price'
			SET @SQLString='ALTER TABLE #Demo ADD ' +@TempField +' NUMERIC(19,1) NULL'
			EXECUTE (@SQLString)
			SET @SQLString='UPDATE #Demo SET '+ @TempField+'=b.Price	FROM #Demo a,Demo b WHERE a.Item=b.Item	AND a.Delivery_Term=b.Delivery_Term	AND a.Quantity=b.Quantity AND b.Finance_Year='+CONVERT(VARCHAR(50),@Finance_Year)+' AND b.Finance_Period='+CONVERT(VARCHAR(50),@Finance_Period)
			EXECUTE (@SQLString)
			SET @TempField='FY_'+CONVERT(VARCHAR(4),@Finance_Year)+'_P_'+CONVERT(VARCHAR(2),@Finance_Period)+'_Quantity'
			SET @SQLString='ALTER TABLE #Demo ADD ' + 'FY_'+CONVERT(VARCHAR(4),@Finance_Year)+'_P_'+CONVERT(VARCHAR(2),@Finance_Period)+'_Quantity'+' BIGINT NULL'
			EXECUTE (@SQLString)
			SET @SQLString='UPDATE #Demo SET '+ @TempField+'=Quantity'
			EXECUTE (@SQLString)
			FETCH NEXT FROM Demo_Year_Period_C INTO @Finance_Year,@Finance_Period	
		END

	CLOSE Demo_Year_Period_C
	DEALLOCATE Demo_Year_Period_C

	ALTER TABLE #Demo DROP COLUMN Quantity
	SELECT * FROM #Demo
	

END
GO

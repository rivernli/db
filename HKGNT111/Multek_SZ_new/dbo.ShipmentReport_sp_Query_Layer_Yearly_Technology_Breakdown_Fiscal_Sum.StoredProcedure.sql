USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown_Fiscal_Sum]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown_Fiscal_Sum] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7),@Layer INT,@SQLString VARCHAR(8000)
	CREATE TABLE #Temp (Year CHAR(4))
	INSERT INTO #Temp VALUES(@Year)

	DECLARE Layer_C CURSOR FOR
	SELECT Lays AS Layer
	FROM ShipmentReport_Shipped_All
	WHERE Lays >0
	GROUP BY Lays
	ORDER BY Lays
	
	OPEN Layer_C 
	FETCH NEXT FROM Layer_C INTO @Layer
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@Layer)+'  BIGINT NULL'
			EXECUTE (@SQLString)
			IF @Year=CONVERT(CHAR(4),GETDATE(),120)
				BEGIN
					SET @SQLString='ALTER TABLE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal ADD column_'+CONVERT(VARCHAR(10),@Layer)+'  BIGINT NULL'
					EXECUTE (@SQLString)
				END
			SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@Layer)+'=(SELECT ISNULL(SUM(ISNULL(ShDols,0)),0) FROM ShipmentReport_Shipped_All WHERE ShDate>='''+CONVERT(VARCHAR(10),@DateFrom,120) +''' AND ShDate<='''+CONVERT(VARCHAR(10),@DateTo,120)+''' AND Lays='+CONVERT(VARCHAR(10),@Layer)+')'
			EXECUTE (@SQLString)
			FETCH NEXT FROM Layer_C INTO @Layer
		END
	CLOSE Layer_C
	DEALLOCATE Layer_C

	INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal
	SELECT * FROM #Temp

END
GO

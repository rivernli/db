USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7),@Layer VARCHAR(50),@SQLString VARCHAR(8000),@Amount NUMERIC(19,2)

	SELECT *
	INTO #Temp
	FROM ShipmentReport_Shipped_All_Fixed_Layer
	WHERE Year=@Year

	ALTER TABLE #Temp DROP COLUMN Year

	SELECT * FROM #Temp 

	CREATE TABLE #TempLayer (Layer VARCHAR(50),Amount BIGINT)

	DECLARE Lay_C CURSOR FOR
	SELECT Lay FROM ShipmentReport_Lay ORDER BY LEN(Lay),Lay

	OPEN Lay_C 
	FETCH NEXT FROM Lay_C INTO @Layer
	WHILE @@FETCH_STATUS=0
		BEGIN
			--INSERT INTO @TempLayer (Layer) VALUES(@Layer)
			SET @SQLString='INSERT INTO #TempLayer (Layer,Amount) SELECT '+''''+@Layer+''''+' AS Layer,'+'Column_' + @Layer+' AS Amount FROM #Temp'
			EXECUTE (@SQLString)
			--select @sqlstring
			FETCH NEXT FROM Lay_C INTO @Layer
		END
	CLOSE Lay_C
	DEALLOCATE Lay_C

	SELECT * FROM #TempLayer WHERE Amount<>0 ORDER BY CONVERT(INT,Layer) ASC

END
GO

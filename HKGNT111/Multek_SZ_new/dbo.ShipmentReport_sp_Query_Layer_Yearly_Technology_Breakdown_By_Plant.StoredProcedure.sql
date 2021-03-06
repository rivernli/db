USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown_By_Plant]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Layer_Yearly_Technology_Breakdown_By_Plant] 
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(3),
	@Plant VARCHAR(5),
	@Year CHAR(4),
	@AllYear VARCHAR(50)=NULL
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
	FROM ShipmentReport_Shipped_All_Fixed_Layer_By_Plant
	WHERE Year=@Year
		AND Site=@Site
		AND Plant=@Plant

	ALTER TABLE #Temp DROP COLUMN Year,Site,Plant

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

	CREATE TABLE #TempLayerAmount (Amount INT)

	SELECT Lay as name 
	INTO #TempLayer1
	FROM ShipmentReport_Lay
	ORDER BY LEN(Lay),Lay

	DECLARE Layer_C CURSOR FOR
	SELECT Name FROM #TempLayer1
	
	OPEN Layer_C
	FETCH NEXT FROM Layer_C INTO @Layer

	WHILE @@FETCH_STATUS=0
		BEGIN
			TRUNCATE TABLE #TempLayerAmount
			SET @SQLString='INSERT INTO #TempLayerAmount '
			SET @SQLString=@SQLString+'SELECT SUM(Column_'+CONVERT(VARCHAR(10),@Layer)+') AS Amount '
			SET @SQLString=@SQLString+'FROM ShipmentReport_Shipped_All_Fixed_Layer_By_Plant '
			SET @SQLString=@SQLString+'WHERE Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND CHARINDEX(Year,'+''''+@Year+''''+')>0'
			EXECUTE (@sqlsTRING)
			IF EXISTS(SELECT * FROM #TempLayerAmount WHERE Amount=0) 
				BEGIN
					DELETE #TempLayer1 WHERE name=@Layer
				END
			FETCH NEXT FROM Layer_C INTO @Layer
		END
	CLOSE Layer_C
	DEALLOCATE Layer_C
	
	SELECT * FROM #TempLayer WHERE Layer IN (SELECT Name FROM #TempLayer1) ORDER BY CONVERT(INT,Layer) ASC

END
GO

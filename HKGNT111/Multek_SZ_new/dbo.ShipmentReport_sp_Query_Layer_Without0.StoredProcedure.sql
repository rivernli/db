USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Layer_Without0]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Layer_Without0] 
	-- Add the parameters for the stored procedure here
	@CalendarFiscal VARCHAR(50),
	@Year VARCHAR(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	DECLARE @Layer INT,@SQLString VARCHAR(MAX)
	CREATE TABLE #TempLayerAmount (Amount INT)

	SELECT Lay as name 
	INTO #TempLayer
	FROM ShipmentReport_Lay
	ORDER BY LEN(Lay),Lay

	DECLARE Layer_C CURSOR FOR
	SELECT Name FROM #TempLayer
	
	OPEN Layer_C
	FETCH NEXT FROM Layer_C INTO @Layer

	WHILE @@FETCH_STATUS=0
		BEGIN
			TRUNCATE TABLE #TempLayerAmount
			SET @SQLString='INSERT INTO #TempLayerAmount '
			SET @SQLString=@SQLString+'SELECT SUM(Column_'+CONVERT(VARCHAR(10),@Layer)+') AS Amount '
			SET @SQLString=@SQLString+(CASE WHEN @CalendarFiscal='Fiscal' THEN 'FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal ' ELSE 'FROM ShipmentReport_Shipped_All_Fixed_Layer ' END)
			SET @SQLString=@SQLString+'WHERE CHARINDEX(Year,'+''''+@Year+''''+')>0'
			EXECUTE (@sqlsTRING)
			IF EXISTS(SELECT * FROM #TempLayerAmount WHERE Amount=0) 
				BEGIN
					DELETE #TempLayer WHERE name=@Layer
				END
			FETCH NEXT FROM Layer_C INTO @Layer
		END
	CLOSE Layer_C
	DEALLOCATE Layer_C
	
	SELECT * FROM #TempLayer
	
END
GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Initial_Layer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Initial_Layer]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	DECLARE @i INT,@j INT,@Lay INT, @SQLString VARCHAR(MAX)
	CREATE TABLE #Lays (AutoID INT IDENTITY(1,1),Lay INT) 

	--Process Lays
	--DECLARE Lays_C CURSOR FOR 
	INSERT INTO #Lays(Lay)
	SELECT a.Lays
	FROM  ShipmentReport_Shipped_All a
	WHERE a.Lays>0
	GROUP BY a.Lays
	ORDER BY a.Lays
	SET @j=(SELECT MAX(AutoID) FROM #Lays) --@@ROWCOUNT
	CREATE UNIQUE CLUSTERED INDEX AutoID ON #Lays (AutoID)
	SET @SQLString=''
	SET @i=1
	WHILE @i<=@j
		BEGIN
			SET @Lay=(SELECT Lay FROM #Lays WHERE AutoID=@i)
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Lay WHERE Lay=@Lay)
				BEGIN 
					INSERT INTO ShipmentReport_Lay(Lay)
						VALUES(@Lay)
				END
			IF NOT EXISTS(SELECT * FROM SysColumns WHERE ID=OBJECT_ID('ShipmentReport_Shipped_All_Fixed_Layer') AND Name='Column_'+CONVERT(VARCHAR(10),@Lay))
				BEGIN
					SET @SQLString='ALTER TABLE ShipmentReport_Shipped_All_Fixed_Layer ADD ' +'Column_'+CONVERT(VARCHAR(10),@Lay)+' NUMERIC(18,2) NULL'
					EXECUTE (@SQLString)
				END
			IF NOT EXISTS(SELECT * FROM SysColumns WHERE ID=OBJECT_ID('ShipmentReport_Shipped_All_Fixed_Layer_Fiscal') AND Name='Column_'+CONVERT(VARCHAR(10),@Lay))
				BEGIN
					SET @SQLString='ALTER TABLE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal ADD ' +'Column_'+CONVERT(VARCHAR(10),@Lay)+' NUMERIC(18,2) NULL'
					EXECUTE (@SQLString)
				END
			IF NOT EXISTS(SELECT * FROM SysColumns WHERE ID=OBJECT_ID('ShipmentReport_Shipped_All_Fixed_Layer_By_Plant') AND Name='Column_'+CONVERT(VARCHAR(10),@Lay))
				BEGIN
					SET @SQLString='ALTER TABLE ShipmentReport_Shipped_All_Fixed_Layer_By_Plant ADD ' +'Column_'+CONVERT(VARCHAR(10),@Lay)+' NUMERIC(18,2) NULL'
					EXECUTE (@SQLString)
				END
			IF NOT EXISTS(SELECT * FROM SysColumns WHERE ID=OBJECT_ID('ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant') AND Name='Column_'+CONVERT(VARCHAR(10),@Lay))
				BEGIN
					SET @SQLString='ALTER TABLE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant ADD ' +'Column_'+CONVERT(VARCHAR(10),@Lay)+' NUMERIC(18,2) NULL'
					EXECUTE (@SQLString)
				END
			SET @i=@i+1
		END
END
GO

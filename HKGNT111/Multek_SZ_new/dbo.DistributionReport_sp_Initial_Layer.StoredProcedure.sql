USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Initial_Layer]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Initial_Layer]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	DECLARE @i INT,@j INT,@Lay INT, @SQLString VARCHAR(MAX)
	CREATE TABLE #Lays (AutoID INT IDENTITY(1,1),Lay INT) 

	--Process Lays
	--DECLARE Lays_C CURSOR FOR 
	INSERT INTO #Lays(Lay)
	SELECT a.Lay
	FROM (
			SELECT CONVERT(INT,T$LAYS) AS Lay,T$LAYS AS Name
			FROM TFSOLP104180
			WHERE T$LAYS BETWEEN '01' AND '99'
			GROUP BY T$LAYS
			UNION
			SELECT CONVERT(INT,T$LAYS) AS Lay,T$LAYS AS Name
			FROM TFSOLP105180
			WHERE T$LAYS BETWEEN '01' AND '99'
			GROUP BY T$LAYS
			UNION
			SELECT CONVERT(INT,T$LAYS) AS Lay,T$LAYS AS Name
			FROM TFSOLP106180
			WHERE T$LAYS BETWEEN '01' AND '99'
			GROUP BY T$LAYS
			UNION
			SELECT CONVERT(INT,T$LAYS) AS Lay,T$LAYS AS Name
			FROM TFSOLP107180
			WHERE T$LAYS BETWEEN '01' AND '99'
			GROUP BY T$LAYS
		) a
	GROUP BY a.Lay
	ORDER BY a.Lay 
	SET @j=(SELECT MAX(AutoID) FROM #Lays) --@@ROWCOUNT
	CREATE UNIQUE CLUSTERED INDEX AutoID ON #Lays (AutoID)
	SET @SQLString=''
	SET @i=1
	WHILE @i<=@j
		BEGIN
			SET @Lay=(SELECT Lay FROM #Lays WHERE AutoID=@i)
			IF NOT EXISTS(SELECT * FROM DistributionReport_Lay WHERE Lay=@Lay)
				BEGIN 
					INSERT INTO DistributionReport_Lay(Lay)
						VALUES(@Lay)
				END
			IF NOT EXISTS(SELECT * FROM SysColumns WHERE ID=OBJECT_ID('DistributionReport_Layer_Amount_Calendar') AND Name='Column_'+CONVERT(VARCHAR(10),@Lay))
				BEGIN
					SET @SQLString='ALTER TABLE DistributionReport_Layer_Amount_Calendar ADD ' +'Column_'+CONVERT(VARCHAR(10),@Lay)+' BIGINT NULL'
					EXECUTE (@SQLString)
				END
			IF NOT EXISTS(SELECT * FROM SysColumns WHERE ID=OBJECT_ID('DistributionReport_Layer_Amount_Fiscal') AND Name='Column_'+CONVERT(VARCHAR(10),@Lay))
				BEGIN
					SET @SQLString='ALTER TABLE DistributionReport_Layer_Amount_Fiscal ADD ' +'Column_'+CONVERT(VARCHAR(10),@Lay)+' BIGINT NULL'
					EXECUTE (@SQLString)
				END
			SET @i=@i+1
		END
END
GO

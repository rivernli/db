USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_Lay_Calendar]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_Lay_Calendar]
	-- Add the parameters for the stored procedure here
	@CalculateYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Lays TABLE (AutoID INT IDENTITY(1,1),Lay INT)
	DECLARE @Year CHAR(4),@k INT,@i INT,@j INT,@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,
			@SQLString VARCHAR(MAX),@DateFrom DATETIME,@DateTo DATETIME
			-- Process Technology Breakdowns(layers)
			--SET @SQLString=''
			
	INSERT INTO @Lays(Lay)
	SELECT Lay FROM ShipmentReport_Lay ORDER BY CONVERT(INT,LAY)

	SET @Site=''
	SET @Plant=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=@Year+'-01-01' 
			SET @DateTo=CONVERT(VARCHAR(10),CONVERT(DATETIME,CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01') -1,120)
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer WHERE Year=@Year)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer(Year)
						VALUES(@Year)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
END
GO

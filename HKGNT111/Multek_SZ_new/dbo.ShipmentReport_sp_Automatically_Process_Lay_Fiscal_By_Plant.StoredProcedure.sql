USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_Lay_Fiscal_By_Plant]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_Lay_Fiscal_By_Plant]
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

	SET @Site='Chi'
	SET @Plant=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Chi'
	SET @Plant='B5'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Chi'
	SET @Plant='B4'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Chi'
	SET @Plant='B3'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Chi'
	SET @Plant='HK'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Chi'
	SET @Plant='P2'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Chi'
	SET @Plant='2F'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='Dis'
	SET @Plant=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='NFD'
	SET @Plant=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='SAO'
	SET @Plant=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END
	SET @Site='GER'
	SET @Plant=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			IF NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant WHERE Year=@Year AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant(Year ,Site,Plant)
						VALUES(@Year,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,@Lay,@DateFrom,@DateTo)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE ShipmentReport_Shipped_All_Fixed_Layer_Fiscal_By_Plant'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		

			SET @i=@i+1

		END

END
GO

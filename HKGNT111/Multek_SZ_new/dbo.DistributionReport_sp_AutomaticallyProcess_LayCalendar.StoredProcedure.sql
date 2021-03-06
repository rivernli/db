USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_LayCalendar]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_LayCalendar]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
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
	SELECT Lay FROM DistributionReport_Lay

	SET @Site='Chi'
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=@Year+'-01-01' 
			SET @DateTo=CONVERT(VARCHAR(10),CONVERT(DATETIME,CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01') -1,120)
			SET @Plant='P2'
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @Plant='2F'
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @Plant='B3'
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @Plant='B4'
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @Plant='B5'
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @Plant='HK'
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @Plant=''
			IF NOT EXISTS(SELECT * FROM DistributionReport_Layer_Amount_Calendar WHERE Year=@Year AND Type=@Type AND Site=@Site AND Plant=@Plant)
				BEGIN 
					INSERT INTO DistributionReport_Layer_Amount_Calendar(Year,Type,Site,Plant)
						VALUES(@Year,@Type,@Site,@Plant)
				END

			SET @j=(SELECT MAX(AutoID) FROM @Lays)
			SET @k=1
			WHILE @k<=@j
				BEGIN
					SET @Lay=(SELECT Lay FROM @Lays WHERE AutoID=@k)
					SET @Amount=dbo.DistributionReport_fun_Get_Amount('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,@Lay)
					SET @SQLString=''
					SET @SQLString=@SQLString+'			UPDATE DistributionReport_Layer_Amount_Calendar'
					SET @SQLString=@SQLString+'			SET Column_'+CONVERT(VARCHAR(10),@Lay)+'='+CONVERT(VARCHAR(50),@Amount)
					SET @SQLString=@SQLString+'			WHERE Year='+''''+@Year+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''
					EXECUTE (@SQLString)
					SET @k=@k+1
				END		
			SET @i=@i+1
		END
END
GO

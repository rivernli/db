USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Order_Status_by_Period_by_OrderType]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Order_Status_by_Period_by_OrderType]
	-- Add the parameters for the stored procedure here
	@Year INT,
	@CPeriod INT,
	@PeriodNo TINYINT,
	@CPlant VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @CYear SMALLINT,@PeriodFirstDay DATE,@PeriodLastDay DATE,@DateFrom DATE,@DateTo DATE,@i TINYINT,@Field VARCHAR(200),@Period TINYINT,@PeriodFrom TINYINT,@PeriodTo TINYINT,@SQLString VARCHAR(MAX),@Plant VARCHAR(50)
    DECLARE @TotalAmount NUMERIC(19,4),@Amount NUMERIC(19,4),@BufferAmount NUMERIC(19,4),@OtherAmount NUMERIC(19,4),@SumAmount NUMERIC(19,4)
    CREATE TABLE #Temp (Plant VARCHAR(50))
    
    SET @PeriodFirstDay=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
    SET @PeriodLastDay=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
    SET @PeriodLastDay=(CASE WHEN @PeriodLastDay>CONVERT(DATE,GETDATE()-1) THEN CONVERT(DATE,GETDATE()-1) ELSE @PeriodLastDay END)
    SET @Period=(SELECT MIN(FiscalPeriod) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
    
    SET @i=1
    SET @CYear=@Year
    SET @Field=dbo.fun_Get_Full_Period_Name(@Period)+'-'+CONVERT(VARCHAR(4),@CYear)
    WHILE @i<=@PeriodNo
		BEGIN
			SET @SQLString='ALTER TABLE #Temp ADD ['+@Field+'] NUMERIC(19,4) NULL'
			EXECUTE (@SQLString)
			SET @Period=@Period+1
			IF NOT EXISTS(SELECT * FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
				BEGIN
					SET @Period=1
					SET @CYear=@CYear+1
				END
		    SET @Field=dbo.fun_Get_Full_Period_Name(@Period)+'-'+CONVERT(VARCHAR(4),@CYear)
			SET @i=@i+1
		END
	ALTER TABLE #Temp ADD [After Period] NUMERIC(19,4) NULL
	ALTER TABLE #Temp ADD [Buffer Order] NUMERIC(19,4) NULL
	ALTER TABLE #Temp ADD Total NUMERIC(19,4) NULL

	SET @Plant='PO'
	SET @SumAmount=0
    SET @Period=(SELECT MIN(FiscalPeriod) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
	SET @SQLString='INSERT INTO #Temp VALUES('+''''+@Plant+''''
	SET @i=1
    SET @CYear=@Year
    SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
    WHILE @i<=@PeriodNo
		BEGIN		
			SET @Amount=(
							SELECT ISNULL(SUM(T$MAMT),0)
							FROM TFSOLP121180
							WHERE T$DESC ='Order Intake'
								AND T$PCDT  BETWEEN @DateFrom AND @DateTo
								AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
								AND T$COTP IN ('sls','slt','bfs')
								AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
						)
			SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@Amount)
			SET @SumAmount=@SumAmount+@Amount
			SET @Period=@Period+1
			IF NOT EXISTS(SELECT * FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
				BEGIN
					SET @Period=1
					SET @CYear=@CYear+1
				END
			SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
			SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
		    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
			SET @i=@i+1
		END
	SET @BufferAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						AND DATEPART(YEAR,T$PCDT)=2999
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$COTP IN ('sls','slt','bfs')
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @TotalAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						--AND T$PCDT  >=@PeriodFirstDay
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$COTP IN ('sls','slt','bfs')
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @OtherAmount=@TotalAmount-@SumAmount-@BufferAmount
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@OtherAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@BufferAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@TotalAmount)
	SET @SQLString=@SQLString+')'
	EXECUTE (@SQLString)
	SET @Plant='VMI'
	SET @SumAmount=0
    SET @Period=(SELECT MIN(FiscalPeriod) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
	SET @SQLString='INSERT INTO #Temp VALUES('+''''+@Plant+''''
	SET @i=1
    SET @CYear=@Year
    SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
    WHILE @i<=@PeriodNo
		BEGIN		
			SET @Amount=(
							SELECT ISNULL(SUM(T$MAMT),0)
							FROM TFSOLP121180
							WHERE T$DESC ='Order Intake'
								AND T$PCDT  BETWEEN @DateFrom AND @DateTo
								AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
								AND T$COTP IN ('cng','clt')
								AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
						)
			SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@Amount)
			SET @SumAmount=@SumAmount+@Amount
			SET @Period=@Period+1
			IF NOT EXISTS(SELECT * FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
				BEGIN
					SET @Period=1
					SET @CYear=@CYear+1
				END
			SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
			SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
		    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
			SET @i=@i+1
		END
	SET @BufferAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						AND DATEPART(YEAR,T$PCDT)=2999
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$COTP IN ('cng','clt')
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @TotalAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						--AND T$PCDT  >=@PeriodFirstDay
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$COTP IN ('cng','clt')
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @OtherAmount=@TotalAmount-@SumAmount-@BufferAmount
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@OtherAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@BufferAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@TotalAmount)
	SET @SQLString=@SQLString+')'
	EXECUTE (@SQLString)

	SET @Plant='Overall'
	SET @SumAmount=0
    SET @Period=(SELECT MIN(FiscalPeriod) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
	SET @SQLString='INSERT INTO #Temp VALUES('+''''+@Plant+''''
	SET @i=1
    SET @CYear=@Year
    SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
    WHILE @i<=@PeriodNo
		BEGIN		
			SET @Amount=(
							SELECT ISNULL(SUM(T$MAMT),0)
							FROM TFSOLP121180
							WHERE T$DESC ='Order Intake'
								AND T$PCDT  BETWEEN @DateFrom AND @DateTo
								AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
								AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
								--AND T$PLNT=(CASE WHEN @Plant='B1' THEN 'P2' WHEN @Plant='B2F' THEN '2F' WHEN @Plant='VVI' THEN 'HK' ELSE @Plant END)
						)
			SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@Amount)
			SET @SumAmount=@SumAmount+@Amount
			SET @Period=@Period+1
			IF NOT EXISTS(SELECT * FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
				BEGIN
					SET @Period=1
					SET @CYear=@CYear+1
				END
			SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
			SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
		    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
			SET @i=@i+1
		END
	SET @BufferAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						AND DATEPART(YEAR,T$PCDT)=2999
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @TotalAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						--AND T$PCDT  >=@PeriodFirstDay
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
						--AND T$PLNT=(CASE WHEN @Plant='B1' THEN 'P2' WHEN @Plant='B2F' THEN '2F' WHEN @Plant='VVI' THEN 'HK' ELSE @Plant END)
				)
	SET @OtherAmount=@TotalAmount-@SumAmount-@BufferAmount
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@OtherAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@BufferAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@TotalAmount)
	SET @SQLString=@SQLString+')'
	EXECUTE (@SQLString)

	SET @Plant='Overall(EX.B2F)'
	SET @SumAmount=0
    SET @Period=(SELECT MIN(FiscalPeriod) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@CPeriod)
	SET @SQLString='INSERT INTO #Temp VALUES('+''''+@Plant+''''
	SET @i=1
    SET @CYear=@Year
    SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
    WHILE @i<=@PeriodNo
		BEGIN		
			SET @Amount=(
							SELECT ISNULL(SUM(T$MAMT),0)
							FROM TFSOLP121180
							WHERE T$DESC ='Order Intake'
								AND T$PCDT  BETWEEN @DateFrom AND @DateTo
								AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
								AND T$PLNT<>'2F' 
								AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
						)
			SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@Amount)
			SET @SumAmount=@SumAmount+@Amount
			SET @Period=@Period+1
			IF NOT EXISTS(SELECT * FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
				BEGIN
					SET @Period=1
					SET @CYear=@CYear+1
				END
			SET @DateFrom=(SELECT MIN(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
			SET @DateTo=(SELECT MAX(CalenderDate)FROM Calendar WHERE FiscalYear=@CYear AND FiscalPeriod=@Period)
		    SET @DateFrom=(CASE WHEN @DateFrom<@PeriodFirstDay THEN @PeriodFirstDay ELSE @DateFrom END)
			SET @i=@i+1
		END
	SET @BufferAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						AND DATEPART(YEAR,T$PCDT)=2999
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$PLNT<>'2F' 
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @TotalAmount=(
					SELECT ISNULL(SUM(T$MAMT),0)
					FROM TFSOLP121180
					WHERE T$DESC ='Order Intake'
						--AND T$PCDT  >=@PeriodFirstDay
						AND T$TRDT  BETWEEN @PeriodFirstDay AND @PeriodLastDay
						AND T$PLNT<>'2F' 
						AND T$PLNT     =(CASE @CPlant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' ELSE T$PLNT END)   --LIKE @CPlant
				)
	SET @OtherAmount=@TotalAmount-@SumAmount-@BufferAmount
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@OtherAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@BufferAmount)
	SET @SQLString=@SQLString+','+CONVERT(VARCHAR(50),@TotalAmount)
	SET @SQLString=@SQLString+')'
	EXECUTE (@SQLString)

	IF @CPlant<>'Total'
		BEGIN
			DELETE  #Temp WHERE Plant='Overall(EX.B2F)'
		END
    select * from #Temp

    END
GO

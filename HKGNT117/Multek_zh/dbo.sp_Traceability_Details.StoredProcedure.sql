USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Traceability_Details]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[sp_Traceability_Details] 
	-- Add the parameters for the stored procedure here
	@Plant			NVARCHAR(5),
	@Project		NVARCHAR(30),
	@Work		NVARCHAR(5),
	@Stamp		NVARCHAR(5),
	@Lot		NVARCHAR(33),
	@Supplier		NVARCHAR(35),
	@Material		NVARCHAR(12),
	@Machine	NVARCHAR(30),
	@Packing NVARCHAR(30),
	@DateCode	NVARCHAR(30),
	@InpuFrom	NVARCHAR(30),
	@InputTo		NVARCHAR(30)
	
                                
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sqlString	NVARCHAR(MAX)

	SET @Plant		= ISNULL(@Plant,'')
	SET @Project	= ISNULL(@Project,'')
	SET @Work		= ISNULL(@Work,'')
	SET @Stamp		= ISNULL(@Stamp,'')
	SET	@Lot		= ISNULL(@Lot,'')
	SET @Supplier	= ISNULL(@Supplier,'')
	SET @Material	= ISNULL(@Material,'')
	SET @Machine	= ISNULL(@Machine,'')
	SET @Packing	= ISNULL(@Packing,'')
	SET @DateCode	= ISNULL(@DateCode,'')
	SET @InpuFrom	= ISNULL(@InpuFrom,'')
	SET @InputTo	= ISNULL(@InputTo,'')

	IF @InpuFrom = ''
		BEGIN
			SET @InputTo = CONVERT(VARCHAR(10),GETDATE(),120)
		END
		
	IF @InputTo = ''
		BEGIN
			SET @InputTo = CONVERT(VARCHAR(10),GETDATE(),120)
		END
	-----------------------------
	SET @sqlString ='
		SELECT
		top 30
		T$PLNT,
		T$LTNO,
		T$PROJ,
		T$MNWC,
		T$TQTY,
		T$MACH,
		T$MATR,
		T$DDEC,
		T$MBCD,
		T$SUNO,
		T$DCDE,
		T$STMP,
		T$DATE,
		T$TIME,
		T$OULN,
		T$SPLN,
		T$TRCD
	FROM Traceability_Details '
	
	-----------------------------

	SET @sqlString = @sqlString + ' WHERE CONVERT(VARCHAR(10),T$DATE,120) BETWEEN '+''''+@InpuFrom +''''+' AND '+''''+@InputTo+''''
	
	IF @Plant <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$PLNT = '+''''+@Plant+''''
		END
	
	IF @Project <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$PJNO = '+''''+@Project+''''
		END
		
	IF @Work <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$MNWC = '+''''+@Work+''''
		END
		
	IF @Stamp <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$STMP = '+''''+@Stamp+''''
		END

	IF @Lot <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$LTNO = '+''''+@Lot+''''
		END
		
	IF @Supplier <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$SUNO = '+''''+@Supplier+''''
		END		
		
	IF @Material <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$MATR = '+''''+@Material+''''
		END		

	IF @Machine <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$MACH = '+''''+@Machine+''''
		END					

	IF @Packing <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$PADE = '+''''+@Packing+''''
		END		
		
	IF @DateCode <> ''
		BEGIN
			SET @sqlString = @sqlString + ' AND T$DCDE = '+''''+@DateCode+''''
		END				
		
    -- Insert statements for procedure here
	--PRINT @sqlString
    EXEC (@sqlString)
END
GO

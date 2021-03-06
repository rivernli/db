USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Tracibility_Query_Details_bk]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Tracibility_Query_Details_bk]
	-- Add the parameters for the stored procedure here
	@Plant			NVARCHAR(5),
	@Project		NVARCHAR(30),
	@Work			NVARCHAR(5),
	@Stamp			NVARCHAR(5),
	@Lot			NVARCHAR(33),
	@Supplier		NVARCHAR(35),
	@Material		NVARCHAR(12),
	@MaterialBatCod	NVARCHAR(12),
	@Machine		NVARCHAR(30),
	@Packing		NVARCHAR(30),
	@DateCode		NVARCHAR(30),
	@InputFrom		NVARCHAR(30),
	@InputTo		NVARCHAR(30)
	
                                
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sqlString	NVARCHAR(MAX)
	DECLARE	@sqlTable	NVARCHAR(50)

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
	SET @InputFrom	= ISNULL(@InputFrom,'')
	SET @InputTo	= ISNULL(@InputTo,'')

	SET @sqlTable = ' FROM dbo.Traceability_Details'
	
	IF @InputFrom = ''
		BEGIN
			SET @InputTo = CONVERT(VARCHAR(10),GETDATE(),120)
			SET @sqlTable = ' FROM dbo.Tracibility_today'
		END
		
	IF @InputTo = ''
		BEGIN
			SET @InputTo = CONVERT(VARCHAR(10),GETDATE(),120)
		END
	-----------------------------
	SET @sqlString ='
		SELECT
		top 100
		T$PLNT,
		T$LTNO,
		T$CWOC,
		T$SEQU,
		T$MACH,
		T$MATR,
		t$DDEC,
		(T$suno +'+''''+'-'+'''' +' + t$DESC) AS t$SUNO,
		T$TOOL,
		T$REMK,
		CONVERT(VARCHAR(10),T$DATE,120) AS T$DATE,
		T$TIME,
		T$USER,
		T$MBCD,
		T$DCDE,
		T$PCDE,
		T$PROJ,
		T$PJNO,
		T$MNWC,
		T$BCDE,
		T$TQTY,
		T$TRCD,
		T$OULN,
		T$SPLN,
		T$STMP,
		T$MTYP,
		T$LCQT'+@sqlTable
	--FROM Traceability_Details '
	
	-----------------------------

	SET @sqlString = @sqlString + ' WHERE CONVERT(VARCHAR(10),T$DATE,120) BETWEEN '+''''+@InputFrom +''''+' AND '+''''+@InputTo+''''
	
	IF @Plant <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$PLNT = '+''''+@Plant+''''
		END
	
	IF @Project <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$PJNO = '+''''+@Project+''''
		END
		
	IF @Work <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$MNWC = '+''''+@Work+''''
		END
		
	IF @Stamp <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$STMP = '+''''+@Stamp+''''
		END

	IF @Lot <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$LTNO = '+''''+@Lot+''''
		END
		
	IF @Supplier <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$SUNO = '+''''+@Supplier+''''
		END		
		
	IF @Material <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$MATR = '+''''+@Material+''''
		END		

	IF @MaterialBatCod <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$MBCD = '+''''+@MaterialBatCod+''''
		END	

	IF @Machine <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$MACH = '+''''+@Machine+''''
		END					

	IF @Packing <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$PCDE = '+''''+@Packing+''''
		END		
		
	IF @DateCode <> ''
		BEGIN
			SET @sqlString = @sqlString + 'AND T$DCDE = '+''''+@DateCode+''''
		END				
		
	IF @sqlTable = ' FROM dbo.Tracibility_today'
		BEGIN
			SET @sqlString = @sqlString + ' ORDER BY T$DATE'
		END
    -- Insert statements for procedure here
	--PRINT @sqlString
    EXEC (@sqlString)

END

GO

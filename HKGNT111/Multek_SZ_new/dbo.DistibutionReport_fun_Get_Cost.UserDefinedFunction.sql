USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistibutionReport_fun_Get_Cost]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistibutionReport_fun_Get_Cost]
(
	@Item VARCHAR(50),
	@Plant VARCHAR(10),
	@Date DATETIME
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @ResultVar VARCHAR(MAX)
	DECLARE @Cost TABLE (
						UNITSET  NUMERIC(19,4),
						PnlINCHW  NUMERIC(19,4),
						PNLINCHL  NUMERIC(19,4),
						PNLSQFTA  NUMERIC(19,4),
						CESU  NUMERIC(19,4),
						CISU  NUMERIC(19,4),
						DLIU  NUMERIC(19,4),
						ILIU  NUMERIC(19,4),
						MDSU  NUMERIC(19,4),
						LDIU  NUMERIC(19,4),
						LDMU  NUMERIC(19,4),
						TCIU  NUMERIC(19,4),
						GSRU  NUMERIC(19,4),
						TCUU  NUMERIC(19,4))

	-- Add the T-SQL statements to compute the return value here
	INSERT INTO @Cost
	SELECT TOP 1 T$UNST,T$PNWN,T$PNLN,T$AREA,T$CESU,T$CISU,T$DLIU,T$ILIU,T$MDSU,T$LDIU,T$LDMU,T$TCIU,T$GSRU,T$TCUU
	FROM Cost_Sheet_Query_TFSBOM400180  
	WHERE t$pjno=@Item
		AND t$plnt=@Plant
		AND t$stat = 2
		AND T$LCDT<=@Date
	ORDER BY T$LCDT DESC,RIGHT(t$pjno,1) DESC
	IF NOT EXISTS(SELECT * FROM @Cost)
		BEGIN
			INSERT INTO @Cost
			SELECT TOP 1 T$UNST,T$PNWN,T$PNLN,T$AREA,T$CESU,T$CISU,T$DLIU,T$ILIU,T$MDSU,T$LDIU,T$LDMU,T$TCIU,T$GSRU,T$TCUU
			FROM Cost_Sheet_Query_TFSBOM400180 
			WHERE t$pjno=@Item
				AND t$plnt=@Plant
				AND t$stat = 2
				AND T$LCDT>@Date
			ORDER BY T$LCDT ASC,RIGHT(t$pjno,1) ASC
		END
	IF EXISTS(SELECT * FROM @Cost)
		BEGIN
			SET @ResultVar='UNITSET='+CONVERT(VARCHAR(50),(SELECT UNITSET FROM @Cost))
			SET @ResultVar=@ResultVar+',PnlINCHW='+CONVERT(VARCHAR(50),(SELECT PnlINCHW FROM @Cost))
			SET @ResultVar=@ResultVar+',PNLINCHL='+CONVERT(VARCHAR(50),(SELECT PNLINCHL FROM @Cost))
			SET @ResultVar=@ResultVar+',PNLSQFTA='+CONVERT(VARCHAR(50),(SELECT PNLSQFTA FROM @Cost))
			SET @ResultVar=@ResultVar+',CESU='+CONVERT(VARCHAR(50),(SELECT CESU FROM @Cost))
			SET @ResultVar=@ResultVar+',CISU='+CONVERT(VARCHAR(50),(SELECT CISU FROM @Cost))
			SET @ResultVar=@ResultVar+',DLIU='+CONVERT(VARCHAR(50),(SELECT DLIU FROM @Cost))
			SET @ResultVar=@ResultVar+',ILIU='+CONVERT(VARCHAR(50),(SELECT ILIU FROM @Cost))
			SET @ResultVar=@ResultVar+',MDSU='+CONVERT(VARCHAR(50),(SELECT MDSU FROM @Cost))
			SET @ResultVar=@ResultVar+',LDIU='+CONVERT(VARCHAR(50),(SELECT LDIU FROM @Cost))
			SET @ResultVar=@ResultVar+',LDMU='+CONVERT(VARCHAR(50),(SELECT LDMU FROM @Cost))
			SET @ResultVar=@ResultVar+',TCIU='+CONVERT(VARCHAR(50),(SELECT TCIU FROM @Cost))
			SET @ResultVar=@ResultVar+',GSRU='+CONVERT(VARCHAR(50),(SELECT GSRU FROM @Cost))
			SET @ResultVar=@ResultVar+',TCUU='+CONVERT(VARCHAR(50),(SELECT TCUU FROM @Cost))
			SET @ResultVar=@ResultVar+','
		END
	-- Return the result of the function
	RETURN @ResultVar

END
GO

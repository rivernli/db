USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Cost_Sheet_simple_Get_Suggested_Scrapt_Rate]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Cost_Sheet_simple_Get_Suggested_Scrapt_Rate] 
(
	-- Add the parameters for the function here
	@T$STPL FLOAT,
	@T$ATYP CHAR(40),
	@T$PLNT	CHAR(2),
	@T$PJNO CHAR(10), 
	@T$SERN FLOAT
)
RETURNS FLOAT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @T$STTP FLOAT
	DECLARE	@SQUT_SCRA	FLOAT,@PRES_SCRA FLOAT
	DECLARE @OSET FLOAT,@SSET FLOAT,@TSET FLOAT

	SET @T$STTP = 0
	SET @SQUT_SCRA = 0
	SET @PRES_SCRA = 0

	-- Add the T-SQL statements to compute the return value here
	IF EXISTS(SELECT * FROM dbo.TFSBOM467180 WHERE T$PLNT = @T$PLNT AND T$PDTY = @T$ATYP)
		BEGIN
			SELECT @OSET = T$OSET,@SSET = T$SSET,@TSET = T$TSET
			FROM dbo.TFSBOM467180 
			WHERE T$PLNT = @T$PLNT AND T$PDTY = @T$ATYP

			SELECT @PRES_SCRA = T$SCAP 
			FROM dbo.TFSBOM469180 
			WHERE T$SELE = 1 
			AND LEFT(T$FEAT,8) = 'pressing'
			AND	T$PLNT = @T$PLNT
			AND T$PROJ = @T$PJNO
			AND T$SERN = @T$SERN

			SELECT @SQUT_SCRA = SQRT(SUM( T$SCAP * T$SCAP ))
			FROM dbo.TFSBOM469180 
			WHERE T$SELE = 1 
			AND LEFT(T$FEAT,8) <> 'pressing'
			AND	T$PLNT = @T$PLNT
			AND T$PROJ = @T$PJNO
			AND T$SERN = @T$SERN
			
--			SELECT @SQUT_SCRA = SQRT(@SQUT_SCRA)
			SET @OSET = ISNULL(@OSET,0)
			SET @OSET = ISNULL(@TSET,0)
			SET @OSET = ISNULL(@SSET,0)
			SET @PRES_SCRA = ISNULL(@PRES_SCRA,0)
			SET @SQUT_SCRA = ISNULL(@SQUT_SCRA,0)

			SET @T$STTP = @TSET + @PRES_SCRA + @SQUT_SCRA
			IF @T$STPL = 1 
				SET  @T$STTP = @OSET + @PRES_SCRA + @SQUT_SCRA
			IF @T$STPL =  2 
				SET @T$STTP = @SSET + @PRES_SCRA + @SQUT_SCRA
		END
	-- Return the result of the function
	RETURN CAST(@T$STTP AS DECIMAL(18,2))

END

GO

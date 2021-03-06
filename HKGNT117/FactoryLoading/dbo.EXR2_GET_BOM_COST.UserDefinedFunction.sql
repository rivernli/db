USE [FactoryLoading]
GO
/****** Object:  UserDefinedFunction [dbo].[EXR2_GET_BOM_COST]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[EXR2_GET_BOM_COST]
(
	@Project			NVARCHAR(32),
	@Plant				NVARCHAR(10),
	@Period_End_date	DATETIME,
	@Cost_Type	NVARCHAR(20)
)
RETURNS DECIMAL(18,4)
AS
BEGIN
	-- Declare the return variable here
		DECLARE	@Return_Cost 					DECIMAL(18,4)
		DECLARE	@MAT_COST_EXCLUDE_Yield 		DECIMAL(18,4)
		DECLARE	@MAT_COST_INCLUDE_Yield			DECIMAL(18,4)
		DECLARE	@TOTAL_MAT_COST_INCLUDE_Yield	DECIMAL(18,4)
		DECLARE	@TOTAL_COST						DECIMAL(18,4)
		DECLARE	@Yield							DECIMAL(18,4)
		DECLARE	@Cost_Version					INT

	-- Add the T-SQL statements to compute the return value here
		SET	@Return_Cost = 0
		SET @MAT_COST_EXCLUDE_Yield = 0
		SET @MAT_COST_INCLUDE_Yield = 0
		SET @TOTAL_MAT_COST_INCLUDE_Yield = 0
		SET @TOTAL_COST = 0
		SET @Yield = 0
		SET @Cost_Version = 0

		SET @Project   = LTRIM(RTRIM(@Project))
		SET @Project   = ISNULL(@Project,'')
		SET	@Plant	   = LTRIM(RTRIM(@Plant))
		SET @Plant	   = ISNULL(@Plant,'')
		SET	@Cost_Type = LTRIM(RTRIM(@Cost_Type))
		SET @Cost_Type = ISNULL(@Cost_Type,'')
		---------------------------------------------------------------
		SELECT	TOP 1	@MAT_COST_EXCLUDE_Yield = BOM400.T$CESU ,
						@MAT_COST_INCLUDE_Yield = BOM400.T$CISU,
						@TOTAL_MAT_COST_INCLUDE_Yield = BOM400.T$TCIU,
						@TOTAL_COST	= BOM400.T$TCUU,
						@Yield = BOM400.T$BUSP,
						@Cost_Version = BOM400.T$SERN
		FROM	TFSBOM400180 AS BOM400
		WHERE	BOM400.T$PJNO LIKE ''''+@Project+'%'+''''
		AND		BOM400.T$PLNT = @Plant
		AND		BOM400.T$LCDT <=@Period_End_date
		AND		BOM400.T$STAT = 2
		ORDER BY BOM400.T$SERN DESC
		
--		IF @Return_Cost = 0
		IF @@RowCount = 0
			BEGIN
				SELECT	TOP 1	@MAT_COST_EXCLUDE_Yield = BOM400.T$CESU ,
						@MAT_COST_INCLUDE_Yield = BOM400.T$CISU,
						@TOTAL_MAT_COST_INCLUDE_Yield = BOM400.T$TCIU,
						@TOTAL_COST	= BOM400.T$TCUU,
						@Yield = BOM400.T$BUSP,
						@Cost_Version = BOM400.T$SERN
				FROM	TFSBOM400180 AS BOM400
				WHERE	BOM400.T$PJNO LIKE @Project+'%'
				AND		BOM400.T$PLNT = @Plant
				AND		BOM400.T$LCDT >=@Period_End_date
				AND		BOM400.T$STAT = 2
				ORDER BY BOM400.T$SERN ASC
			END
		---------------------------------------------------------------
	-- Return the result of the function
		IF @Cost_Type = 'T$CESU'
			BEGIN
				SET @Return_Cost = @MAT_COST_EXCLUDE_Yield
			END
		IF @Cost_Type = 'T$CISU'
			BEGIN
				SET @Return_Cost = @MAT_COST_INCLUDE_Yield
			END
		IF @Cost_Type = 'T$TCIU'
			BEGIN
				SET @Return_Cost = @TOTAL_MAT_COST_INCLUDE_Yield
			END
		IF @Cost_Type = 'T$TCUU'
			BEGIN
				SET @Return_Cost = @TOTAL_COST
			END
		IF @Cost_Type = 'T$BUSP'
			BEGIN
				SET @Return_Cost = @Yield
			END
		IF @Cost_Type = 'T$SERN'
			BEGIN
				SET @Return_Cost = @Cost_Version
			END

		RETURN @Return_Cost

END


GO

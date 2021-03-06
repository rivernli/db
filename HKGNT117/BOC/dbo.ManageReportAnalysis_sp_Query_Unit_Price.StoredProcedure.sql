USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_Unit_Price]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_Unit_Price]
	@FYear	NVARCHAR(50),
	@Plant  NVARCHAR(10),
	@Top	NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@sqlString	NVARCHAR(MAX)

	SET @FYear = ISNULL(@FYear,'')
	SET @FYear = LTRIM(RTRIM(@FYear))
	SET @Plant = ISNULL(@Plant,'')
	SET @Plant = LTRIM(RTRIM(@Plant))
	SET @Top   = ISNULL(@Top,'')
	SET @Top   = LTRIM(RTRIM(@Top))
	IF @Top <> '0' AND @Top <> ''
		SET @Top = CAST(2* CAST(@Top AS INT) AS NVARCHAR(10))

    -- Insert statements for procedure here
	IF @Top = '0'
		BEGIN
			IF @Plant <> 'ALL'
				BEGIN
					SELECT * FROM ManageReportAnalysis_Fixed_Unit_Selling_Price WHERE FYEAR = @FYear AND PLANT = @Plant order by SaleAmount desc ,plant,Fyear,operation desc
				END
			ELSE
				BEGIN
					SELECT * FROM ManageReportAnalysis_Fixed_Unit_Selling_Price WHERE FYEAR = @FYear order by SaleAmount desc ,plant,Fyear,operation desc
				END
		END
	ELSE
		BEGIN
			IF @Plant <> 'ALL'
				BEGIN
					SET @sqlString = 'SELECT TOP '+@Top+' * FROM ManageReportAnalysis_Fixed_Unit_Selling_Price WHERE FYEAR = '+''''+@FYear+''''+' AND PLANT = '+''''+@Plant+''''+' order by SaleAmount desc ,plant,Fyear,operation desc'
				END
			ELSE
				BEGIN
					SET @sqlString = 'SELECT TOP '+@Top+' * FROM ManageReportAnalysis_Fixed_Unit_Selling_Price WHERE FYEAR = '+''''+@FYear+''''+' order by SaleAmount desc ,plant,Fyear,operation desc'
				END				
			EXECUTE(@sqlString)
		END
END


GO

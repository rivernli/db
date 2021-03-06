USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_Material_Cost_Trend_By_Project]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_Material_Cost_Trend_By_Project]
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
					SELECT * FROM EXR2_Fixed_Material_Cost WHERE FYEAR = @FYear AND PLANT = @Plant order by SaleAmount desc ,plant,Fyear,operation ASC
				END
			ELSE
				BEGIN
					SELECT * FROM EXR2_Fixed_Material_Cost WHERE FYEAR = @FYear order by SaleAmount desc ,plant,Fyear,operation ASC
				END
		END
	ELSE
		BEGIN
			IF @Plant <> 'ALL'
				BEGIN
					SET @sqlString = 'SELECT TOP '+@Top+' * FROM EXR2_Fixed_Material_Cost WHERE FYEAR = '+''''+@FYear+''''+' AND PLANT = '+''''+@Plant+''''+' order by SaleAmount desc ,plant,Fyear,operation ASC'
				END
			ELSE
				BEGIN
					SET @sqlString = 'SELECT TOP '+@Top+' * FROM EXR2_Fixed_Material_Cost WHERE FYEAR = '+''''+@FYear+''''+' order by SaleAmount desc ,plant,Fyear,operation ASC'
				END				
			EXECUTE(@sqlString)
		END
END


GO

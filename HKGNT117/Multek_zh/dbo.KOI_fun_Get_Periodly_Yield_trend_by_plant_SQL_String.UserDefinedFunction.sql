USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Periodly_Yield_trend_by_plant_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
create FUNCTION [dbo].[KOI_fun_Get_Periodly_Yield_trend_by_plant_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(3),
	@Year VARCHAR(4),
	@Period SMALLINT ,
	@Plant NVARCHAR(50),	
	@Scrap_sqft NUMERIC(18,2),
	@FGin_sqft NUMERIC(18,2),
	@Yield_Percentage NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Periodly_Yield_trend_by_plant WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+' AND Plant='+''''+@Plant+''''+' ) '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Periodly_Yield_trend_by_plant(ReportCode,Year,Period,Plant,Scrap_sqft,FGin_sqft,Yield_Percentage)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Period)+','+''''+@Plant+''''+',0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Periodly_Yield_trend_by_plant'
	SET @ReturnString=@ReturnString+'			SET Scrap_sqft='+''''+CONVERT(VARCHAR(50),@Scrap_sqft)+''''+',FGin_sqft='+''''+CONVERT(VARCHAR(50),@FGin_sqft)+''''+',Yield_Percentage='+''''+CONVERT(VARCHAR(50),@Yield_Percentage)+''''+' '
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+'  AND Plant='+''''+@Plant+''' '

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END






GO

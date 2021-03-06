USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistrbutionReport_fun_Get_Daily_OEM_Cost_SQL_String]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistrbutionReport_fun_Get_Daily_OEM_Cost_SQL_String]
(
	-- Add the parameters for the function here
	@Type VARCHAR(10),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@OEM VARCHAR(200),
	@Date	DATETIME,
	@RevenueAmount BIGINT,
	@MaterialAmount BIGINT,
	@MaterialPercent NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	SET @RevenueAmount=ISNULL(@RevenueAmount,0)
	SET @MaterialAmount=ISNULL(@MaterialAmount,0)
	SET @MaterialPercent=ISNULL(@MaterialPercent,0)
	SET @OEM=REPLACE(@OEM,'''','')
	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM DistributionReport_Daily_OEM'+'_'+@Type+' WHERE Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND OEM='+''''+@OEM+''''+' AND Day='+''''+CONVERT(VARCHAR(10),@Date,120)+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO DistributionReport_Daily_OEM'+'_'+@Type+'(Site,Plant,OEM,Day,RevenueAmount,MaterialAmount,MaterialPercent)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@Site+''''+','+''''+@Plant+''''+','+''''+@OEM+''''+','+''''+CONVERT(VARCHAR(10),@Date,120)+''''+','+CONVERT(VARCHAR(20),@RevenueAmount)+','+CONVERT(VARCHAR(20),@MaterialAmount)+','+CONVERT(VARCHAR(20),@MaterialPercent)+')'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			ELSE'
	SET @ReturnString=@ReturnString+'				BEGIN'
	SET @ReturnString=@ReturnString+'					UPDATE DistributionReport_Daily_OEM'+'_'+@Type
	SET @ReturnString=@ReturnString+'					SET RevenueAmount='+CONVERT(VARCHAR(20),@RevenueAmount)+',MaterialAmount='+CONVERT(VARCHAR(20),@MaterialAmount)+',MaterialPercent='+CONVERT(VARCHAR(20),@MaterialPercent)
	SET @ReturnString=@ReturnString+'					WHERE Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND OEM='+''''+@OEM+''''+' AND Day='+''''+CONVERT(VARCHAR(10),@Date,120)+''''
	SET @ReturnString=@ReturnString+'				END'

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO

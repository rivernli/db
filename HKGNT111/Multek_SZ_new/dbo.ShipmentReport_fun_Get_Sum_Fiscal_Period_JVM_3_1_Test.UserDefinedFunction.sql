USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1_Test]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1_Test]
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@Period INT,
	@Site VARCHAR(50)
)
RETURNS NUMERIC(19,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Amount_Credit  NUMERIC(19,2),@Amount_Debit  NUMERIC(19,2)

	-- Add the T-SQL statements to compute the return value here
	IF @Site='Chi' 
		BEGIN
			SET @Year=@Year-1
			SET @Amount_Credit=(
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106183 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 183
														)
									   */
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106181 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106184 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106185 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106186 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106819 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106180 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)

			SET @Amount_Debit=  (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106183 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 183
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106181 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106184 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106185 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106186 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106819 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)+
							   (
									SELECT ISNULL(SUM(ISNULL(a.t$amth,0)),0)
									FROM TTFGLD106180 AS a
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr =1
										/*
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT Account  
															FROM  sale_Account 
															WHERE company = 180
														)
										*/
								)
		END

	RETURN (ROUND(ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0),0))

END
GO

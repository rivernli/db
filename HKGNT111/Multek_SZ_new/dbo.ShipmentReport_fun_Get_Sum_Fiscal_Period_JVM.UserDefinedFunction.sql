USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM]
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@Period INT,
	@Site VARCHAR(50),
	@Plant VARCHAR(50)
)
RETURNS NUMERIC(19,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Amount_Credit  NUMERIC(19,2),@Amount_Debit  NUMERIC(19,2)

	-- Add the T-SQL statements to compute the return value here
	IF @Site='Chi' AND @Plant='HK'
		BEGIN
			SET @Amount_Credit=(
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106183 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 183
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$pino=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)

								)
			SET @Amount_Debit=  (
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106183 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 183
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$pino=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
		END
	IF @Site='Chi' AND @Plant='B1'
		BEGIN

			SET @Amount_Credit=(
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106181 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)

			SET @Amount_Debit=  (
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106181 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
			
		END
	IF @Site='Chi' AND @Plant='B3'
		BEGIN
			SET @Amount_Credit=(
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106184 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
			SET @Amount_Debit=  (
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106184 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
		END
	IF @Site='Chi' AND @Plant='B4'
		BEGIN
			SET @Amount_Credit=(
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106185 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
			SET @Amount_Debit=  (
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106185 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
		END
	IF @Site='Chi' AND @Plant='B5'
		BEGIN
			SET @Amount_Credit=(
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106186 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
			SET @Amount_Debit=  (
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106186 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
		END
	IF @Site='Chi' AND @Plant='B2F'
		BEGIN
			SET @Amount_Credit=(
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106819 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 2
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
			SET @Amount_Debit=  (
									SELECT SUM(ISNULL(a.t$amth,0))  
									FROM multekchi_realtime.dbo.TTFGLD106819 AS a  
									WHERE a.t$fyer = @Year
										and t$fprd =@Period
										and a.t$dbcr = 1
										and a.t$leac BETWEEN '300000' AND '400000'
										and a.t$leac in (
															SELECT CONVERT(VARCHAR(50),account) 
															FROM  FactoryLoading.dbo.sale_Account 
															WHERE company = 180
														)
										and NOT EXISTS(select x.* from multekchi_realtime.dbo.TTDSLS045180 x WHERE x.t$ttyp=a.t$otyp AND x.t$invn=a.t$odoc)
										--and CONVERT(VARCHAR(50),a.t$otyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,a.t$odoc)) not IN(select CONVERT(VARCHAR(50),t$ttyp)+CONVERT(VARCHAR(50),CONVERT(BIGINT,t$invn)) from multekchi_realtime.dbo.TTDSLS045180)
								)
		END
	-- Return the result of the function
	RETURN (ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0))

END
GO

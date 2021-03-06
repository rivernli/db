USE [ContractTracker]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Get_Customer]    Script Date: 11/06/2014 15:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Get_Customer]
(
	-- Add the parameters for the function here
)
RETURNS @Customer TABLE 
(
	[Billing Cust Name] VARCHAR(500),
	[Billing Address] VARCHAR(500),
	MEP VARCHAR(500),
	[MEP DESC] VARCHAR(500),
	Site VARCHAR(500)
)
BEGIN
	-- Fill the table variable with the rows for your result set

	INSERT INTO @Customer
	SELECT     REPLACE([Billing Cust Name], '&', ' ') AS [Billing Cust Name], [Billing Address], MEP, [MEP DESC], Site
	FROM       [hkgnt117].ce3p1179.dbo.vpt_multek_customer AS vpt_multek_customer_1
	RETURN 
END
GO

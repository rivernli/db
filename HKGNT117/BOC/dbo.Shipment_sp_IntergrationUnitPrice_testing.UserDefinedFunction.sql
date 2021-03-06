USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Shipment_sp_IntergrationUnitPrice_testing]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Rivern Li>
-- Create date: <Create Date,2010/01/21>
-- Description:	<Description, ,>
-- =============================================
Create FUNCTION [dbo].[Shipment_sp_IntergrationUnitPrice_testing](@Plant nvarchar(15),@Fyear nvarchar(10),@Period nvarchar(5),@project nvarchar(30))
RETURNS nvarchar(300)
AS
BEGIN

-- First Methord
--SELECT * FROM(SELECT DISTINCT project  FROM dbo.CostDetail) A
--OUTER APPLY(
--    SELECT 
--        [values]= STUFF(REPLACE(REPLACE(
--            (
--                SELECT unitprice FROM dbo.CostDetail N
--                WHERE project = A.project
--                FOR XML AUTO
--            ), '<N UnitPrice="', ','), '"/>', ''), 1, 1, '')
--)N

-- Second Methord 
declare @a  nvarchar(300)
select distinct @a = @a  + ','+cast(unitprice as nvarchar(15)) 
from dbo.CostDetail 
where project = 'E02E880A'
RETURN STUFF(@a, 1, 1, '')

END


GO

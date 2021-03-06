USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Initialize_Customer_Loc_Mapping]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Initialize_Customer_Loc_Mapping]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT RTRIM(a.Name) AS Name,
		(
			CASE WHEN EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All b WHERE b.[Customer Name]=a.Name AND b.Loc='Chi') THEN 'China,'
			ELSE ''
			END
		)+
		(
			CASE WHEN EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All b WHERE b.[Customer Name]=a.Name AND b.Loc='Dis') THEN 'Display'
			ELSE ''
			END
		)+
		(
			CASE WHEN EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All b WHERE b.[Customer Name]=a.Name AND b.Loc='NFD') THEN 'North Field,'
			ELSE ''
			END
		)+
		(
			CASE WHEN EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All b WHERE b.[Customer Name]=a.Name AND b.Loc='SAO') THEN 'Brazil,'
			ELSE ''
			END
		)+
		(
			CASE WHEN EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All b WHERE b.[Customer Name]=a.Name AND b.Loc='Ger') THEN 'Germany,'
			ELSE ''
			END
		) AS Loc
	INTO #Temp
	FROM (
			SELECT RTRIM([Customer Name]) AS Name
			FROM ShipmentReport_Shipped_All
			GROUP BY [Customer Name]
		) a

	UPDATE #Temp
	SET Loc=RIGHT(Loc,LEN(Loc)-1)
	WHERE LEFT(Loc,1)=','
	UPDATE #Temp
	SET Loc=LEFT(Loc,LEN(Loc)-1)
	WHERE RIGHT(Loc,1)=','

	TRUNCATE TABLE ShipmentReport_Customer_Loc_Mapping
	INSERT INTO ShipmentReport_Customer_Loc_Mapping
	SELECT Name+' - ['+Loc+']' FROM #Temp

END
GO

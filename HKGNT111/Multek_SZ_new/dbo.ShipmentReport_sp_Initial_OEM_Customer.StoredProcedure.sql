USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Initial_OEM_Customer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Initial_OEM_Customer]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO ShipmentReport_OEM_Customer (Baan_OEM,Baan_Customer,Baan_Loc,Std_OEM,Std_Customer)
	SELECT a.*
	FROM (		
			SELECT LTRIM(RTRIM(ISNULL([OEM Name],''))) AS OEM,LTRIM(RTRIM(ISNULL(InvCustName,''))) AS Customer,LTRIM(RTRIM(ISNULL(Loc,''))) AS Loc ,'' AS Standard_OEM,'' AS Standard_Customer 
			FROM ShipmentReport_Shipped_All 
			GROUP BY [OEM Name],InvCustName,Loc
		 ) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_OEM_Customer b WHERE b.Baan_OEM+b.Baan_Customer+b.Baan_Loc=a.OEM+a.Customer+a.Loc)

	UPDATE ShipmentReport_OEM_Customer
	SET Real_OEM=(CASE WHEN Std_OEM='' THEN Baan_OEM ELSE Std_OEM END),
		Real_Customer=(CASE WHEN Std_Customer='' THEN Baan_Customer ELSE Std_Customer END)

	DELETE ShipmentReport_OEM_Customer
	FROM ShipmentReport_OEM_Customer a,
		(
			SELECT Baan_OEM,Baan_Customer,Baan_LOC
			FROM ShipmentReport_OEM_Customer
			GROUP BY Baan_OEM,Baan_Customer,Baan_LOC
			HAVING COUNT(*)>1
		) b
	WHERE a.Baan_OEM=b.Baan_OEM 
		AND a.Baan_Customer=b.Baan_Customer
		AND a.Baan_LOC=b.Baan_LOC

END
GO

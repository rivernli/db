USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Auto_Update_China_ShDate]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Auto_Update_China_ShDate]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT b.*
	INTO #Temp 
	FROM
		(
			SELECT a.sonum,a.sopos,a.shipid,b.T$INVD AS InvoicedDate
			FROM dbo.ShipmentReport_Shipped_All AS a left join multekchi_realtime.dbo.TTDSLS045180 AS b
			ON a.SoNum =b.t$orno and a.SOPos = b.t$pono and a.shipID = b.T$SRNB
			WHERE loc = 'Chi'
			AND RTRIM(LTRIM(CustNum)) <> 'ATL'

			UNION ALL

			SELECT a.sonum,a.sopos,a.shipid,b.T$TRDT AS invoiceddate
			FROM dbo.ShipmentReport_Shipped_All AS a left join multekchi_realtime.dbo.TFHACR051183 AS b
			ON a.SoNum =b.T$SORN and a.SOPos = b.T$SPON and a.shipID = b.T$SRNB
			WHERE loc = 'Chi'
			AND RTRIM(LTRIM(CustNum)) = 'ATL'
		) b

	CREATE INDEX sonum_ind ON #temp (sonum)
	CREATE INDEX sopos_ind ON #temp (sopos)
	CREATE INDEX shipid_ind ON #temp (shipid)

	UPDATE ShipmentReport_Shipped_All
	SET shdate=b.InvoicedDate
	FROM ShipmentReport_Shipped_All a,#Temp b
	WHERE a.sonum=b.sonum
		AND a.sopos=b.sopos
		AND a.shipid=b.shipid
		AND a.Loc='Chi'

	UPDATE ShipmentReport_Shipped_All
	SET SHDols=ROUND(SHDols,0)

END
GO

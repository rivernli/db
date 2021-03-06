USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Shipment_Site_Forecast]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Shipment_Site_Forecast] 
	@UserID VARCHAR(50)
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM (
			SELECT 'Chi' AS Site,'China' AS Description,'00003000010000700003' AS Code
			UNION
			SELECT 'Dis' AS Site,'Display' AS Description,'000030000200003' AS Code
			UNION
			SELECT 'Ger' AS Site,'Germany' AS Description,'000030000300003' AS Code
			UNION
			SELECT 'Nfd' AS Site,'North Field' AS Description,'000030000400003' AS Code
			UNION
			SELECT 'Sao' AS Site,'Brazil' AS Description,'000030000500003' AS Code
			UNION
			SELECT 'ChiP2' AS Site,'China B1' AS Description,'00003000010000100003' AS Code
			UNION
			SELECT 'Chi2F' AS Site,'China B2F' AS Description,'00003000010000200003' AS Code
			UNION
			SELECT 'ChiB3' AS Site,'China B3' AS Description,'00003000010000300003' AS Code
			UNION
			SELECT 'ChiB4' AS Site,'China B4' AS Description,'00003000010000400003' AS Code
			UNION
			SELECT 'ChiB5' AS Site,'China B5' AS Description,'00003000010000500003' AS Code
			UNION
			SELECT 'ChiHK' AS Site,'China VVI' AS Description,'00003000010000600003' AS Code
		) a
	WHERE a.Code IN (
						SELECT MenuID
						FROM ShipmentReport_Authority 
						WHERE UserID=@UserID
							AND CanSee=1
					)
END
GO

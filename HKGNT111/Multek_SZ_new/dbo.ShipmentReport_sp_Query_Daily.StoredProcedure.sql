USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Daily]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Daily]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Day DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(
				SELECT *
				FROM ShipmentReport_Shipped_All_Daily
				WHERE Site=@Site
					AND Plant=@Plant
					AND Day=@Day
			)
		BEGIN
				SELECT *
				FROM ShipmentReport_Shipped_All_Daily
				WHERE Site=@Site
					AND Plant=@Plant
					AND Day=@Day
		END
	ELSE
		BEGIN
			SELECT @Site AS Site,@Plant AS Plant,@Day AS Day,0 AS Amount
		END
END
GO

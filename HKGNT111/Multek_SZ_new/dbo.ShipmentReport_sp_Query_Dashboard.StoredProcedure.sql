USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Dashboard]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Dashboard]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @FirstPage VARCHAR(300)
	IF EXISTS(
				SELECT CanSee
				FROM ShipmentReport_Authority
				WHERE UserID=@UserID
					AND MenuID='0000200001'
					AND CanSee=1
			)
		BEGIN
			SET @FirstPage='Report/Global Monthly Shipment Trend Maps.aspx'
		END
	ELSE
		BEGIN
			IF EXISTS(
						SELECT CanSee
						FROM ShipmentReport_Authority
						WHERE UserID=@UserID
							AND MenuID='0000200002'
							AND CanSee=1
					)
				BEGIN
					SET @FirstPage='Report/China Monthly Shipment Trend Maps.aspx'
				END
			ELSE
				BEGIN
					IF EXISTS(
								SELECT CanSee
								FROM ShipmentReport_Authority
								WHERE UserID=@UserID
									AND MenuID='0000200003'
									AND CanSee=1
							)
						BEGIN
							SET @FirstPage='Report/Germany Monthly Shipment Trend Maps.aspx'
						END
					ELSE
						BEGIN
							SET @FirstPage='User/View.aspx'
						END
				END
		END

	SELECT @FirstPage

END
GO

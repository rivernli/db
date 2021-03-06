USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_User_Dashboard_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_User_Dashboard_Authority]
	-- Add the parameters for the stored procedure here
	@UserID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @ReturnTable TABLE (Type VARCHAR(50))
	--Output
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID='00002' AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable VALUES('Output')
		END
	--Shipment
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID='00003' AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable VALUES('Shipment')
		END
	--Outbound
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID='00004' AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable VALUES('Outbound')
		END
	--HubIn
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID='00005' AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable VALUES('HubIn')
		END
	--RMA
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID='00006' AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable VALUES('RMA')
		END
	--Scap
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID='00007' AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable VALUES('Scrap')
		END
		
	SELECT * FROM @ReturnTable 
END
GO

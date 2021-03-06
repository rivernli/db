USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Monthly_Plant_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Monthly_Plant_Authority]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50),
	@Type VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @ReturnTable TABLE (Plant VARCHAR(50))
	DECLARE @Plant VARCHAR(50),@MenuID VARCHAR(50)
	--B1
	SET @Plant='B1'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000100003'
				   WHEN 'Shipment' THEN '000030000100003'
				   WHEN 'Outbound' THEN '000040000100003'
				   WHEN 'HubIn' THEN '000050000100003'
				   WHEN 'RMA' THEN '000060000100003'
				   WHEN 'SCRAP' THEN '0000700001'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END
	--B2F
	SET @Plant='B2F'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000200003'
				   WHEN 'Shipment' THEN '000030000200003'
				   WHEN 'Outbound' THEN '000040000200003'
				   WHEN 'HubIn' THEN '000050000200003'
				   WHEN 'RMA' THEN '000060000200003'
				   WHEN 'SCRAP' THEN '0000700002'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END
	--B3
	SET @Plant='B3'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000300003'
				   WHEN 'Shipment' THEN '000030000300003'
				   WHEN 'Outbound' THEN '000040000300003'
				   WHEN 'HubIn' THEN '000050000300003'
				   WHEN 'RMA' THEN '000060000300003'
				   WHEN 'SCRAP' THEN '0000700003'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END
	--B4
	SET @Plant='B4'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000400003'
				   WHEN 'Shipment' THEN '000030000400003'
				   WHEN 'Outbound' THEN '000040000400003'
				   WHEN 'HubIn' THEN '000050000400003'
				   WHEN 'RMA' THEN '000060000400003'
				   WHEN 'SCRAP' THEN '0000700004'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END
	--B5
	SET @Plant='B5'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000500003'
				   WHEN 'Shipment' THEN '000030000500003'
				   WHEN 'Outbound' THEN '000040000500003'
				   WHEN 'HubIn' THEN '000050000500003'
				   WHEN 'RMA' THEN '000060000500003'
				   WHEN 'SCRAP' THEN '0000700005'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END
	--VVI
	SET @Plant='VVI'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000600003'
				   WHEN 'Shipment' THEN '000030000600003'
				   WHEN 'Outbound' THEN '000040000600003'
				   WHEN 'HubIn' THEN '000050000600003'
				   WHEN 'RMA' THEN '000060000600003'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END
	--ZhuHai
	SET @Plant='ZhuHai'
	SET @MenuID=(
		CASE @Type WHEN 'Output' THEN '000020000700003'
				   WHEN 'Shipment' THEN '000030000700003'
				   WHEN 'Outbound' THEN '000040000700003'
				   WHEN 'HubIn' THEN '000050000700003'
				   WHEN 'RMA' THEN '000060000700003'
				   WHEN 'SCRAP' THEN '0000700007'
		ELSE '0'
		END
	)
	IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
		BEGIN
			INSERT INTO @ReturnTable(Plant) VALUES(@Plant)
		END

	SELECT * FROM @ReturnTable
END
GO

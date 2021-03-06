USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_PurchaseTrendInsertUpdate]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_PurchaseTrendInsertUpdate]
	@ID INT,
	--@ItemGroup nvarchar(10),
	@FYear  nvarchar(10),
	@Plant  nvarchar(10),
	@FPeriod  nvarchar(10),
	@Type   nvarchar(10),
	@AMNT_Base_On_avg0  float,
	@AMNT_Base_On_forecast0  float,

	@AMNT_Base_On_avg01  float,
	@AMNT_Base_On_forecast01  float,

	@AMNT_Base_On_avg  float,
	@AMNT_Base_On_forecast  float,

	@AMNT_Base_On_avg1  float,
	@AMNT_Base_On_forecast1  float,
	@AMNT_Base_On_avg2  float,
	@AMNT_Base_On_forecast2  float,
	@AMNT_Base_On_avg3  float,
	@AMNT_Base_On_forecast3  float,
	@AMNT_Base_On_avg4  float,
	@AMNT_Base_On_forecast4  float,
	@AMNT_Base_On_avg5  float,
	@AMNT_Base_On_forecast5  float,
	@Operatation nvarchar(10)
AS
BEGIN

	SET NOCOUNT ON;
--	SET @ItemGroup = ISNULL(@ItemGroup,'')
	SET @FYear = ISNULL(@FYear,'')
	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @AMNT_Base_On_avg = ISNULL(@AMNT_Base_On_avg,0)
	SET @AMNT_Base_On_avg = ISNULL(@AMNT_Base_On_forecast,0)

    -- Insert 
	IF @Operatation = 'Insert'
		BEGIN
		-- Insert Type = "Forecast"
			SET @Type = 'Forecast'
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Non-Inv Overseas - Mat',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg0,@AMNT_Base_On_forecast0)

			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Non-Inv Overseas - SP & Exp',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg01,@AMNT_Base_On_forecast01)

			-- Insert Field "spare part"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Spare Part(设备配件)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg,@AMNT_Base_On_forecast)

			-- Insert Field "Fixture supplies"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Fixture supplies(FIXTURE用品)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg1,@AMNT_Base_On_forecast1)

			-- Insert Field "Equipment maintenance (设备维修+机械用油+五金类)"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Equipment maintenance (设备维修+机械用油+五金类)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg2,@AMNT_Base_On_forecast2)

			-- Insert Field "Operating supplies"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Operating supplies(劳保类)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg3,@AMNT_Base_On_forecast3)

			-- Insert Field "Waste Water Treatment"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Waste Water Treatment',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg4,@AMNT_Base_On_forecast4)

			-- Insert Field "Others (其它)"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Others (其它)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg5,@AMNT_Base_On_forecast5)
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],ItemGroup as [Material Category],Type as [Forecast or Actual],AMNT_Base_On_avg as [Amount Base On Last Avg Price],AMNT_Base_On_Forecast as [Amount Base On Forecast Price] FROM dbo.TTDPUROTHERS

		-- Insert Type = "Actual"
			SET @Type = 'Actual'
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Non-Inv Overseas - Mat',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg0,@AMNT_Base_On_forecast0)

			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Non-Inv Overseas - SP & Exp',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg01,@AMNT_Base_On_forecast01)

			-- Insert Field "spare part"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Spare Part(设备配件)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg,@AMNT_Base_On_forecast)

			-- Insert Field "Fixture supplies"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Fixture supplies(FIXTURE用品)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg1,@AMNT_Base_On_forecast1)

			-- Insert Field "Equipment maintenance (设备维修+机械用油+五金类)"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Equipment maintenance (设备维修+机械用油+五金类)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg2,@AMNT_Base_On_forecast2)

			-- Insert Field "Operating supplies"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Operating supplies(劳保类)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg3,@AMNT_Base_On_forecast3)

			-- Insert Field "Waste Water Treatment"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Waste Water Treatment',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg4,@AMNT_Base_On_forecast4)

			-- Insert Field "Others (其它)"
			INSERT INTO dbo.TTDPUROTHERS(ItemGroup,Plant,FYear,FPeriod,Type,AMNT_Base_On_avg,AMNT_Base_On_Forecast)
			VALUES (N'Others (其它)',@Plant,@FYear,@FPeriod,@Type,@AMNT_Base_On_avg5,@AMNT_Base_On_forecast5)
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],ItemGroup as [Material Category],Type as [Forecast or Actual],AMNT_Base_On_avg as [Amount Base On Last Avg Price],AMNT_Base_On_Forecast as [Amount Base On Forecast Price] FROM dbo.TTDPUROTHERS

		END
	-- Update
--	IF @Operatation = 'Update'
--		BEGIN
--			
--		END		
	-- Delete
	IF @Operatation = 'Delete'
		BEGIN
			DELETE dbo.TTDPUROTHERS WHERE ID = @ID
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],ItemGroup as [Material Category],Type as [Forecast or Actual],AMNT_Base_On_avg as [Amount Base On Last Avg Price],AMNT_Base_On_Forecast as [Amount Base On Forecast Price] FROM dbo.TTDPUROTHERS
		END			
	-- Query
	IF @Operatation = 'Query'
		BEGIN
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],ItemGroup as [Material Category],Type as [Forecast or Actual],AMNT_Base_On_avg as [Amount Base On Last Avg Price],AMNT_Base_On_Forecast as [Amount Base On Forecast Price] FROM dbo.TTDPUROTHERS
			WHERE FYear LIKE N'%'+@FYear+'%'
			AND FPeriod LIKE N'%'+@FPeriod+'%'
			AND Type LIKE N'%'+@Type+'%'
			AND	Plant LIKE N'%'+@Plant+'%'
		END	
	-- Bind		
	IF @Operatation = 'Bind'
		BEGIN
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],ItemGroup as [Material Category],Type as [Forecast or Actual],AMNT_Base_On_avg as [Amount Base On Last Avg Price],AMNT_Base_On_Forecast as [Amount Base On Forecast Price] FROM dbo.TTDPUROTHERS
		END	
END







GO

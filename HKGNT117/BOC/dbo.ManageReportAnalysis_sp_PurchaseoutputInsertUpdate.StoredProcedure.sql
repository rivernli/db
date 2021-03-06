USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_PurchaseoutputInsertUpdate]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_PurchaseoutputInsertUpdate]
	@ID INT,
	@Plant nvarchar(10),
	@FYear  nvarchar(10),
	@FPeriod  nvarchar(10),
	@AMNT_Base_On_avg  float,
	@AMNT_Base_On_forecast  float,
	@Operatation nvarchar(10)
AS
BEGIN

	SET NOCOUNT ON;
--	SET @ItemGroup = ISNULL(@ItemGroup,'')
	SET @FYear = ISNULL(@FYear,'')
	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @AMNT_Base_On_avg = ISNULL(@AMNT_Base_On_avg,0)
	SET @AMNT_Base_On_forecast = ISNULL(@AMNT_Base_On_forecast,0)

    -- Insert 
	IF @Operatation = 'Insert'
		BEGIN
			-- Insert Field "spare part"
			INSERT INTO dbo.TTDPUR_PRODUCTION_OUTPUT(Plant,FYear,FPeriod,Amnt_Actual,Amnt_Forecast)
			VALUES (@Plant,@FYear,@FPeriod,@AMNT_Base_On_avg,@AMNT_Base_On_forecast)

			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],Amnt_Actual as [Production Output Base on Actual],Amnt_Forecast as [Production Output Base on Forecast] FROM dbo.TTDPUR_PRODUCTION_OUTPUT
		END
	-- Delete
	IF @Operatation = 'Delete'
		BEGIN
			DELETE dbo.TTDPUR_PRODUCTION_OUTPUT WHERE ID = @ID
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],Amnt_Actual as [Production Output Base on Actual],Amnt_Forecast as [Production Output Base on Forecast] FROM dbo.TTDPUR_PRODUCTION_OUTPUT
		END			
	-- Query
	IF @Operatation = 'Query'
		BEGIN
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],Amnt_Actual as [Production Output Base on Actual],Amnt_Forecast as [Production Output Base on Forecast] FROM dbo.TTDPUR_PRODUCTION_OUTPUT
			WHERE FYear LIKE N'%'+@FYear+'%'
			AND FPeriod LIKE N'%'+@FPeriod+'%'
			AND Plant LIKE N'%'+@Plant+'%'
		END	
	-- Bind		
	IF @Operatation = 'Bind'
		BEGIN
			SELECT Plant,FYear as [Fiscal Year],FPeriod as [Fiscal Period],Amnt_Actual as [Production Output Base on Actual],Amnt_Forecast as [Production Output Base on Forecast] FROM dbo.TTDPUR_PRODUCTION_OUTPUT
		END	
END






GO

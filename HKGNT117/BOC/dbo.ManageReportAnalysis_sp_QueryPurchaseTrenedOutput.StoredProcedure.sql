USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrenedOutput]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrenedOutput] 
	@FYear int,
	@FPeriod int,
	@Type nvarchar(10)

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Return_value int
	SET @Return_value = 0

	IF @Type = 'Actual'
		SELECT @Return_value = Amnt_Actual FROM dbo.TTDPUR_PRODUCTION_OUTPUT WHERE FYear = @FYear AND FPeriod = @FPeriod 
	
	IF @Type = 'Forecast'
		SELECT @Return_value = Amnt_Forecast FROM dbo.TTDPUR_PRODUCTION_OUTPUT WHERE FYear = @FYear AND FPeriod = @FPeriod 
	
	SELECT @Return_value AS POutput
END

GO

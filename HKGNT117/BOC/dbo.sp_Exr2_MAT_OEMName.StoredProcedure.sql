USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MAT_OEMName]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MAT_OEMName]
	@Plant nvarchar(50)
	,@Timeline   nvarchar(10)
	,@StartFY int
	,@StartQuarter int
	,@StartPeriod int
	,@EndFY int
	,@EndQuarter int
	,@EndPeriod int
AS
BEGIN
	SET NOCOUNT ON;


	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE [#CostDetails]

	-- GET TABLE STRUCTURE
	SELECT 
		[OEMName]
		,[FiscalYear]
		,[FiscalQuarter]
		,[FiscalPeriod]
	INTO [#CostDetails]
	FROM [BOC_Test].[dbo].[Exr2_MCOS_ByOEM] WHERE 1 <> 1
	
	IF @Plant = 'ALL'
		BEGIN
			INSERT INTO [#CostDetails]
			SELECT 
				[OEMName]
				,[FiscalYear]
				,[FiscalQuarter]
				,[FiscalPeriod]
			FROM [BOC_Test].[dbo].[Exr2_MCOS_ByOEM]
			WHERE [ShipmentQty] IS NOT NULL
			GROUP BY [OEMName], [FiscalYear], [FiscalQuarter], [FiscalPeriod]
		END
		ELSE
		BEGIN
			INSERT INTO [#CostDetails]
			SELECT 
				[OEMName]
				,[FiscalYear]
				,[FiscalQuarter]
				,[FiscalPeriod]
			FROM [BOC_Test].[dbo].[Exr2_MCOS_ByOEM]
			WHERE [ShipmentQty] IS NOT NULL
				AND [Plant] = @plant
			GROUP BY [OEMName], [FiscalYear], [FiscalQuarter], [FiscalPeriod]
		END
	

	
	
	IF @Timeline = 'Year'
		BEGIN
			
			SELECT 
				[OEMName]AS [Item]
			FROM [#CostDetails]
			WHERE  (
						 @StartFY <= [FiscalYear]
					)
					AND(
						 @EndFY >= [FiscalYear]
					)
			GROUP BY [OEMName]
			
			
		END
	ELSE IF @Timeline = 'Quarter'
		BEGIN
			
			SELECT 
				[OEMName]AS [Item]
			FROM [#CostDetails]
			WHERE  (
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartQuarter <= [FiscalQuarter])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndQuarter >= [FiscalQuarter])
					)
			GROUP BY [OEMName]
			
					
		END
	ELSE IF @Timeline = 'Period'
		BEGIN
			
			SELECT 
				[OEMName]AS [Item]
			FROM [#CostDetails]
			WHERE  (
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
					)
			GROUP BY [OEMName]
			
					
		END

	


			
	----Delete Table
	DROP TABLE [#CostDetails]
END


GO

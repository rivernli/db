USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MCOS_Technology]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MCOS_Technology]
	@Plant nvarchar(50)
	,@Timeline   nvarchar(10)
	,@StartFY int
	,@StartQuarter int
	,@StartPeriod int
	,@EndFY int
	,@EndQuarter int
	,@EndPeriod int
	,@Domain  nvarchar(50)
    ,@UserId  nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE [#CostDetails]

	-- GET TABLE STRUCTURE
	SELECT 
		[Technology]
		,[FiscalYear]
		,[FiscalQuarter]
		,[FiscalPeriod]
	INTO [#CostDetails]
	FROM [BOC_Test].[dbo].[Exr2_MCOS_ByTechnology] WHERE 1 <> 1
	
	IF @Plant = 'ALL'
	BEGIN
		INSERT INTO [#CostDetails]
		SELECT 
			[Technology]
			,[FiscalYear]
			,[FiscalQuarter]
			,[FiscalPeriod]
		FROM [BOC_Test].[dbo].[Exr2_MCOS_ByTechnology]
		WHERE [ShipmentQty] IS NOT NULL
		GROUP BY [Technology], [FiscalYear], [FiscalQuarter], [FiscalPeriod]
	END
	ELSE
	BEGIN
		INSERT INTO [#CostDetails]
		SELECT 
			[Technology]
			,[FiscalYear]
			,[FiscalQuarter]
			,[FiscalPeriod]
		FROM [BOC_Test].[dbo].[Exr2_MCOS_ByTechnology]
		WHERE [ShipmentQty] IS NOT NULL
			AND [Plant] = @plant
		GROUP BY [Technology], [FiscalYear], [FiscalQuarter], [FiscalPeriod]
	END
	
	--找出用戶的ID.
	DECLARE @id INT
	SELECT TOP 1 @id=sysuserid  FROM [Multek_BI].[dbo].[GAM_USERS] WHERE [uid]=@UserId AND [domain]=@Domain
	--列出用戶對應可以看的OEM
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#OEMList') AND TYPE = 'U')
		DROP TABLE [#OEMList]
	SELECT [OEMName] INTO [#OEMList] FROM [Multek_BI].[dbo].[fx_getSalesForMKTRPT](@id) GROUP BY [OEMName] 
    DECLARE  @ListNumber int
    SELECT   @ListNumber=count(*) FROM  [#OEMList]
    IF @ListNumber>0 
    BEGIN
		   DELETE [#CostDetails] 
	END
	
	IF @Timeline = 'Year'
		BEGIN
			
			SELECT 
				[Technology]AS [Item]
			FROM [#CostDetails]
			WHERE  (
						 @StartFY <= [FiscalYear]
					)
					AND(
						 @EndFY >= [FiscalYear]
					)
			GROUP BY [Technology]
			
			
		END
	ELSE IF @Timeline = 'Quarter'
		BEGIN
			
			SELECT 
				[Technology]AS [Item]
			FROM [#CostDetails]
			WHERE  (
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartQuarter <= [FiscalQuarter])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndQuarter >= [FiscalQuarter])
					)
			GROUP BY [Technology]
			
					
		END
	ELSE IF @Timeline = 'Period'
		BEGIN
			
			SELECT 
				[Technology]AS [Item]
			FROM [#CostDetails]
			WHERE  (
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
					)
			GROUP BY [Technology]
			
					
		END

	


			
	----Delete Table
	DROP TABLE [#CostDetails]
END


GO

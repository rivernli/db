USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MCOS_OEMName]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MCOS_OEMName]
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
		[OEMName]
		,[FiscalYear]
		,[FiscalQuarter]
		,[FiscalPeriod]
	INTO [#CostDetails]
	FROM [BOC].[dbo].[Exr2_MCOS_ByOEM] WHERE 1 <> 1
	
	IF @Plant = 'ALL'
	BEGIN
		INSERT INTO [#CostDetails]
		SELECT 
			[OEMName]
			,[FiscalYear]
			,[FiscalQuarter]
			,[FiscalPeriod]
		FROM [BOC].[dbo].[Exr2_MCOS_ByOEM]
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
		FROM [BOC].[dbo].[Exr2_MCOS_ByOEM]
		WHERE [ShipmentQty] IS NOT NULL
			AND [Plant] = @plant
		GROUP BY [OEMName], [FiscalYear], [FiscalQuarter], [FiscalPeriod]
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
		   DELETE [#CostDetails] WHERE [OEMName] NOT IN(SELECT [OEMName] FROM [#OEMList]) 
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

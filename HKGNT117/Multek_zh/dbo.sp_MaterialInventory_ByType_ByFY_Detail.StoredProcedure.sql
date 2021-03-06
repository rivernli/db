USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_ByType_ByFY_Detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_MaterialInventory_ByType_ByFY_Detail] 
	@Plant nvarchar(10)
	,@Category nvarchar(10)
	,@Timeline nvarchar(10)
	,@Type nvarchar(50)
	,@TimeDesc nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#DetailT') AND TYPE = 'U')
		DROP TABLE [#DetailT]
	-- GET TABLE STRUCTURE
	SELECT 
		[Description]
		,[QuarterDesc]
		,[MonthDesc]
		,[DateDesc]
		,[FiscalQuarterDesc]
		,[FiscalPeriodDesc]
		,[FiscalDesc]
		,[Amount]
	INTO [#DetailT]
	FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
	WHERE 1 <> 1
	
	IF @Plant='ALL'
		BEGIN
			IF @Category='ALL'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Description]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Type]= @Type
				END
			ELSE IF @Category='BOM+EDM'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Description]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Type]= @Type AND [Category]='BOM' OR [Category]='EDM'
				END
			ELSE
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Description]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Type]= @Type AND [Category]=@Category
				END
		
		END
	ELSE
		BEGIN
			IF @Category='ALL'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Description]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Type]= @Type AND [Plant]= @Plant
				END
			ELSE IF @Category='BOM+EDM'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Description]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Type]= @Type AND [Plant]= @Plant AND ([Category]='BOM' OR [Category]='EDM')
				END
			ELSE
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Description]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Type]= @Type AND [Plant]= @Plant AND [Category]=@Category
				END
		END
		


	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GroupT') AND TYPE = 'U')
		DROP TABLE [#GroupT]

	-- GET TABLE STRUCTURE
	SELECT 
		[Description]
		,[Amount]
	INTO [#GroupT]
	FROM [#DetailT]
	WHERE 1 <> 1
	

	IF @Timeline = 'Quarter'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Description]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [#DetailT]
			WHERE  [FiscalQuarterDesc]= @TimeDesc
			GROUP BY [Description]
			
		END
	ELSE IF @Timeline = 'Period'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Description]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [#DetailT]
			WHERE  [FiscalPeriodDesc]= @TimeDesc
			GROUP BY [Description]
			
		END
	ELSE IF @Timeline = 'Date'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Description]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [#DetailT]
			WHERE [FiscalDesc] = @TimeDesc
			GROUP BY [Description]
			
		END
	
	SELECT [Description],[Amount] FROM [#GroupT]
	
	----Delete Table
	DROP TABLE [#DetailT]
	DROP TABLE [#GroupT]


END


GO

USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_OLAP_Insert_AllProject]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Loading_report_OLAP_Insert_AllProject]
@Plant			NVARCHAR(10)=null,
@Fiscal_Year	NVARCHAR(10)=null,
@Fiscal_Period	NVARCHAR(10)=null,
@Analysis_User	NVARCHAR(50)=null,
@LoadingF		NVARCHAR(10)
AS 

	DECLARE @Loading NVARCHAR(10)
	SET @LoadingF = ISNULL(@LoadingF,'0')
	SET @Loading  = CAST(@LoadingF as FLOAT)

	IF @Loading = 70 or @Loading = 100  or @Loading = 0
		BEGIN
			SET @Loading = 1
		END
	ELSE
		BEGIN
			SET @Loading = 70.0 / @Loading
		END
	
	DELETE FROM [tfsboc100180_analyse] 
	WHERE [Analysis_User] = @Analysis_User 
	AND [Fiscal_Year] = @Fiscal_Year 
	AND [Fiscal_Period] = @Fiscal_Period 
	AND [Plant] = @Plant

-- Insert New data --
INSERT INTO tfsboc100180_analyse
SELECT	@Analysis_User, 
		[Fiscal_Year], 
		[Fiscal_Period], 
		[Plant], 
		[Projects(8)], 
		[Projects(10)], 
		[Project(4)], 
		[Customer_Name], 
		[End_Customer], 
		[Product_Name], 
		[Part_number], 
		[Configuration], 
		[Material-Core], 
		[Material-RCC], 
		[Array Size(mm)], 
		[Unit_per_Panel], 
		[Panel Size(sqft)], 
		[Material_Utilization_per_Panel], 
		[Min_Line_Width & Spacing (mil)], 
		[Mechanical)_Through_Hole], 
		[Mechanical Blind_Buried Hole], 
		[Total Mechanical Hole Count], 
		[Laser Via - External Layer], 
		[Laser Via - Internal Layer], 
		[Total Laser Via Hole Count], 
		[Number of Plating], 
		[Number of Pressing], 
		[Number of Image Transfer], 
		[Surface Finish(EAU)], 
		[Surface Finish(ENTEK)], 
		[Surface Finish(HASL)], 
		[Surface Finish(GOLD PLATE)], 
		[Surface Finish(EAG)], 
		[Surface Finish(ETN)], 
		[X-out], 
		[Boc Item Type1], 
		[Boc Item Type2], 
		[Boc Item Type3], 
		[Boc Item Type4], 
		[Boc Item Type5], 
		[Boc Item Type6], 
		[Boc Item Type7], 
		[Boc Item Type8], 
		[Boc Item Type9], 
		[Boc Item Type10], 
		[Boc Item Type11], 
		[Boc Item Type12], 
		[Boc Item Type13], 
		[Boc Item Type14], 
		[Boc Item Type15], 
		[Boc Consumed1], 
		[Boc Consumed2], 
		[Boc Consumed3], 
		[Boc Consumed4], 
		[Boc Consumed5], 
		[Boc Consumed6], 
		[Boc Consumed7], 
		[Boc Consumed8], 
		[Boc Consumed9], 
		[Boc Consumed10], 
		[Boc Consumed11], 
		[Boc Consumed12], 
		[Boc Consumed13], 
		[Boc Consumed14], 
		[Boc Consumed15], 
		[Percent of Boc Consumed1], 
		[Percent of Boc Consumed2], 
		[Percent of Boc Consumed3], 
		[Percent of Boc Consumed4], 
		[Percent of Boc Consumed5], 
		[Percent of Boc Consumed6], 
		[Percent of Boc Consumed7], 
		[Percent of Boc Consumed8], 
		[Percent of Boc Consumed9], 
		[Percent of Boc Consumed10], 
		[Percent of Boc Consumed11], 
		[Percent of Boc Consumed12], 
		[Percent of Boc Consumed13], 
		[Percent of Boc Consumed14], 
		[Percent of Boc Consumed15], 
		[Cycle time1], [Cycle time2], 
		[Cycle time3], [Cycle time4], 
		[Cycle time5], [Cycle time6], 
		[Cycle time7], [Cycle time8], 
		[Cycle time9], [Cycle time10], 
		[Cycle time11], [Cycle time12], 
		[Cycle time13], [Cycle time14], 
		[Cycle time15], 
		[Selling Price Per Unit (US$)], 
		[ASP US$], 
		[Yield (Current)%], 
		[Material cost (Scrap included)], 
		[Material Cost _Sale(Current)], 
		[Total Cost per unit(US$)], 
		[%Margin], 
		[Profit per PCS], 
		[Production Volume Booking (Units)], 
		[Production Volume Booking (Square F], 
		[% of Production Volume (Square Foot], 
		[Total Sales (USD)], 
		[% of Total Sales], 
		[Batch No], 
		[Data Source], 
		[% of Margin (total)], 
		[Margin$ (total)], 
		[Dis-Selling Price Per Unit (US$)], 
		[Dis-Material Cost / Sale(Current)], 
		[%Dis-Margin], 
		[Dis-Total Sales (USD)], 
		[Dis-Margin$ (total)], 
		[Dis-Profit per PCS], 
		[Dis-ASP US$], 
		[Dis-of Total Sales], 
		[Dis-of Margin (total)], 
		[Direct.Labor]  * @Loading as [Direct.Labor], 
		[Indirect.Labor] * @Loading as [Indirect.Labor], 
		[Material.Cost], 
		[Process.Cost], 
		[Dos.Cost], 
		[Oh.Depreciation]  * @Loading as [Oh.Depreciation], 
		[Oh.Maintenance]   * @Loading as [Oh.Maintenance], 
		[Las.Depreciation] * @Loading as [Las.Depreciation], 
		[Las.Maintenance]  * @Loading as [Las.Maintenance], 
		[Oh.Eletricity], 
		[Oh.Fresh.Water], 
		[Oh.Waste.Water], 
		[Oh.Land], 
		[T$GSRS], 
		[T$TCUS], 
		[Column 136]
FROM dbo.tfsboc100180
WHERE [Fiscal_Year]		= @Fiscal_Year 
	AND [Fiscal_Period] = @Fiscal_Period 
	AND [Plant]			= @Plant

--UPDATE tfsboc100180_analyse set [T$TCUS] = 

GO

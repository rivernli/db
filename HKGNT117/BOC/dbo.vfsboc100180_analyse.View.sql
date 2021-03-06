USE [BOC]
GO
/****** Object:  View [dbo].[vfsboc100180_analyse]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vfsboc100180_analyse]
as
SELECT				Analysis_User,Plant,Fiscal_Year AS FYear, Fiscal_Period AS FPeriod,[Projects(8)] AS Project,[Projects(10)] AS Projects, [Project(4)] AS [Project No], Customer_Name AS [Customer Name], End_Customer AS [End Customer], 
                      Product_Name AS [Product Name], Part_number AS [Part Number], Configuration, [Material-Core] AS [material - Core], [Material-RCC] AS [Material - RCC], 
                      SUBSTRING([Projects(10)], 2, 2) AS [Layer Count], [Array Size(mm)] AS [Array Size], Unit_per_Panel AS [Unit Per Panel], ROUND([Panel Size(sqft)], 2) 
                      AS [Panel Size], CAST(ROUND(Material_Utilization_per_Panel, 2) AS nvarchar(20)) + '%' AS [Material Utilization per Panel], 
                      [Min_Line_Width & Spacing (mil)] AS [Min Line Width & Spacing (mil)], [Mechanical)_Through_Hole] AS [Mechanical Through Hole], 
                      [Mechanical Blind_Buried Hole] AS [Mechanical Blind Buried Hole], [Total Mechanical Hole Count], 
                      [Laser Via - External Layer] AS [Laser Via External Layer], [Laser Via - Internal Layer] AS [Laser Via Internal Layer], [Total Laser Via Hole Count], 
                      [Number of Plating], [Number of Pressing], [Number of Image Transfer], [Surface Finish(EAU)], [Surface Finish(ENTEK)], [Surface Finish(HASL)], 
                      [Surface Finish(GOLD PLATE)], [Surface Finish(EAG)], [Surface Finish(ETN)], [X-out], ROUND([Selling Price Per Unit (US$)], 2) 
                      AS [Selling_Price_Per_Unit], ROUND([ASP US$], 2) AS [ASP US$], CAST(ROUND([Yield (Current)%], 2) AS nvarchar(20)) + '%' AS [Yield (Current)%], 
                      ROUND([Material cost (Scrap included)], 3) AS [Material cost (Scrap included)], CAST(ROUND([Material Cost _Sale(Current)], 2) AS nvarchar(20)) 
                      AS [Material Cost/Sale(Current)], ROUND([Total Cost per unit(US$)], 2) AS [Total Cost per unit(US$)], CAST(ROUND([%Margin], 2) AS nvarchar(20)) 
                      + '%' AS [%Margin], ROUND([Profit per PCS], 2) AS [Profit per PCS], [Production Volume Booking (Units)] as [Production_Volume_Booking_Units], ROUND([Production Volume Booking (Square F],
                       0) AS [Production Volume Booking (Square Foot], CAST(ROUND([% of Production Volume (Square Foot], 1) AS nvarchar(20)) 
                      + '%' AS [% of Production Volume (Square Foot)], ROUND([Total Sales (USD)], 2) AS [Total Sales (USD)], CAST(ROUND([% of Total Sales], 1) 
                      AS nvarchar(20)) AS [% of Total Sales], [Boc Item Type1], [Boc Item Type2], [Boc Item Type3], [Boc Item Type4], [Boc Item Type5], [Boc Item Type6], 
                      [Boc Item Type7], [Boc Item Type8], [Boc Item Type9], [Boc Item Type10], [Boc Item Type11], [Boc Item Type12], [Boc Item Type13], [Boc Item Type14], 
                      [Boc Item Type15], CAST(ROUND([Boc Consumed1], 2) AS nvarchar(20)) AS [Boc Consumed1], CAST(ROUND([Boc Consumed2], 2) AS nvarchar(20)) 
                      AS [Boc Consumed2], CAST(ROUND([Boc Consumed3], 2) AS nvarchar(20)) AS [Boc Consumed3], CAST(ROUND([Boc Consumed4], 2) AS nvarchar(20)) 
                      AS [Boc Consumed4], CAST(ROUND([Boc Consumed5], 2) AS nvarchar(20)) AS [Boc Consumed5], CAST(ROUND([Boc Consumed6], 2) AS nvarchar(20)) 
                      AS [Boc Consumed6], CAST(ROUND([Boc Consumed7], 2) AS nvarchar(20)) AS [Boc Consumed7], CAST(ROUND([Boc Consumed8], 2) AS nvarchar(20)) 
                      AS [Boc Consumed8], CAST(ROUND([Boc Consumed9], 2) AS nvarchar(20)) AS [Boc Consumed9], CAST(ROUND([Boc Consumed10], 2) AS nvarchar(20)) 
                      AS [Boc Consumed10], CAST(ROUND([Boc Consumed11], 2) AS nvarchar(20)) AS [Boc Consumed11], CAST(ROUND([Boc Consumed12], 2) 
                      AS nvarchar(20)) AS [Boc Consumed12], CAST(ROUND([Boc Consumed13], 2) AS nvarchar(20)) AS [Boc Consumed13], CAST(ROUND([Boc Consumed14], 
                      2) AS nvarchar(20)) AS [Boc Consumed14], CAST(ROUND([Boc Consumed15], 2) AS nvarchar(20)) AS [Boc Consumed15], 
                      ROUND([Percent of Boc Consumed1], 2) AS [Percent of Boc Consumed1], ROUND([Percent of Boc Consumed2], 2) AS [Percent of Boc Consumed2], 
                      ROUND([Percent of Boc Consumed3], 2) AS [Percent of Boc Consumed3], ROUND([Percent of Boc Consumed4], 2) AS [Percent of Boc Consumed4], 
                      ROUND([Percent of Boc Consumed5], 2) AS [Percent of Boc Consumed5], ROUND([Percent of Boc Consumed6], 2) AS [Percent of Boc Consumed6], 
                      ROUND([Percent of Boc Consumed7], 2) AS [Percent of Boc Consumed7], ROUND([Percent of Boc Consumed8], 2) AS [Percent of Boc Consumed8], 
                      ROUND([Percent of Boc Consumed9], 2) AS [Percent of Boc Consumed9], ROUND([Percent of Boc Consumed10], 2) AS [Percent of Boc Consumed10], 
                      ROUND([Percent of Boc Consumed11], 2) AS [Percent of Boc Consumed11], ROUND([Percent of Boc Consumed12], 2) AS [Percent of Boc Consumed12], 
                      ROUND([Percent of Boc Consumed13], 2) AS [Percent of Boc Consumed13], ROUND([Percent of Boc Consumed14], 2) AS [Percent of Boc Consumed14], 
                      ROUND([Percent of Boc Consumed15], 2) AS [Percent of Boc Consumed15], CAST(ROUND([% of Margin (total)], 1) AS nvarchar(20)) 
                      + '%' AS [% of Margin (total)], ROUND([Margin$ (total)], 2) AS [Margin$ (total)], ROUND([Cycle time1], 2) AS [Cycle time1], ROUND([Cycle time2], 2) 
                      AS [Cycle time2], ROUND([Cycle time3], 2) AS [Cycle time3], ROUND([Cycle time4], 2) AS [Cycle time4], ROUND([Cycle time5], 2) AS [Cycle time5], 
                      ROUND([Cycle time6], 2) AS [Cycle time6], ROUND([Cycle time7], 2) AS [Cycle time7], ROUND([Cycle time8], 2) AS [Cycle time8], ROUND([Cycle time9], 
                      2) AS [Cycle time9], ROUND([Cycle time10], 2) AS [Cycle time10], ROUND([Cycle time11], 2) AS [Cycle time11], ROUND([Cycle time12], 2) 
                      AS [Cycle time12], ROUND([Cycle time13], 2) AS [Cycle time13], ROUND([Cycle time14], 2) AS [Cycle time14], ROUND([Cycle time15], 2) 
                      AS [Cycle time15],  
                      ROUND(T$TCUS, 2) AS T$TCUS, ROUND(T$GSRS, 2) AS T$GSRS, ROUND([Oh.Land], 2) AS [Oh.Land], 
                      ROUND([Oh.Waste.Water], 2) AS [Oh.Waste.Water], ROUND([Oh.Fresh.Water], 2) AS [Oh.Fresh.Water], ROUND([Oh.Eletricity], 2) AS [Oh.Eletricity], 
                      ROUND([Las.Maintenance], 2) AS [Las.Maintenance], ROUND([Las.Depreciation], 2) AS [Las.Depreciation], ROUND([Oh.Maintenance], 2) 
                      AS [Oh.Maintenance], ROUND([Oh.Depreciation], 2) AS [Oh.Depreciation], ROUND([Dos.Cost], 2) AS [Dos.Cost], ROUND([Process.Cost], 2) 
                      AS [Process.Cost], ROUND([Material.Cost], 2) AS [Material.Cost], ROUND([Indirect.Labor], 2) AS [Indirect.Labor], ROUND([Direct.Labor], 2) 
                      AS [Direct.Labor]
FROM         dbo.tfsboc100180_analyse
GO

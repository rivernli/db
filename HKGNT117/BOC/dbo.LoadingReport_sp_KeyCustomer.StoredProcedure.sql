USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[LoadingReport_sp_KeyCustomer]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LoadingReport_sp_KeyCustomer]
@Fiscal_Year nvarchar(10),
@Fiscal_Period nvarchar(10),
@Plant nvarchar(10),
@data_source nvarchar(10)
AS

BEGIN
	if @Plant = 'B1' or @Plant = 'b1'
		set @plant = 'P2'

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     Data_Source, Fiscal_Year, Fiscal_Period, Plant, OEM_Code, Customer, No_of_Project, Avg_Layer_Count, ASP$, ASP_Layer, Output_SQFT, 
						  Output_Percent, Output_Amount, Amount_Percent, Margin$, Total_Margin_percent, Margin_Percent, BOC_Item1, BOC_Item2, BOC_Item3, BOC_Item4, 
						  BOC_Item5, BOC_Item6, BOC_Item7, BOC_Item8, BOC_Item9, BOC_Item10, BOC_Item11, BOC_Item12, BOC_Item13, BOC_Item14, BOC_Item15, 
						  Consumption1, Consumption2, Consumption3, Consumption4, Consumption5, Consumption6, Consumption7, Consumption8, Consumption9, 
						  Consumption10, Consumption11, Consumption12, Consumption13, Consumption14, Consumption15, Consumpton_Percent1, Consumpton_Percent2, 
						  Consumpton_Percent3, Consumpton_Percent4, Consumpton_Percent5, Consumpton_Percent6, Consumpton_Percent7, Consumpton_Percent8, 
						  Consumpton_Percent9, Consumpton_Percent10, Consumpton_Percent11, Consumpton_Percent12, Consumpton_Percent13, Consumpton_Percent14, 
						  Consumpton_Percent15, Trans_Date, Trans_Time, Dis_ASP$, Dis_Output_Amount, Dis_Amount_Percent, Dis_Margin$, Dis_Total_Margin_Percent, 
						  Dis_Margin_Percent, Dis_ASP_Layer$, [Column 71]
	FROM         tfsboc103180
	WHERE     (Data_Source = @data_source) AND (Fiscal_Year = @Fiscal_Year) AND (Fiscal_Period = @Fiscal_Period) AND (Plant = @Plant) AND 
						  (Customer <> 'Total') AND (Customer <> 'Total per Week') AND (Customer <> 'Others')
	UNION ALL
	SELECT     Data_Source, Fiscal_Year, Fiscal_Period, Plant, OEM_Code, Customer, No_of_Project, Avg_Layer_Count, ASP$, ASP_Layer, Output_SQFT, 
						  Output_Percent, Output_Amount, Amount_Percent, Margin$, Total_Margin_percent, Margin_Percent, BOC_Item1, BOC_Item2, BOC_Item3, BOC_Item4, 
						  BOC_Item5, BOC_Item6, BOC_Item7, BOC_Item8, BOC_Item9, BOC_Item10, BOC_Item11, BOC_Item12, BOC_Item13, BOC_Item14, BOC_Item15, 
						  Consumption1, Consumption2, Consumption3, Consumption4, Consumption5, Consumption6, Consumption7, Consumption8, Consumption9, 
						  Consumption10, Consumption11, Consumption12, Consumption13, Consumption14, Consumption15, Consumpton_Percent1, Consumpton_Percent2, 
						  Consumpton_Percent3, Consumpton_Percent4, Consumpton_Percent5, Consumpton_Percent6, Consumpton_Percent7, Consumpton_Percent8, 
						  Consumpton_Percent9, Consumpton_Percent10, Consumpton_Percent11, Consumpton_Percent12, Consumpton_Percent13, Consumpton_Percent14, 
						  Consumpton_Percent15, Trans_Date, Trans_Time, Dis_ASP$, Dis_Output_Amount, Dis_Amount_Percent, Dis_Margin$, Dis_Total_Margin_Percent, 
						  Dis_Margin_Percent, Dis_ASP_Layer$, [Column 71]
	FROM         tfsboc103180 AS tfsboc103180_3
	WHERE     (Data_Source = @data_source) AND (Fiscal_Year = @Fiscal_Year) AND (Fiscal_Period = @Fiscal_Period) AND (Plant = @Plant) AND 
						  (Customer = 'Others')
	UNION ALL
	SELECT     Data_Source, Fiscal_Year, Fiscal_Period, Plant, OEM_Code, Customer, No_of_Project, Avg_Layer_Count, ASP$, ASP_Layer, Output_SQFT, 
						  Output_Percent, Output_Amount, Amount_Percent, Margin$, Total_Margin_percent, Margin_Percent, BOC_Item1, BOC_Item2, BOC_Item3, BOC_Item4, 
						  BOC_Item5, BOC_Item6, BOC_Item7, BOC_Item8, BOC_Item9, BOC_Item10, BOC_Item11, BOC_Item12, BOC_Item13, BOC_Item14, BOC_Item15, 
						  Consumption1, Consumption2, Consumption3, Consumption4, Consumption5, Consumption6, Consumption7, Consumption8, Consumption9, 
						  Consumption10, Consumption11, Consumption12, Consumption13, Consumption14, Consumption15, Consumpton_Percent1, Consumpton_Percent2, 
						  Consumpton_Percent3, Consumpton_Percent4, Consumpton_Percent5, Consumpton_Percent6, Consumpton_Percent7, Consumpton_Percent8, 
						  Consumpton_Percent9, Consumpton_Percent10, Consumpton_Percent11, Consumpton_Percent12, Consumpton_Percent13, Consumpton_Percent14, 
						  Consumpton_Percent15, Trans_Date, Trans_Time, Dis_ASP$, Dis_Output_Amount, Dis_Amount_Percent, Dis_Margin$, Dis_Total_Margin_Percent, 
						  Dis_Margin_Percent, Dis_ASP_Layer$, [Column 71]
	FROM         tfsboc103180 AS tfsboc103180_2
	WHERE     (Data_Source = @data_source) AND (Fiscal_Year = @Fiscal_Year) AND (Fiscal_Period = @Fiscal_Period) AND (Plant = @Plant) AND 
						  (Customer = 'Total')
	UNION ALL
	SELECT     Data_Source, Fiscal_Year, Fiscal_Period, Plant, OEM_Code, Customer, No_of_Project, Avg_Layer_Count, ASP$, ASP_Layer, Output_SQFT, 
						  Output_Percent, Output_Amount, Amount_Percent, Margin$, Total_Margin_percent, Margin_Percent, BOC_Item1, BOC_Item2, BOC_Item3, BOC_Item4, 
						  BOC_Item5, BOC_Item6, BOC_Item7, BOC_Item8, BOC_Item9, BOC_Item10, BOC_Item11, BOC_Item12, BOC_Item13, BOC_Item14, BOC_Item15, 
						  Consumption1, Consumption2, Consumption3, Consumption4, Consumption5, Consumption6, Consumption7, Consumption8, Consumption9, 
						  Consumption10, Consumption11, Consumption12, Consumption13, Consumption14, Consumption15, Consumpton_Percent1, Consumpton_Percent2, 
						  Consumpton_Percent3, Consumpton_Percent4, Consumpton_Percent5, Consumpton_Percent6, Consumpton_Percent7, Consumpton_Percent8, 
						  Consumpton_Percent9, Consumpton_Percent10, Consumpton_Percent11, Consumpton_Percent12, Consumpton_Percent13, Consumpton_Percent14, 
						  Consumpton_Percent15, Trans_Date, Trans_Time, Dis_ASP$, Dis_Output_Amount, Dis_Amount_Percent, Dis_Margin$, Dis_Total_Margin_Percent, 
						  Dis_Margin_Percent, Dis_ASP_Layer$, [Column 71]
	FROM         tfsboc103180 AS tfsboc103180_1
	WHERE     (Data_Source = @data_source) AND (Fiscal_Year = @Fiscal_Year) AND (Fiscal_Period = @Fiscal_Period) AND (Plant = @Plant) AND 
						  (Customer = 'Total per Week')
END

GO

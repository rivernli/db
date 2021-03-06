USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_Key_customer_analisy]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Loading_report_Key_customer_analisy]
@Fiscal_Year nvarchar(50),
@Fiscal_Period nvarchar(50),
@Plant nvarchar(50),
@data_source nvarchar(50),
@User nvarchar(50)
as 
begin
--set @Fiscal_Year = '2008'
--set @Fiscal_Period = '10'
--set @Plant = 'B5'
--set @data_source = 'WO Output'

declare @CurrFiscalYear  nvarchar(50)
declare	@urrFiscalPeriod nvarchar(50)

select @CurrFiscalYear=FiscalYear,@urrFiscalPeriod=FiscalPeriod  FROM ce3p1179.dbo.Calender b WHERE b.calenderDate = CONVERT(VARCHAR(10),getdate(),120)

if cast(isnull(@CurrFiscalYear,0) as int) >cast(isnull(@Fiscal_Year,0) as int)
	begin
		set @data_source = 'WO Output'
	end
if cast(isnull(@CurrFiscalYear,0) as int) = cast(isnull(@Fiscal_Year,0) as int) and cast(isnull(@urrFiscalPeriod,0) as int) > cast(isnull(@Fiscal_Period,0) as int)
	begin
		set @data_source = 'WO Output'
	end
if cast(isnull(@CurrFiscalYear,0) as int) = cast(isnull(@Fiscal_Year,0) as int) and cast(isnull(@urrFiscalPeriod,0) as int) <= cast(isnull(@Fiscal_Period,0) as int)
	begin
		set @data_source = 'WO Booking'
	end
if cast(isnull(@CurrFiscalYear,0) as int) < cast(isnull(@Fiscal_Year,0) as int)
	begin
		set @data_source = 'WO Booking'
	end


-- delete old data --
delete tfsboc103180_analyse where [User] = @User

-- insert query result to table .
--SET IDENTITY_INSERT tfsboc103180_analyse Off
--SET IDENTITY_INSERT tfsboc103180_analyse On
insert into tfsboc103180_analyse ([user], Cus_Serial, Serial, Fiscal_Year, Fiscal_Period, Plant, Customer, No_of_Project, Avg_Layer_Count, ASP$, ASP_Layer, Output_SQFT, Output_Percent, Output_Amount, Amount_Percent, Margin$, Total_Margin_percent, Margin_Percent, Consumpton_Percent1, Consumpton_Percent2, Consumpton_Percent3, Consumpton_Percent4, Consumpton_Percent5, Consumpton_Percent6, Consumpton_Percent7, Consumpton_Percent8, Consumpton_Percent9, Consumpton_Percent10, Consumpton_Percent11, Consumpton_Percent12, Consumpton_Percent13, Consumpton_Percent14, Consumpton_Percent15, BOC_Item1, BOC_Item2, BOC_Item3, BOC_Item4, BOC_Item5, BOC_Item6, BOC_Item7, BOC_Item8, BOC_Item9, BOC_Item10, BOC_Item11, BOC_Item12, BOC_Item13, BOC_Item14, BOC_Item15)
SELECT  @User, CASE dbo.tfsboc103180.Customer WHEN 'Others' THEN 2 WHEN 'Total' THEN 3 WHEN 'Total per Week' THEN 4 ELSE 1 END AS Cus_Serial,  tfsboc106180.Serial, tfsboc103180.Fiscal_Year, tfsboc103180.Fiscal_Period, tfsboc103180.Plant, tfsboc103180.Customer, 
                      tfsboc103180.No_of_Project, tfsboc103180.Avg_Layer_Count, tfsboc103180.ASP$, tfsboc103180.ASP_Layer, tfsboc103180.Output_SQFT, 
                      tfsboc103180.Output_Percent/100, tfsboc103180.Output_Amount, tfsboc103180.Amount_Percent/100, tfsboc103180.Margin$, 
                      tfsboc103180.Total_Margin_percent/100, tfsboc103180.Margin_Percent/100, 
                      tfsboc103180.Consumpton_Percent1/100, tfsboc103180.Consumpton_Percent2/100, tfsboc103180.Consumpton_Percent3/100, tfsboc103180.Consumpton_Percent4/100, 
                      tfsboc103180.Consumpton_Percent5/100, tfsboc103180.Consumpton_Percent6/100, tfsboc103180.Consumpton_Percent7/100, tfsboc103180.Consumpton_Percent8/100, 
                      tfsboc103180.Consumpton_Percent9/100, tfsboc103180.Consumpton_Percent10/100, tfsboc103180.Consumpton_Percent11/100, 
                      tfsboc103180.Consumpton_Percent12/100, tfsboc103180.Consumpton_Percent13/100, tfsboc103180.Consumpton_Percent14/100, 
                      tfsboc103180.Consumpton_Percent15/100, tfsboc103180.BOC_Item1, tfsboc103180.BOC_Item3, tfsboc103180.BOC_Item2, tfsboc103180.BOC_Item4, 
                      tfsboc103180.BOC_Item5, tfsboc103180.BOC_Item6, tfsboc103180.BOC_Item7, tfsboc103180.BOC_Item8, tfsboc103180.BOC_Item9, 
                      tfsboc103180.BOC_Item10, tfsboc103180.BOC_Item11, tfsboc103180.BOC_Item12, tfsboc103180.BOC_Item13, tfsboc103180.BOC_Item14, 
                      tfsboc103180.BOC_Item15
FROM         tfsboc103180 CROSS JOIN
                      tfsboc106180
WHERE     (tfsboc103180.Fiscal_Year = @Fiscal_Year) AND (tfsboc103180.Fiscal_Period = @Fiscal_Period) AND (tfsboc103180.Plant = @Plant) AND 
                      (tfsboc103180.OEM_Code = tfsboc106180.OEM_Code) AND (tfsboc103180.Plant = tfsboc106180.Plant) AND (tfsboc106180.Avalilable = 1) AND 
                      (tfsboc103180.Data_Source = @data_source) OR
                      (tfsboc103180.Fiscal_Year = @Fiscal_Year) AND (tfsboc103180.Fiscal_Period = @Fiscal_Period) AND (tfsboc103180.Plant = @Plant) AND 
                      (tfsboc103180.Data_Source = @data_source) AND (tfsboc103180.Customer = 'Others') AND (tfsboc103180.Customer = tfsboc106180.Key_Customer) OR
                      (tfsboc103180.Fiscal_Year = @Fiscal_Year) AND (tfsboc103180.Fiscal_Period = @Fiscal_Period) AND (tfsboc103180.Plant = @Plant) AND 
                      (tfsboc103180.Data_Source = @data_source) AND (tfsboc103180.Customer = 'Total') AND (tfsboc103180.Customer = tfsboc106180.Key_Customer) OR
                      (tfsboc103180.Fiscal_Year = @Fiscal_Year) AND (tfsboc103180.Fiscal_Period = @Fiscal_Period) AND (tfsboc103180.Plant = @Plant) AND 
                      (tfsboc103180.Data_Source = @data_source) AND (tfsboc103180.Customer = 'Total per Week') AND 
                      (tfsboc103180.Customer = tfsboc106180.Key_Customer)
GROUP BY tfsboc106180.Serial, tfsboc103180.Fiscal_Year, tfsboc103180.Fiscal_Period, tfsboc103180.Plant, tfsboc103180.Customer, 
                      tfsboc103180.No_of_Project, tfsboc103180.Avg_Layer_Count, tfsboc103180.ASP$, tfsboc103180.ASP_Layer, tfsboc103180.Output_SQFT, 
                      tfsboc103180.Output_Percent, tfsboc103180.Output_Amount, tfsboc103180.Amount_Percent, tfsboc103180.Margin$, 
                      tfsboc103180.Total_Margin_percent, tfsboc103180.Margin_Percent, tfsboc103180.Consumpton_Percent1, tfsboc103180.Consumpton_Percent2, 
                      tfsboc103180.Consumpton_Percent3, tfsboc103180.Consumpton_Percent4, tfsboc103180.Consumpton_Percent5, tfsboc103180.Consumpton_Percent6, 
                      tfsboc103180.Consumpton_Percent7, tfsboc103180.Consumpton_Percent8, tfsboc103180.Consumpton_Percent9, 
                      tfsboc103180.Consumpton_Percent10, tfsboc103180.Consumpton_Percent11, tfsboc103180.Consumpton_Percent12, 
                      tfsboc103180.Consumpton_Percent13, tfsboc103180.Consumpton_Percent14, tfsboc103180.Consumpton_Percent15, tfsboc103180.BOC_Item1, 
                      tfsboc103180.BOC_Item3, tfsboc103180.BOC_Item2, tfsboc103180.BOC_Item4, tfsboc103180.BOC_Item5, tfsboc103180.BOC_Item6, 
                      tfsboc103180.BOC_Item7, tfsboc103180.BOC_Item8, tfsboc103180.BOC_Item9, tfsboc103180.BOC_Item10, tfsboc103180.BOC_Item11, 
                      tfsboc103180.BOC_Item12, tfsboc103180.BOC_Item13, tfsboc103180.BOC_Item14, tfsboc103180.BOC_Item15
ORDER BY Cus_Serial, tfsboc106180.Serial, tfsboc103180.Customer
--SET IDENTITY_INSERT tfsboc103180_analyse off

-- update field User --
-- update tfsboc103180_analyse set [user] = @User where [user] = ''


end

GO

USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_product_type_Insert]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Loading_report_product_type_Insert]
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

print @CurrFiscalYear
print @Fiscal_Year
print @urrFiscalPeriod
print @Fiscal_Period
print @data_source
-- delete old data --
delete tfsboc104180_analyse where [User] = @User

-- insert query result to table .
--SET IDENTITY_INSERT tfsboc104180_analyse Off
--SET IDENTITY_INSERT tfsboc104180_analyse On
insert into tfsboc104180_analyse ([user], Cus_Serial, Serial, Fiscal_Year, Fiscal_Period, Plant, Product_Type, No_of_Project, Avg_Layer_Count, ASP$, ASP_Layer, Output_SQFT, Output_Percent, Output_Amount, Amount_Percent, Margin$, Total_Margin_percent, Margin_Percent, Consumpton_Percent1, Consumpton_Percent2, Consumpton_Percent3, Consumpton_Percent4, Consumpton_Percent5, Consumpton_Percent6, Consumpton_Percent7, Consumpton_Percent8, Consumpton_Percent9, Consumpton_Percent10, Consumpton_Percent11, Consumpton_Percent12, Consumpton_Percent13, Consumpton_Percent14, Consumpton_Percent15, BOC_Item1, BOC_Item2, BOC_Item3, BOC_Item4, BOC_Item5, BOC_Item6, BOC_Item7, BOC_Item8, BOC_Item9, BOC_Item10, BOC_Item11, BOC_Item12, BOC_Item13, BOC_Item14, BOC_Item15)
SELECT     @User, CASE dbo.tfsboc104180.Product_Type WHEN 'Others' THEN 2 WHEN 'Total' THEN 3 WHEN 'Total per Week' THEN 4 ELSE 1 END AS Cus_Serial, tfsboc107180.Serial,tfsboc104180.Fiscal_Year, tfsboc104180.Fiscal_Period, tfsboc104180.Plant, tfsboc104180.Product_Type, tfsboc104180.No_of_Project, 
                      tfsboc104180.Avg_Layer_Count, tfsboc104180.ASP$, tfsboc104180.ASP_Layer$, tfsboc104180.Output_Sqft, 
                      cast(tfsboc104180.Output_Percent/100 as decimal(38, 2)), tfsboc104180.Output_Amount, cast(tfsboc104180.Amount_Percent/100 as decimal(38, 2)), tfsboc104180.Margin$, 
                      cast(tfsboc104180.Total_Margin_Percent/100 as decimal(38, 2)), cast(tfsboc104180.Margin_Percent/100 as decimal(38, 2)), 
					  cast(tfsboc104180.Consumption_Percent1/100 as decimal(38, 2)),cast(tfsboc104180.Consumption_Percent2/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent3/100 as decimal(38, 2)),
                      cast(tfsboc104180.Consumption_Percent4/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent5/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent6/100 as decimal(38, 2)), 
                      cast(tfsboc104180.Consumption_Percent7/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent8/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent9/100 as decimal(38, 2)), 
                      cast(tfsboc104180.Consumption_Percent10/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent11/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent12/100 as decimal(38, 2)), 
                      cast(tfsboc104180.Consumption_Percent13/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent14/100 as decimal(38, 2)), cast(tfsboc104180.Consumption_Percent15/100 as decimal(38, 2)),                      
					  tfsboc104180.BOC_Item1, tfsboc104180.BOC_Item2, tfsboc104180.BOC_Item3, tfsboc104180.BOC_Item4, tfsboc104180.BOC_Item5, 
                      tfsboc104180.BOC_Item6, tfsboc104180.BOC_Item7, tfsboc104180.BOC_Item8, tfsboc104180.BOC_Item9, tfsboc104180.BOC_Item10, 
                      tfsboc104180.BOC_Item11, tfsboc104180.BOC_Item12, tfsboc104180.BOC_Item13, tfsboc104180.BOC_Item14, tfsboc104180.BOC_Item15
FROM         tfsboc104180 CROSS JOIN
                      tfsboc107180
WHERE     (tfsboc104180.Fiscal_Year = @Fiscal_Year) AND (tfsboc104180.Fiscal_Period = @Fiscal_Period) AND (tfsboc104180.Plant = @Plant) AND 
                      (tfsboc104180.Data_Source = @data_source) AND (tfsboc104180.Plant = tfsboc107180.Plant) AND 
                      (tfsboc107180.Product_Type = tfsboc104180.Product_Type) AND (tfsboc107180.Available = 1) OR
                      (tfsboc104180.Fiscal_Year = @Fiscal_Year) AND (tfsboc104180.Fiscal_Period = @Fiscal_Period) AND (tfsboc104180.Plant = @Plant) AND 
                      (tfsboc104180.Data_Source = @data_source) AND (tfsboc104180.Product_Type = 'Others') AND 
                      (tfsboc104180.Product_Type = tfsboc107180.Product_Type) OR
                      (tfsboc104180.Fiscal_Year = @Fiscal_Year) AND (tfsboc104180.Fiscal_Period = @Fiscal_Period) AND (tfsboc104180.Plant = @Plant) AND 
                      (tfsboc104180.Data_Source = @data_source) AND (tfsboc104180.Product_Type = 'Total') AND 
                      (tfsboc104180.Product_Type = tfsboc107180.Product_Type) OR
                      (tfsboc104180.Fiscal_Year = @Fiscal_Year) AND (tfsboc104180.Fiscal_Period = @Fiscal_Period) AND (tfsboc104180.Plant = @Plant) AND 
                      (tfsboc104180.Data_Source = @data_source) AND (tfsboc104180.Product_Type = 'Total per Week') AND 
                      (tfsboc104180.Product_Type = tfsboc107180.Product_Type)
group by tfsboc107180.Serial,tfsboc104180.Fiscal_Year, tfsboc104180.Fiscal_Period, tfsboc104180.Plant, tfsboc104180.Product_Type, tfsboc104180.No_of_Project, 
                      tfsboc104180.Avg_Layer_Count, tfsboc104180.ASP$, tfsboc104180.ASP_Layer$, tfsboc104180.Output_Sqft, 
                      tfsboc104180.Output_Percent, tfsboc104180.Output_Amount, tfsboc104180.Amount_Percent, tfsboc104180.Margin$, 
                      tfsboc104180.Total_Margin_Percent, tfsboc104180.Margin_Percent, 
					  tfsboc104180.Consumption_Percent1,tfsboc104180.Consumption_Percent2, tfsboc104180.Consumption_Percent3,
                      tfsboc104180.Consumption_Percent4, tfsboc104180.Consumption_Percent5, tfsboc104180.Consumption_Percent6, 
                      tfsboc104180.Consumption_Percent7, tfsboc104180.Consumption_Percent8, tfsboc104180.Consumption_Percent9, 
                      tfsboc104180.Consumption_Percent10, tfsboc104180.Consumption_Percent11, tfsboc104180.Consumption_Percent12, 
                      tfsboc104180.Consumption_Percent13, tfsboc104180.Consumption_Percent14, tfsboc104180.Consumption_Percent15,                      
					  tfsboc104180.BOC_Item1, tfsboc104180.BOC_Item2, tfsboc104180.BOC_Item3, tfsboc104180.BOC_Item4, tfsboc104180.BOC_Item5, 
                      tfsboc104180.BOC_Item6, tfsboc104180.BOC_Item7, tfsboc104180.BOC_Item8, tfsboc104180.BOC_Item9, tfsboc104180.BOC_Item10, 
                      tfsboc104180.BOC_Item11, tfsboc104180.BOC_Item12, tfsboc104180.BOC_Item13, tfsboc104180.BOC_Item14, tfsboc104180.BOC_Item15

ORDER BY Cus_Serial, tfsboc107180.Serial
--SET IDENTITY_INSERT tfsboc104180_analyse off

-- update field User --
-- update tfsboc104180_analyse set [user] = @User where [user] = ''


end







GO

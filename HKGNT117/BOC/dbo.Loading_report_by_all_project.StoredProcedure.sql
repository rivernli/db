USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_by_all_project]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[Loading_report_by_all_project]

 @plant nvarchar(50),
 @year int,
 @period int,
 @analyse_user nvarchar(20)

as
begin
	IF LTRIM(RTRIM(@plant)) = 'B1'
		SET @plant = 'P2'

	IF exists(select end_customer from tfsboc100180_analyse where plant = @plant  and Fiscal_Year = @year and Fiscal_Period = @period and Analysis_User = @analyse_user)
		BEGIN
			SELECT  t106.serial as Serial,T106.Key_customer as Customer,
					dbo.Loading_get_no_Proj(T106.Key_customer,@plant,@year,@period,@analyse_user) as No_of_Project,
					dbo.Loading_get_other_Avg_Layer_Count(T106.Key_customer,@plant,@year,@period,@analyse_user) as Avg_Layer_Count,
					dbo.Loading_get_other_ASP(T106.Key_customer,@plant,@year,@period,@analyse_user) as ASP$,
					dbo.Loading_get_other_ASP_Layer(T106.Key_customer,@plant,@year,@period,@analyse_user) as ASP_Layer$,
					dbo.Loading_get_other_output_Ft2(T106.Key_customer,@plant,@year,@period,@analyse_user) as Output_Ft2,
					dbo.Loading_get_other_percent_total_output_FT(T106.Key_customer,@plant,@year,@period,@analyse_user) as  [% of Total output Ft2],
					dbo.Loading_get_other_output_amount(T106.Key_customer,@plant,@year,@period,@analyse_user) as [Output$ amount],
					dbo.Loading_get_other_percent_Of_Total_Output$(T106.Key_customer,@plant,@year,@period,@analyse_user) as [%Of Total Output$],
					dbo.Loading_get_other_Margin$_Total(T106.Key_customer,@plant,@year,@period,@analyse_user) as [Margin$],
					dbo.Loading_get_other_percent_Margin$_Total(T106.Key_customer,@plant,@year,@period,@analyse_user) as [% of Total Margin$],
					dbo.Loading_get_Margin_Percent(T106.Key_customer,@plant,@year,@period,@analyse_user) as [Margin% Percent],
					(select top 1 t100.[Boc Item Type1] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type1,
					(select top 1 t100.[Boc Item Type2] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type2,
					(select top 1 t100.[Boc Item Type3] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type3,
					(select top 1 t100.[Boc Item Type4] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type4,
					(select top 1 t100.[Boc Item Type5] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type5,
					(select top 1 t100.[Boc Item Type6] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type6,
					(select top 1 t100.[Boc Item Type7] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type7,
					(select top 1 t100.[Boc Item Type8] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type8,
					(select top 1 t100.[Boc Item Type9] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type9,
					(select top 1 t100.[Boc Item Type10] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type10,
					(select top 1 t100.[Boc Item Type11] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type11,
					(select top 1 t100.[Boc Item Type12] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type12,
					(select top 1 t100.[Boc Item Type13] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type13,
					(select top 1 t100.[Boc Item Type14] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type14,
					(select top 1 t100.[Boc Item Type15] from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period and Analysis_User = @analyse_user)  as Boc_Item_Type15,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,1,'')  as Percent_of_Boc_Consumed1,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,2,'')  as Percent_of_Boc_Consumed2,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,3,'')  as Percent_of_Boc_Consumed3,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,4,'')  as Percent_of_Boc_Consumed4,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,5,'')  as Percent_of_Boc_Consumed5,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,6,'')  as Percent_of_Boc_Consumed6,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,7,'')  as Percent_of_Boc_Consumed7,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,8,'')  as Percent_of_Boc_Consumed8,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,9,'')  as Percent_of_Boc_Consumed9,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,10,'')  as Percent_of_Boc_Consumed10,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,11,'')  as Percent_of_Boc_Consumed11,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,12,'')  as Percent_of_Boc_Consumed12,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,13,'')  as Percent_of_Boc_Consumed13,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,14,'')  as Percent_of_Boc_Consumed14,
					dbo.Loading_get_CycleLoading(T106.Key_customer,@plant,@year,@period,@analyse_user,15,'')  as Percent_of_Boc_Consumed15
		--			(select sum(t100.[Percent of Boc Consumed1])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed1,
		--			(select sum(t100.[Percent of Boc Consumed2])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed2,
		--			(select sum(t100.[Percent of Boc Consumed3])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed3,
		--			(select sum(t100.[Percent of Boc Consumed4])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed4,
		--			(select sum(t100.[Percent of Boc Consumed5])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed5,
		--			(select sum(t100.[Percent of Boc Consumed6])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed6,
		--			(select sum(t100.[Percent of Boc Consumed7])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed7,
		--			(select sum(t100.[Percent of Boc Consumed8])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed8,
		--			(select sum(t100.[Percent of Boc Consumed9])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed9,
		--			(select sum(t100.[Percent of Boc Consumed10])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed10,
		--			(select sum(t100.[Percent of Boc Consumed11])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed11,
		--			(select sum(t100.[Percent of Boc Consumed12])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed12,
		--			(select sum(t100.[Percent of Boc Consumed13])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed13,
		--			(select sum(t100.[Percent of Boc Consumed14])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed14,
		--			(select sum(t100.[Percent of Boc Consumed15])/100 from tfsboc100180_analyse as t100 where t100.plant = t106.plant and T100.end_customer = T106.Key_customer and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed15
			from tfsboc106180 as t106 
			where t106.plant = @plant 
			and exists(select end_customer from tfsboc100180_analyse where plant = @plant  and Fiscal_Year = @year and Fiscal_Period = @period and T106.Key_customer = end_customer  and Analysis_User = @analyse_user)

			-- ==================  Calcute Others customer values  ===========================
			union all
			--use BOC
			--declare @plant nvarchar(50)
			--declare @year int
			--declare @period int
			--
			--set @plant = 'B3'
			--set @year = 2009
			--set @period = 6

			select 997 as Serial,
				'Others' as Customer,
				count(*) as No_of_Project,
				dbo.Loading_get_other_Avg_Layer_Count('others',@plant,@year,@period,@analyse_user) as Avg_Layer_Count,
				dbo.Loading_get_other_ASP('others',@plant,@year,@period,@analyse_user) as ASP$,
				dbo.Loading_get_other_ASP_Layer('others',@plant,@year,@period,@analyse_user) as ASP_Layer$,
				dbo.Loading_get_other_output_Ft2('others',@plant,@year,@period,@analyse_user) as Output_Ft2,
				dbo.Loading_get_other_percent_total_output_FT('others',@plant,@year,@period,@analyse_user) as  [% of Total output Ft2],
				dbo.Loading_get_other_output_amount('others',@plant,@year,@period,@analyse_user) as [Output$ amount],
				dbo.Loading_get_other_percent_Of_Total_Output$('others',@plant,@year,@period,@analyse_user) as [%Of Total Output$],
				dbo.Loading_get_other_Margin$_Total('others',@plant,@year,@period,@analyse_user) as [Margin$],
				dbo.Loading_get_other_percent_Margin$_Total('others',@plant,@year,@period,@analyse_user) as [% of Total Margin$],
				dbo.Loading_get_Margin_Percent('others',@plant,@year,@period,@analyse_user) as [Margin% Percent],
				'' as Boc_Item_Type1,
				'' as Boc_Item_Type2,
				'' as Boc_Item_Type3,
				'' as Boc_Item_Type4,
				'' as Boc_Item_Type5,
				'' as Boc_Item_Type6,
				'' as Boc_Item_Type7,
				'' as Boc_Item_Type8,
				'' as Boc_Item_Type9,
				'' as Boc_Item_Type10,
				'' as Boc_Item_Type11,
				'' as Boc_Item_Type12,
				'' as Boc_Item_Type13,
				'' as Boc_Item_Type14,
				'' as Boc_Item_Type15,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,1,'')  as Percent_of_Boc_Consumed1,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,2,'')  as Percent_of_Boc_Consumed2,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,3,'')  as Percent_of_Boc_Consumed3,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,4,'')  as Percent_of_Boc_Consumed4,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,5,'')  as Percent_of_Boc_Consumed5,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,6,'')  as Percent_of_Boc_Consumed6,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,7,'')  as Percent_of_Boc_Consumed7,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,8,'')  as Percent_of_Boc_Consumed8,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,9,'')  as Percent_of_Boc_Consumed9,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,10,'')  as Percent_of_Boc_Consumed10,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,11,'')  as Percent_of_Boc_Consumed11,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,12,'')  as Percent_of_Boc_Consumed12,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,13,'')  as Percent_of_Boc_Consumed13,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,14,'')  as Percent_of_Boc_Consumed14,
					dbo.Loading_get_CycleLoading('others',@plant,@year,@period,@analyse_user,15,'')  as Percent_of_Boc_Consumed15

		--			(select sum(t100.[Percent of Boc Consumed1])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed1,
		--			(select sum(t100.[Percent of Boc Consumed2])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed2,
		--			(select sum(t100.[Percent of Boc Consumed3])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed3,
		--			(select sum(t100.[Percent of Boc Consumed4])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed4,
		--			(select sum(t100.[Percent of Boc Consumed5])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed5,
		--			(select sum(t100.[Percent of Boc Consumed6])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed6,
		--			(select sum(t100.[Percent of Boc Consumed7])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed7,
		--			(select sum(t100.[Percent of Boc Consumed8])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed8,
		--			(select sum(t100.[Percent of Boc Consumed9])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed9,
		--			(select sum(t100.[Percent of Boc Consumed10])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed10,
		--			(select sum(t100.[Percent of Boc Consumed11])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed11,
		--			(select sum(t100.[Percent of Boc Consumed12])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed12,
		--			(select sum(t100.[Percent of Boc Consumed13])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed13,
		--			(select sum(t100.[Percent of Boc Consumed14])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed14,
		--			(select sum(t100.[Percent of Boc Consumed15])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant) and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed15
			from tfsboc100180_analyse as T100
			where plant = @plant and Fiscal_Year = @year and Fiscal_Period = @period  and Analysis_User = @analyse_user
			and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)

			-- ==================  Calcute Total customer values  ===========================
			union all
			--use BOC
			--declare @plant nvarchar(50)
			--declare @year int
			--declare @period int
			--
			--set @plant = 'B3'
			--set @year = 2009
			--set @period = 6

			select 998 as Serial,'Total' as Customer,
				count(*) as No_of_Project,
				dbo.Loading_get_other_Avg_Layer_Count('Total',@plant,@year,@period,@analyse_user) as Avg_Layer_Count,
				dbo.Loading_get_other_ASP('Total',@plant,@year,@period,@analyse_user) as ASP$,
				dbo.Loading_get_other_ASP_Layer('Total',@plant,@year,@period,@analyse_user) as ASP_Layer$,
				dbo.Loading_get_other_output_Ft2('Total',@plant,@year,@period,@analyse_user) as Output_Ft2,
				dbo.Loading_get_other_percent_total_output_FT('Total',@plant,@year,@period,@analyse_user) as  [% of Total output Ft2],
				dbo.Loading_get_other_output_amount('Total',@plant,@year,@period,@analyse_user) as [Output$ amount],
				dbo.Loading_get_other_percent_Of_Total_Output$('Total',@plant,@year,@period,@analyse_user) as [%Of Total Output$],
				dbo.Loading_get_other_Margin$_Total('Total',@plant,@year,@period,@analyse_user) as [Margin$],
				dbo.Loading_get_other_percent_Margin$_Total('Total',@plant,@year,@period,@analyse_user) as [% of Total Margin$],
				dbo.Loading_get_Margin_Percent('Total',@plant,@year,@period,@analyse_user) as [Margin% Percent],
				'' as Boc_Item_Type1,
				'' as Boc_Item_Type2,
				'' as Boc_Item_Type3,
				'' as Boc_Item_Type4,
				'' as Boc_Item_Type5,
				'' as Boc_Item_Type6,
				'' as Boc_Item_Type7,
				'' as Boc_Item_Type8,
				'' as Boc_Item_Type9,
				'' as Boc_Item_Type10,
				'' as Boc_Item_Type11,
				'' as Boc_Item_Type12,
				'' as Boc_Item_Type13,
				'' as Boc_Item_Type14,
				'' as Boc_Item_Type15,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,1,'')  as Percent_of_Boc_Consumed1,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,2,'')  as Percent_of_Boc_Consumed2,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,3,'')  as Percent_of_Boc_Consumed3,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,4,'')  as Percent_of_Boc_Consumed4,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,5,'')  as Percent_of_Boc_Consumed5,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,6,'')  as Percent_of_Boc_Consumed6,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,7,'')  as Percent_of_Boc_Consumed7,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,8,'')  as Percent_of_Boc_Consumed8,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,9,'')  as Percent_of_Boc_Consumed9,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,10,'')  as Percent_of_Boc_Consumed10,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,11,'')  as Percent_of_Boc_Consumed11,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,12,'')  as Percent_of_Boc_Consumed12,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,13,'')  as Percent_of_Boc_Consumed13,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,14,'')  as Percent_of_Boc_Consumed14,
					dbo.Loading_get_CycleLoading('Total',@plant,@year,@period,@analyse_user,15,'')  as Percent_of_Boc_Consumed15

		--			(select sum(t100.[Percent of Boc Consumed1])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed1,
		--			(select sum(t100.[Percent of Boc Consumed2])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed2,
		--			(select sum(t100.[Percent of Boc Consumed3])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed3,
		--			(select sum(t100.[Percent of Boc Consumed4])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed4,
		--			(select sum(t100.[Percent of Boc Consumed5])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed5,
		--			(select sum(t100.[Percent of Boc Consumed6])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed6,
		--			(select sum(t100.[Percent of Boc Consumed7])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed7,
		--			(select sum(t100.[Percent of Boc Consumed8])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed8,
		--			(select sum(t100.[Percent of Boc Consumed9])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed9,
		--			(select sum(t100.[Percent of Boc Consumed10])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed10,
		--			(select sum(t100.[Percent of Boc Consumed11])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed11,
		--			(select sum(t100.[Percent of Boc Consumed12])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed12,
		--			(select sum(t100.[Percent of Boc Consumed13])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed13,
		--			(select sum(t100.[Percent of Boc Consumed14])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed14,
		--			(select sum(t100.[Percent of Boc Consumed15])/100 from tfsboc100180_analyse as t100 where t100.plant = @plant  and t100.Fiscal_Year = @year and t100.Fiscal_Period = @period  and Analysis_User = @analyse_user)  as Percent_of_Boc_Consumed15
			from tfsboc100180_analyse as T100
			where plant = @plant and Fiscal_Year = @year and Fiscal_Period = @period and Analysis_User = @analyse_user

			-- ==================  Calcute Total per Week customer values  ===========================
			union all
			--use BOC
			--declare @plant nvarchar(50)
			--declare @year int
			--declare @period int
			--
			--set @plant = 'B3'
			--set @year = 2009
			--set @period = 6

			select 999 as Serial,'Total per Week' as Customer,
				(count(*)/dbo.Loading_get_week_day(@period)) as No_of_Project,
				'' as Avg_Layer_Count,
				'' as ASP$,
				'' as ASP_Layer$,
				dbo.Loading_get_other_output_Ft2('Total per Week',@plant,@year,@period,@analyse_user) as Output_Ft2,
				'' as  [% of Total output Ft2],
				dbo.Loading_get_other_output_amount('Total per Week',@plant,@year,@period,@analyse_user) as [Output$ amount],
				'' as [%Of Total Output$],
				dbo.Loading_get_other_Margin$_Total('Total per Week',@plant,@year,@period,@analyse_user) as [Margin$],
				'' as [% of Total Margin$],
				'' as [Margin% Percent],
				'' as Boc_Item_Type1,
				'' as Boc_Item_Type2,
				'' as Boc_Item_Type3,
				'' as Boc_Item_Type4,
				'' as Boc_Item_Type5,
				'' as Boc_Item_Type6,
				'' as Boc_Item_Type7,
				'' as Boc_Item_Type8,
				'' as Boc_Item_Type9,
				'' as Boc_Item_Type10,
				'' as Boc_Item_Type11,
				'' as Boc_Item_Type12,
				'' as Boc_Item_Type13,
				'' as Boc_Item_Type14,
				'' as Boc_Item_Type15,
				'' as Boc_Item_Type1,
				'' as Boc_Item_Type2,
				'' as Boc_Item_Type3,
				'' as Boc_Item_Type4,
				'' as Boc_Item_Type5,
				'' as Boc_Item_Type6,
				'' as Boc_Item_Type7,
				'' as Boc_Item_Type8,
				'' as Boc_Item_Type9,
				'' as Boc_Item_Type10,
				'' as Boc_Item_Type11,
				'' as Boc_Item_Type12,
				'' as Boc_Item_Type13,
				'' as Boc_Item_Type14,
				'' as Boc_Item_Type15
			from tfsboc100180_analyse as T100
			where plant = @plant and Fiscal_Year = @year and Fiscal_Period = @period  and Analysis_User = @analyse_user
		END
	ELSE
		BEGIN
			RAISERROR('NO data analysis!',16,1)
			RETURN
		END
end



GO

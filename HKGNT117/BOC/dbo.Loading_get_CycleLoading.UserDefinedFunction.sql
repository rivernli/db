USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_CycleLoading]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_get_CycleLoading](@Customer nvarchar(100),@plant nvarchar(10),@year int,@period int ,@analyse_user nvarchar(50),@serial int,@type nvarchar(15))
returns float
as
begin
	declare @Cycle_loading float
	declare @Capacity_loading float
	declare @workCenter nvarchar(50)
	declare @returns float
	
	if @Customer <> 'others' and @Customer <> 'Total' and @Customer <> 'Total per week' 
		begin
			if @serial = 1
				begin
					select @Cycle_loading = sum([Cycle time1]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type1]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
				end
			if @serial = 2
				begin
					select @Cycle_loading = sum([Cycle time2]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select @workCenter = [Boc Item Type2]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 3
				begin
					select @Cycle_loading = sum([Cycle time3]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type3]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 4
				begin
					select @Cycle_loading = sum([Cycle time4]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type4]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 5
				begin
					select @Cycle_loading = sum([Cycle time5]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type5]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 6
				begin
					select @Cycle_loading = sum([Cycle time6]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type6]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 7
				begin
					select @Cycle_loading = sum([Cycle time7]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type7]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 8
				begin
					select @Cycle_loading = sum([Cycle time8]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type8]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 9
				begin
					select @Cycle_loading = sum([Cycle time9]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type9]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 10
				begin
					select @Cycle_loading = sum([Cycle time10]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type10]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 11
				begin
					select @Cycle_loading = sum([Cycle time11]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select  top 1 @workCenter = [Boc Item Type11]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 12
				begin
					select @Cycle_loading = sum([Cycle time12]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type12]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 13
				begin
					select @Cycle_loading = sum([Cycle time13]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type13]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 14
				begin
					select @Cycle_loading = sum([Cycle time14]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type14]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 15
				begin
					select @Cycle_loading = sum([Cycle time15]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type15]
					from dbo.tfsboc100180_analyse
					where end_customer = @Customer
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

				select @Capacity_loading = T$SQQT from dbo.tfsboc004180
				where T$plant = @plant 
				and T$year = @year
				and T$PRNO = @Period
				and T$BITM = @workCenter

				if @Capacity_loading <> 0 
					set @returns = @Cycle_loading/@Capacity_loading
				else
					set @returns = 0
		end

	if @Customer = 'others'
		begin
			if @serial = 1
				begin
					select @Cycle_loading = sum([Cycle time1]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type1]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

			if @serial = 2
				begin
					select @Cycle_loading = sum([Cycle time2]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type2]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

			if @serial = 3
				begin
					select @Cycle_loading = sum([Cycle time3]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type3]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

			if @serial = 4
				begin
					select @Cycle_loading = sum([Cycle time4]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type4]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

			if @serial = 5
				begin
					select @Cycle_loading = sum([Cycle time5]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type5]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 6
				begin
					select @Cycle_loading = sum([Cycle time6]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type6]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 7
				begin
					select @Cycle_loading = sum([Cycle time7]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type7]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 8
				begin
					select @Cycle_loading = sum([Cycle time8]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type8]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

			if @serial = 9
				begin
					select @Cycle_loading = sum([Cycle time9]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type9]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 10
				begin
					select @Cycle_loading = sum([Cycle time10]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type10]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 11
				begin
					select @Cycle_loading = sum([Cycle time11]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type11]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 12
				begin
					select @Cycle_loading = sum([Cycle time12]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type12]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 13
				begin
					select @Cycle_loading = sum([Cycle time13]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type13]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 14
				begin
					select @Cycle_loading = sum([Cycle time14]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type14]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 15
				begin
					select @Cycle_loading = sum([Cycle time15]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type15]
					from dbo.tfsboc100180_analyse
					where end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
					and plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

				select @Capacity_loading = T$SQQT from dbo.tfsboc004180
				where T$plant = @plant 
				and T$year = @year
				and T$PRNO = @Period
				and T$BITM = @workCenter

				if @Capacity_loading <> 0 
					set @returns = @Cycle_loading/@Capacity_loading
				else
					set @returns = 0
		end

	if @Customer = 'Total'
		begin
			if @serial = 1
				begin
					select @Cycle_loading = sum([Cycle time1]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type1]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

			if @serial = 2
				begin
					select @Cycle_loading = sum([Cycle time2]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type2]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 3
				begin
					select @Cycle_loading = sum([Cycle time3]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type3]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 4
				begin
					select @Cycle_loading = sum([Cycle time4]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type4]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 5
				begin
					select @Cycle_loading = sum([Cycle time5]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type5]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 6
				begin
					select @Cycle_loading = sum([Cycle time6]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type6]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 7
				begin
					select @Cycle_loading = sum([Cycle time7]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type7]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 8
				begin
					select @Cycle_loading = sum([Cycle time8]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type8]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 9
				begin
					select @Cycle_loading = sum([Cycle time9]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type9]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 10
				begin
					select @Cycle_loading = sum([Cycle time10]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type10]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 11
				begin
					select @Cycle_loading = sum([Cycle time11]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type11]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 12
				begin
					select @Cycle_loading = sum([Cycle time12]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type12]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 13
				begin
					select @Cycle_loading = sum([Cycle time13]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type13]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 14
				begin
					select @Cycle_loading = sum([Cycle time14]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type14]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end
			if @serial = 15
				begin
					select @Cycle_loading = sum([Cycle time15]*([Production Volume Booking (Units)]/[Unit_per_Panel]/[Yield (Current)%]*100)/60)
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0

					select top 1 @workCenter = [Boc Item Type15]
					from dbo.tfsboc100180_analyse
					where plant = @plant 
					and Fiscal_Year = @year 
					and Fiscal_Period = @Period
					and Analysis_User = @analyse_user
					and [Unit_per_Panel] <> 0
					and [Yield (Current)%] <> 0
				end

				select @Capacity_loading = T$SQQT from dbo.tfsboc004180
				where T$plant = @plant 
				and T$year = @year
				and T$PRNO = @Period
				and T$BITM = @workCenter

				if @Capacity_loading <> 0 
					set @returns = @Cycle_loading/@Capacity_loading
				else
					set @returns = 0
		end


	return cast(@returns as decimal(18, 4))
end


GO

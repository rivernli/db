USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_product_type_Analyse]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[Loading_report_product_type_Analyse]
@new_output int,
@UID	int,
@User nvarchar(50)
as 
declare @rate_change float
declare @week_no int
begin
	-- get change rate // select * from tfsboc104180_analyse order by Cus_serial,serial
	if @new_output <> 0 
		select @rate_change = (@new_output / output_sqft) from tfsboc104180_analyse where id = @UID

		select @week_no = round((select output_sqft from tfsboc104180_analyse where  Product_Type = 'Total' and [User] = @User)/(select output_sqft from tfsboc104180_analyse where  Product_Type = 'Total per Week' and [User] = @User),0)

	-- Output_sqft
		-- update current line output
		update tfsboc104180_analyse set output_sqft = @new_output	where id = @UID

		-- Update total SQFT 
		update tfsboc104180_analyse set output_sqft = (select sum(output_sqft) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User)
		where Product_Type = 'Total'
		and [User] = @User

		-- Update Total per Week
		if @week_no <> 0
			update 	tfsboc104180_analyse set output_sqft = ((select output_sqft from tfsboc104180_analyse where  Product_Type = 'Total' and [User] = @User)/@week_no) where  Product_Type = 'Total per Week' and [User] = @User

	-- Output_Percent
		-- update output percent by ver Product_Type
		update tfsboc104180_analyse set output_percent = output_sqft / (select sum(output_sqft) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User)
		where Product_Type not like N'Total'+'%'
		and [User] = @User

	-- Output_Amount
		update tfsboc104180_analyse set Output_Amount = Output_Amount *	@rate_change where id = @UID
		update tfsboc104180_analyse set Output_Amount = (select sum(Output_Amount) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User)
		where Product_Type = 'Total'
		and [User] = @User
		-- update Total per week
		if @week_no <> 0
			update 	tfsboc104180_analyse set Output_Amount = ((select Output_Amount from tfsboc104180_analyse where  Product_Type = 'Total' and [User] = @User)/@week_no) where  Product_Type = 'Total per Week' and [User] = @User

	-- Amount_Percent
		update tfsboc104180_analyse set  Amount_Percent= Output_Amount / (select sum(Output_Amount) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User)
		where Product_Type not like N'Total'+'%'
		and [User] = @User

	-- Margin$
		update tfsboc104180_analyse set Margin$ = Margin$ *	@rate_change where id = @UID
		update tfsboc104180_analyse set Margin$ = (select sum(Margin$) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User)
		where Product_Type = 'Total'
		and [User] = @User
		-- update Total per week
		if @week_no <> 0
			update 	tfsboc104180_analyse set Margin$ = ((select Margin$ from tfsboc104180_analyse where  Product_Type = 'Total' and [User] = @User)/@week_no) where  Product_Type = 'Total per Week' and [User] = @User


	-- Total_Margin_Percent
		update tfsboc104180_analyse set  Total_Margin_Percent= Margin$ / (select sum(Margin$) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User)
		where Product_Type not like N'Total'+'%'
		and [User] = @User

	-- Margin_Percent
--		update tfsboc104180_analyse set Margin_Percent = Margin_Percent * @rate_change where id = @UID
--		update tfsboc104180_analyse set Margin_Percent = (select sum(Margin_Percent) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User
		update tfsboc104180_analyse set Margin_Percent = ((select Margin$ from tfsboc104180_analyse where Product_Type = 'Total' and [User] = @User)/(select Output_Amount from tfsboc104180_analyse where Product_Type = 'Total' and [User] = @User)) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 1
		update tfsboc104180_analyse set Consumpton_Percent1 = Consumpton_Percent1 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent1 = (select sum(Consumpton_Percent1) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 2
		update tfsboc104180_analyse set Consumpton_Percent2 = Consumpton_Percent2 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent2 = (select sum(Consumpton_Percent2) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 3
		update tfsboc104180_analyse set Consumpton_Percent3 = Consumpton_Percent3 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent3 = (select sum(Consumpton_Percent3) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 4
		update tfsboc104180_analyse set Consumpton_Percent4 = Consumpton_Percent4 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent4 = (select sum(Consumpton_Percent4) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User
	
	-- Consumption_Percent 5
		update tfsboc104180_analyse set Consumpton_Percent5 = Consumpton_Percent5 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent5 = (select sum(Consumpton_Percent5) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 6
		update tfsboc104180_analyse set Consumpton_Percent6 = Consumpton_Percent6 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent6 = (select sum(Consumpton_Percent6) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 7
		update tfsboc104180_analyse set Consumpton_Percent7 = Consumpton_Percent7 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent7 = (select sum(Consumpton_Percent7) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 8
		update tfsboc104180_analyse set Consumpton_Percent8 = Consumpton_Percent8 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent8 = (select sum(Consumpton_Percent8) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 9
		update tfsboc104180_analyse set Consumpton_Percent9 = Consumpton_Percent9 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent9 = (select sum(Consumpton_Percent9) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 10
		update tfsboc104180_analyse set Consumpton_Percent10 = Consumpton_Percent10 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent10 = (select sum(Consumpton_Percent10) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 11
		update tfsboc104180_analyse set Consumpton_Percent11 = Consumpton_Percent11 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent11 = (select sum(Consumpton_Percent11) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 12
		update tfsboc104180_analyse set Consumpton_Percent12 = Consumpton_Percent12 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent12 = (select sum(Consumpton_Percent12) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 13
		update tfsboc104180_analyse set Consumpton_Percent13 = Consumpton_Percent13 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent13 = (select sum(Consumpton_Percent13) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 14
		update tfsboc104180_analyse set Consumpton_Percent14 = Consumpton_Percent14 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent14 = (select sum(Consumpton_Percent14) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- Consumption_Percent 15
		update tfsboc104180_analyse set Consumpton_Percent15 = Consumpton_Percent15 * @rate_change where id = @UID
		update tfsboc104180_analyse set Consumpton_Percent15 = (select sum(Consumpton_Percent15) from tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- update Total ASP$ = ASP = (Total Output_Amount) / (Total Output_SQFT)

		update  tfsboc104180_analyse set ASP$ = Output_Amount / Output_SQFT where Product_Type = 'Total' and [User] = @User

	-- update ALC = Sum(Production_Book_SqFt*(Layer_Count-2)/2)/Sum(Production_Book_SqFt)*2+2
		update tfsboc104180_analyse set Avg_Layer_Count = (select sum(Avg_Layer_Count * Output_Percent) from dbo.tfsboc104180_analyse where Product_Type not like N'Total'+'%' and [User] = @User) where Product_Type = 'Total' and [User] = @User

	-- update ASP/Layer=ASP/ALC
		update tfsboc104180_analyse set ASP_Layer = ASP$ / Avg_Layer_Count where Product_Type = 'Total' and [User] = @User
end









GO

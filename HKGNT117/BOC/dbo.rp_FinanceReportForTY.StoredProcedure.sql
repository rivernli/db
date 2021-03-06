USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[rp_FinanceReportForTY]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[rp_FinanceReportForTY]

@Fyear  int,
@Fperiod  int,
@plant  nvarchar(10),
@project nvarchar(50)
--@p_from  nvarchar(10),
--@p_to  nvarchar(50)
as

begin
	set @plant = isnull(@plant,'')
	set @project = isnull(@project,'')
	set @project = '%'+@project+'%'
	if exists (	select top 1 * from dbo.tfsboc100180
					WHERE     (Fiscal_Year = @FYear) 
					AND (Fiscal_Period = @FPeriod) 
					AND (Plant = @Plant)
					AND [Projects(8)] like @project)
		begin
			select 
				'' as Project_No,
				0 Quantity,
				sum([Production Volume Booking (Square F]) [Square Footage],
				0 as [Unit_Sale_Price],
				sum([Total Sales (USD)]) as Sales,
				0 as [Unit_Material_Cost],
				sum([Material cost (Scrap included)] * [Production Volume Booking (Units)]) as [Material Cost],
				0 as [Unit Total Cost],
				sum([Total Cost per unit(US$)] * [Production Volume Booking (Units)]) as [Total Cost],
				sum([Total Sales (USD)]-[Material cost (Scrap included)] * [Production Volume Booking (Units)]) as [Value add margin],
				sum([Total Sales (USD)]-[Total Cost per unit(US$)] * [Production Volume Booking (Units)]) as [Operating profit or Lost],
				(sum([Total Sales (USD)])-sum([Material cost (Scrap included)] * [Production Volume Booking (Units)]))/sum([Total Sales (USD)]) as [% VAM],
				(sum([Total Sales (USD)])-sum([Total Cost per unit(US$)] * [Production Volume Booking (Units)]))/sum([Total Sales (USD)]) as [%OP],

				case 
				when sum([Total Sales (USD)]-[Material cost (Scrap included)] * [Production Volume Booking (Units)]) < 0 then '-'
				else	''
				end as svam,

				case 
				when sum([Total Sales (USD)]-[Total Cost per unit(US$)] * [Production Volume Booking (Units)]) < 0 then '-'
				else ''
				end as sop,

				'' as spvam,
				'' as spop

			from dbo.tfsboc100180
			WHERE     (Fiscal_Year = @FYear) AND (Fiscal_Period = @FPeriod) AND (Plant = @Plant) --AND (Project BETWEEN @p_from AND @p_to)
			and [Projects(8)] like @project
			--group by 1

			UNION ALL

			select [Projects(8)] as Project_No,
				[Production Volume Booking (Units)] as Quantity,
				[Production Volume Booking (Square F] as [Square Footage],
				cast([Selling Price Per Unit (US$)] as decimal(18, 3)) as [Unit_Sale_Price],
				cast([Total Sales (USD)] as decimal(18, 3)) as Sales,
				[Material cost (Scrap included)] as [Unit_Material_Cost],
				[Material cost (Scrap included)] * [Production Volume Booking (Units)] as [Material Cost],
				[Total Cost per unit(US$)] as [Unit Total Cost],
				[Total Cost per unit(US$)] * [Production Volume Booking (Units)] as [Total Cost],
				([Total Sales (USD)]-[Material cost (Scrap included)] * [Production Volume Booking (Units)]) as [Value add margin],
				cast(([Total Sales (USD)]-[Total Cost per unit(US$)] * [Production Volume Booking (Units)]) as decimal(18, 3)) as [Operating profit or Lost],

				case [Total Sales (USD)]
				when 0 then 0
				else
				cast((([Total Sales (USD)]-[Material cost (Scrap included)] * [Production Volume Booking (Units)])/[Total Sales (USD)]) as decimal(18,4))
				end as [% VAM],

				case [Total Sales (USD)]
				when 0 then 0
				else
				cast((([Total Sales (USD)]-[Total Cost per unit(US$)] * [Production Volume Booking (Units)])/([Total Sales (USD)])) as decimal(18,4))
				end  as [%OP],

				case 
				when [Total Sales (USD)] = 0 then ''
				when ([Total Sales (USD)]-[Material cost (Scrap included)] * [Production Volume Booking (Units)]) < 0 then '-'
				else	''
				end as svam,

				case 
				when [Total Sales (USD)] = 0 then ''
				when ([Total Sales (USD)]-[Total Cost per unit(US$)] * [Production Volume Booking (Units)]) < 0 then '-'
				else ''
				end as sop,

				case
				when [Total Sales (USD)] = 0 then ''
				when (([Total Sales (USD)]-[Material cost (Scrap included)] * [Production Volume Booking (Units)])/[Total Sales (USD)]) < 0  then  '-' 
				else  ''
				end		as spvam,

				case 
				when [Total Sales (USD)] = 0 then ''
				when (([Total Sales (USD)]-[Total Cost per unit(US$)] * [Production Volume Booking (Units)])/([Total Sales (USD)])) < 0 then '-'
				else  ''
				end as spop
			from dbo.tfsboc100180
			WHERE     (Fiscal_Year = @FYear) AND (Fiscal_Period = @FPeriod) AND (Plant = @Plant) --AND (Project BETWEEN @p_from AND @p_to)
		and [Projects(8)] like @project
	end
end


GO

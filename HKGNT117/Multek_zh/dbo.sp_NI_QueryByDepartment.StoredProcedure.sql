USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_NI_QueryByDepartment]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_NI_QueryByDepartment]

@timeline tinyint,  -- 1 = year, 2 = quarter, 3 = period
@startYear int,
@startPeriod int,
@endYear int,
@endPeriod int ,
@b1 bit,
@b2f bit,
@b3 bit,
@b4 bit,
@b5 bit

as
begin

declare @startQ int
declare @endQ int
set @startQ = @startYear * 100 + @startPeriod;
set @endQ = @endYear * 100 + @endPeriod;

declare @_b1 char(3)
declare @_b2f char(3)
declare @_b3 char(3)
declare @_b4 char(3)
declare @_b5 char(3)
set @_b1='_B1'
set @_b2f='_B2F'
set @_b3='_B3'
set @_b4='_B4'
set @_b5='_B5'
if(@b1=1)
	set @_b1 ='B1';
if(@b2f=1)
	set @_b2f ='2F';
if(@b3=1)
	set @_b3 ='B3';
if(@b4=1)
	set @_b4 = 'B4';
if(@b5=1)
	set @_b5 = 'B5';

if(@timeline = 1)
begin
	select department,round(sum(amount),4) as amt,FiscalYear,'' as p from vw_non_production_with_Calender 
	where fiscalYear between @startYear and @endYear
	and factory in (@_b1,@_b2f,@_b3,@_b4,@_b5)
	group by department,fiscalYear order by department,fiscalYear;
end 

if(@timeline=3)
begin
	select department,round(sum(amount),4) as amt,FiscalYear,FiscalPeriod as p from vw_non_production_with_Calender 
	where (fiscalYear * 100) + FiscalPeriod between @startQ and @endQ 
	and factory in (@_b1,@_b2f,@_b3,@_b4,@_b5)
	group by department,FiscalYear,FiscalPeriod order by department,FiscalYear,FiscalPeriod;
end

if(@timeline=2)
begin
	select department,round(sum(amount),4) as amt,FiscalYear,FiscalQuarter as p from vw_non_production_with_Calender 
	where (fiscalYear * 100) + FiscalQuarter between @startQ and @endQ 
	and factory in (@_b1,@_b2f,@_b3,@_b4,@_b5)
	group by department,FiscalYear,FiscalQuarter order by department,FiscalYear,FiscalQuarter;
end

end









GO

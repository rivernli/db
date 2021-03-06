USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_ForecastCustomerPart_Get_4B2F]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_ForecastCustomerPart_Get_4B2F]
@period int, @oemId int, @periodLong int=3,@totalPeriod int=5,
@oem nvarchar(100) output, @baanName nvarchar(100) output, @plant char(3) output
as
/*

declare @oemId int,@totalPeriod int, @period int
select @oemId = 967--18--65
, @totalPeriod=11 ,@period = 201408
*/


declare @_currentPeriod int, 
		@_B3Period int,
		@_startPeriod int,
		@_endPeriod int

select	@_currentPeriod = multek_zh.dbo.fx_getCurrentPeriod(),
		@_startPeriod = @period,
		@_B3Period = multek_zh.dbo.fx_getAddPeriod(@_startPeriod,-3),
		@_endPeriod = multek_zh.dbo.fx_getAddPeriod(@_startPeriod,@totalPeriod),
		@baanName = OEMName,
		@plant = plant,
		@OEM = CusOEM
from vw_gam_oemcomb where oemid = @oemId



declare @prjHistory table (
	customerPrj nvarchar(100),
	intPrj nvarchar(100),
	period int,
	amount int--decimal(18,3)
)

if(@Plant = 'B3' or @Plant='2f')
begin
	insert into @prjHistory
	select	cus_part_no,max(int_part_no), iperiod, sum(amount) as amt 
	from	GAM_sales 
	where	plant = @plant 
			and oem = @baanName 
			and iperiod >= @_B3Period 
			and iperiod < @_startPeriod
	group by cus_part_no, iperiod
end
else
begin
	insert into @prjHistory
	select	cus_part_no, max(int_part_no),iperiod, sum(amount) as amt 
	from	GAM_sales 
	where	plant = @plant 
			and oem = @baanName 
			and iperiod >= @_B3Period 
			and iperiod < iperiod
	group by cus_part_no, iperiod
	having sum(amount) > 40000
	
	delete @prjHistory where customerPrj in 
	(select customerPrj from @prjHistory group by customerPrj having count(period) <3) 
end

if(@Plant='2f')
begin
	delete @prjHistory from @prjHistory left join vw_gam_B2F_project_type on intPrj=int_part_no 
	where oem=@baanName and itemType <> right(@OEM,3)
end


/****/
/** making period list **/
declare @ydiff int
if exists (select 1 from multek_zh.dbo.vw_CalenderLDP where iperiod = @_endPeriod)
	select @ydiff = 0
else
	select @ydiff =(cast(substring(cast(@_startPeriod as varchar(6)),1,4) as int)-2000) *100

declare @periodList table (iperiod int)

insert into @periodList (iperiod) 	
select	iperiod + @ydiff as iperiod 
from	multek_zh.dbo.vw_CalenderLDP 
where	iperiod between (@_startPeriod-@ydiff) and (@_endPeriod -@ydiff)
/** end making period list**/
/****/

declare @inpHistory table (iperiod int ,sid int, project nvarchar(100),amt int)--decimal(18,3))
insert into @inpHistory
select iperiod,b.sid,project,amt from @periodList as a left join gam_part_forecast as b 
on a.iperiod=b.period and b.oemid=@oemid

select period as iperiod,b.customerPrj as cus_part_no, amount as amt 
from @prjHistory as b right join (select customerPrj,max(period) as p from @prjHistory  group by customerPrj) as a
on a.customerPrj=b.customerPrj and p=period
union all
select @_startPeriod as Iperiod,project as cus_part_no,0 as amt 
from @inpHistory left join @prjHistory on customerPrj=project
where customerPrj is null and project is not null group by project

select * from @inpHistory

select	@_startPeriod = multek_zh.dbo.fx_getAddPeriod(@_currentPeriod ,-3)
		
delete @periodList

insert into @periodList (iperiod) 	
select	iperiod 
from	multek_zh.dbo.vw_CalenderLDP 
where	iperiod >= @_startPeriod and  iperiod < @_currentPeriod

select iperiod,isnull(customerPRj,'') as cus_part_no, isnull(amount,'')  as samt
from @periodList left join @prjHistory on period=iperiod


--select period as iPeriod,customerPRj as cus_part_no, amount as samt from @prjHistory
GO

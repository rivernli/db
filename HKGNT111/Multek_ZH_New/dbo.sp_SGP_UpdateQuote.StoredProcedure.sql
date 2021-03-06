USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_UpdateQuote]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_UpdateQuote] 
@QuoteTeam bit, @editType varchar(10),@operId nvarchar(10),
@flag bit=0,@batchflag bit=0,
@id int,
	@salesman nvarchar(50),
	@indate nvarchar(12),@outdate nvarchar(12),@oem nvarchar(100),@cem nvarchar(100),
	@name nvarchar(100),@programme nvarchar(100),@pn nvarchar(100),@rev nvarchar(100),@product nvarchar(100),
	@width nvarchar(100),@length nvarchar(100),@unit nvarchar(100),@arraywidth nvarchar(100),@arraylength nvarchar(100),
	@unitperarray nvarchar(100),@prodwidth nvarchar(100),@prodlength nvarchar(100),@unitperprod nvarchar(100),
	@matl_percentage nvarchar(100),@layers nvarchar(100),@holes nvarchar(100),@smallesthole nvarchar(100),
	@matl nvarchar(100),@matltype nvarchar(100),@thk nvarchar(100),@copper nvarchar(100),@finishing nvarchar(100),
	@lno nvarchar(100),@lni nvarchar(100),@imped nvarchar(100),@usize nvarchar(100),@uqty nvarchar(100),
	@blindsize nvarchar(100),@blindqty nvarchar(100),@buriesize nvarchar(100),@burieqty nvarchar(100),
	@outline nvarchar(100),@remark nvarchar(500),@shipterms nvarchar(100),@payterms nvarchar(100),@leadtime nvarchar(100),
	@currency nvarchar(100),@period nvarchar(100),@note1 nvarchar(100),@note2 nvarchar(100),@status nvarchar(100),
	@yield nvarchar(100),@ftp nvarchar(100),@uid nvarchar(100),@dom nvarchar(100),@ssid nvarchar(100),
	@shiptermadder nvarchar(100),@exchangerate nvarchar(100),@etestcharge nvarchar(100),@toolingcharge nvarchar(100),
	@setupcharge nvarchar(100),
	@commission nvarchar(100),@min_sq_inch nvarchar(100),@min_asp nvarchar(100),@moq nvarchar(100),
	@targetprice nvarchar(100),@targetasp nvarchar(100),@targetsqinch nvarchar(100),@target_actual nvarchar(100),
	@cost nvarchar(100),@matlcost nvarchar(100),@profit nvarchar(100),
	@qty1 nvarchar(100),@price1 nvarchar(100),@remark1 nvarchar(100),
	@qty2 nvarchar(100),@price2 nvarchar(100),@remark2 nvarchar(100),
	@qty3 nvarchar(100),@price3 nvarchar(100),@remark3 nvarchar(100),
	@qty4 nvarchar(100),@price4 nvarchar(100),@remark4 nvarchar(100),
	@qty5 nvarchar(100),@price5 nvarchar(100),@remark5 nvarchar(100)
	
	,@building nvarchar(20),
	@model nvarchar(100),
    @sqftarray nvarchar(20),
    @volumepermonth nvarchar(20),
    @expectedlifetime nvarchar(20),
    @factoryloading nvarchar(20),
    @panelutilization nvarchar(20),
    @project nvarchar(30),
    @projectremark nvarchar(500)

as
set nocount on
	
execute [sp_SGP_UpdateHistory] @editType,@operId,@id
update sgp_data set 
	salesman=@salesman,
	indate=@indate,	
	outdate=@outdate,	
	oem=@oem,	
	cem=@cem,	
	name=@name,	
	programme=@programme,	
	pn=@pn,
	tpn=@pn,	
	rev=@rev,	
	product=@product,	
	width=@width,	
	length=@length,	
	unit=@unit,	
	arraywidth=@arraywidth,	
	arraylength=@arraylength,	
	unitperarray=@unitperarray,	
	prodwidth=@prodwidth,	
	prodlength=@prodlength,	
	unitperprod=@unitperprod,
	matl_percentage=@matl_percentage,	
	layers=@layers,	
	holes=@holes,	
	smallesthole=@smallesthole,	
	matl=@matl,	
	matltype=@matltype,	
	thk=@thk,	
	copper=@copper,	
	finishing=@finishing,	
	lno=@lno,
	lni=@lni,	
	imped=@imped,	
	usize=@usize,	
	uqty=@uqty,	
	blindsize=@blindsize,	
	blindqty=@blindqty,
	buriesize=@buriesize,
	burieqty=@burieqty,	
	outline=@outline,	
	remark=@remark,	
	shipterms=@shipterms,	
	payterms=@payterms,	
	leadtime=@leadtime,
	currency=@currency,	
	period=@period,	
	note1=@note1,	
	note2=@note2,	
	status=@status,	
	yield=@yield,	
	ftp=@ftp,	
	uid=@uid,
	dom=@dom,	
	adate=getdate(),	
	ssid=@ssid
	,
	building=@building,
	model=@model,
	sqftarray=@sqftarray,
	volumepermonth=@volumepermonth,
	expectedlifetime=@expectedlifetime,
	factoryloading=@factoryloading,
	panelutilization=@panelutilization,
	project=@project,
	projectremark=@projectremark
	,
	flag=@flag,
	batchflag=@batchflag
	
	WHERE id=@id
	
if(@outdate='')
	update sgp_data set outdate=null where id =@id
if(@indate='')
	update sgp_data set indate=null where id=@id
	
if(@quoteteam=0)
begin
	update sgp_data set
	shiptermadder=@shiptermadder,	exchangerate=@exchangerate,	etestcharge=@etestcharge,	toolingcharge=@toolingcharge,
    commission=@commission,    min_sq_inch=@min_sq_inch,    min_asp=@min_asp,    moq=@moq,
    targetprice=@targetprice,targetasp=@targetasp,targetsqinch=@targetsqinch,target_actual=@target_actual,
    cost=@cost,matlcost=@matlcost,profit=@profit,setupcharge=@setupcharge,
    qty1=@qty1,price1=@price1,remark1=@remark1,
    qty2=@qty2,price2=@price2,remark2=@remark2,
    qty3=@qty3,price3=@price3,remark3=@remark3,
    qty4=@qty4,price4=@price4,remark4=@remark4,
    qty5=@qty5,price5=@price5,remark5=@remark5
	where id=@id
end            

exec sp_SGP_addItems @finishing,'finishing'

set nocount off
GO

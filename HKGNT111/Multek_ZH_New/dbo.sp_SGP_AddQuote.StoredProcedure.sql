USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_AddQuote]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_AddQuote] 
@QuoteTeam bit, @flag bit=0,@batchflag bit=0,
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
	@setupcharge nvarchar(100),	@commission nvarchar(100),@min_sq_inch nvarchar(100),@min_asp nvarchar(100),@moq nvarchar(100),
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
    ,@initQuoteId int=0
    
,@id int output
,@rfq nvarchar(100) output

as
set nocount on
	
--declare @rfq nvarchar(100)

select @rfq='QT'+ substring(max(rfq),3,3) + right(cast((cast(right(max(rfq),7) as int) + 10000001) as nvarchar(8)),7)
from sgp_data where substring(rfq,3,3)= left(@uid,3)

if(@rfq is null)
	select @rfq = 'QT'+ upper(substring(max(@uid),1,3)) + '0000001'


insert into sgp_data
(rfq,salesman,indate,outdate,OEM,CEM,name,programme,PN,tPN,rev,product,width,length,unit,
arraywidth,arraylength,unitperarray,prodwidth,prodlength,unitperprod,matl_percentage,layers,holes,smallesthole,
matl,matltype,thk,copper,finishing,lno,lni,imped,usize,uqty,blindsize,blindqty,buriesize,burieqty,
outline,remark,shipterms,payterms,leadtime,currency,setupcharge,period,note1,note2,status,yield,FTP,
UID,pUID,DOM,adate,ssid,parid,flag,batchflag

	,building,model,sqftarray,volumepermonth,expectedlifetime,factoryloading,panelutilization,project,projectremark,initQuoteId
)
values 
(@rfq,@salesman,@indate,@outdate,@OEM,@CEM,@name,@programme,@PN,@PN,@rev,@product,@width,@length,@unit,
@arraywidth,@arraylength,@unitperarray,@prodwidth,@prodlength,@unitperprod,@matl_percentage,@layers,@holes,@smallesthole,
@matl,@matltype,@thk,@copper,@finishing,@lno,@lni,@imped,@usize,@uqty,@blindsize,@blindqty,@buriesize,@burieqty,
@outline,@remark,@shipterms,@payterms,@leadtime,@currency,@setupcharge,@period,@note1,@note2,@status,@yield,@FTP,
@UID,@UID,@DOM,getdate(),@ssid,0,@flag,@batchflag

	,@building,@model,@sqftarray,@volumepermonth,@expectedlifetime,@factoryloading,@panelutilization,@project,@projectremark,@initQuoteId
)

select @id=@@identity
update sgp_data set parid=id,pn=tpn,puid=uid where id =@id 

if(@outdate='') 
	update sgp_data set outdate=null where id=@id
if(@indate='')
	update sgp_data set indate=null where id=@id


	update sgp_data set
	shiptermadder=@shiptermadder,	exchangerate=@exchangerate,	etestcharge=@etestcharge,	toolingcharge=@toolingcharge,
    commission=@commission,    min_sq_inch=@min_sq_inch,    min_asp=@min_asp,    moq=@moq,
    targetprice=@targetprice,targetasp=@targetasp,targetsqinch=@targetsqinch,target_actual=@target_actual,
    cost=@cost,matlcost=@matlcost,profit=@profit,
    qty1=@qty1,price1=@price1,remark1=@remark1,
    qty2=@qty2,price2=@price2,remark2=@remark2,
    qty3=@qty3,price3=@price3,remark3=@remark3,
    qty4=@qty4,price4=@price4,remark4=@remark4,
    qty5=@qty5,price5=@price5,remark5=@remark5
	where id=@id	
exec sp_SGP_addItems @finishing,'finishing'

update SGP_item set flag = '1' where flag='0'

exec dbo.quotutation_flow_sp_get_cost_details_3 @id

set nocount off
GO

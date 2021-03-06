USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_appToSGP]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_appToSGP] @cost_id int
--WITH EXECUTE AS 'asia\hkg_sql'
as
set nocount on
declare @gpid int,@price float,@qty int,@terms nvarchar(200),@rfq nvarchar(100)
select @gpid=gpid,@price=P,@qty=Q,@terms=payment_terms,@rfq=rfq
from dbo.vw_SGP_WorkflowStatus 
where costid=@cost_id and wfstatus=1

if(@gpid is not null)
begin
	if exists(select 1 from hkgnt117.multek_bi.dbo.tSalesQuotes where rfq=@rfq)
		return
		
	update sgp_data set payterms=@terms,price1=@price,qty1=@qty where id=@gpid

	select * into #tmp_gp from sgp_data where id=@gpid
	--alter table #tmp_gp drop column id
	insert into hkgnt117.multek_bi.dbo.tSalesQuotes
	(rfq,salesman,indate,outdate,OEM,CEM,name,programme,PN,tPN,rev,product,width,length,unit,arraywidth,arraylength,unitperarray,prodwidth,prodlength,unitperprod,matl_percentage,layers,holes,smallesthole,matl,matltype,thk,copper,finishing,lno,lni,imped,usize,uqty,blindsize,blindqty,buriesize,burieqty,outline,remark,shipterms,shiptermadder,payterms,leadtime,currency,exchangerate,setupcharge,Etestcharge,toolingcharge,commission,min_sq_inch,min_asp,moq,period,qty1,price1,remark1,qty2,price2,remark2,qty3,price3,remark3,qty4,price4,remark4,qty5,price5,remark5,note1,note2,targetprice,targetasp,targetsqinch,target_actual,status,cost,matlcost,yield,profit,FTP,region,factory,UID,pUID,DOM,adate,ssid,parid,flag,batchflag,building,model,sqftarray,volumepermonth,expectedlifetime,panelutilization,factoryloading,project,projectremark)
	select rfq,salesman,indate,outdate,OEM,CEM,name,programme,PN,tPN,rev,product,width,length,unit,arraywidth,arraylength,unitperarray,prodwidth,prodlength,unitperprod,matl_percentage,layers,holes,smallesthole,matl,matltype,thk,copper,finishing,lno,lni,imped,usize,uqty,blindsize,blindqty,buriesize,burieqty,outline,remark,shipterms,shiptermadder,payterms,leadtime,currency,exchangerate,setupcharge,Etestcharge,toolingcharge,commission,min_sq_inch,min_asp,moq,period,qty1,price1,remark1,qty2,price2,remark2,qty3,price3,remark3,qty4,price4,remark4,qty5,price5,remark5,note1,note2,targetprice,targetasp,targetsqinch,target_actual,status,cost,matlcost,yield,profit,FTP,region,factory,UID,pUID,DOM,adate,ssid,parid,flag,batchflag,building,model,sqftarray,volumepermonth,expectedlifetime,panelutilization,factoryloading,project,projectremark
	from #tmp_gp
	
	drop table #tmp_gp
end

set nocount off
GO

USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_addToVI]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_SGP_addToVI] (@gpid int,@testing bit=1, @message nvarchar(100) output ,@works bit output)
as
return

declare @programme nvarchar(50), @isPriced bit
select @programme=programme,@isPriced=isnumeric(price1) from sgp_data where id=@gpid

--tVI_GP (local)
if exists(select 1 from sgp_addtovi where gpid=@gpid and programme=@programme)
	select @message='This GP id Already sent to VI.'
else
begin
	if @isPriced=0
		select @message = 'The programme of GP didn''t price or priced wrongly'
	else 
	begin
		declare @m nvarchar(10)
		select @m=isnull(mulstatus,'') from HKGNT105.multek.dbo.tVI4 where rfq=@programme
		if @m is null
			select @message = 'Can''t find correponding RFQ in VI.'
		else if @m = 'no'
			select @message ='Corresponding RFQ is closed.'
	end	
end

select @works=0

if @message is null 
begin
	select @works =1
	if @testing=0
	begin
		--insert into tVI_multek
		insert into HKGNT105.multek.dbo.tVI_multek
		(rfq,pn,volumn_year,supplier,quoted_fab_site,layerCount,Material,board_thk,layerstructure,
		no_of_holes,smallest_hole,line_width,impedan_control,surface_finishing,copper_thk,
		single_board_dimX,Single_board_DimY,Panelisation_DimX,Panelisation_DimY,qty_panel,
		routing_punching,moq_mov,leadtime_weeks,shipmentterms,toolingcost,priceUSD,Remarks,
		uid,dom,adate,ssid)
	
		select programme,tpn,qty1 
		+case when qty2 <>'' then ';'+qty2 else '' end
		+case when qty3 <>'' then ';'+qty3 else '' end
		+case when qty4 <>'' then ';'+qty4 else '' end
		+case when qty5 <>'' then ';'+qty5 else '' end,
		'Multek China','Multek_ China',layers,case when matltype<>'' then matltype else matl end,
		thk+unit,layers,holes+'/'+product,smallesthole+unit,
		case when rtrim(lno)<>'' then 
			case when rtrim(lni)<>'' then lno+'/'+unit +';' else lno+'/'+unit end
		else '' end + case when rtrim(lni)<> '' then lni+'/'+unit else '' end as line_width,
		imped,finishing,copper,width+'/'+unit,length+'/'+unit,arraywidth+'/'+unit,arraylength+'/'+unit,unitperarray,
		outline,'USD'+moq,leadtime,shipterms, 'USD' + convert(nvarchar(20),
		0 + case when isnumeric(setupcharge)=1 then setupcharge else 0 end
		+ case when isnumeric(etestcharge)=1 then etestcharge else 0 end
		+ case when isnumeric(toolingcharge)=1 then toolingcharge else 0 end)as toolingcost,
		price1 + case when price2<>'' then ';'+price2 else '' end +
		case when price3<>'' then ';'+price3 else '' end +
		case when price4<>'' then ';'+price4 else '' end +
		case when price5<>'' then ';'+price5 else '' end as priceUSD
		,rtrim(ltrim(remark)) as remarks,uid,dom,getdate(),programme
		from sgp_data where programme=@programme and id=@gpid and isnumeric(price1)=1

		if @@ROWCOUNT=1
		insert into sgp_addtovi (gpid,programme) values (@gpid,@programme)
		
		select @message = 'Programme '+ @programme +' has been exported to VI successfully'
	end
	else
		select @message = 'Are you sure you want to export programme ' +@programme +' data to VI ?'


select top 1 requestor,customer,segment,rfq,email, isnull(gam,'') as gam
from HKGNT105.multek.dbo.tVI4 join HKGNT105.multek.dbo.tVI_ACL on requestor=name where rfq=@programme

end
else
	select '' as requestor,'' as customer,'' as segment,'' as rfq,'' as email,'' as gam where 1=0
GO

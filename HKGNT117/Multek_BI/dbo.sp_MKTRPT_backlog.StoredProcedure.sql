USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_MKTRPT_backlog]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE procedure [dbo].[sp_MKTRPT_backlog]
@site char(2),
@sysuid int,
@OEM varchar(100)='',
@CEM varchar(100)='',
@project nvarchar(10)='',
@cust_part_no nvarchar(50)='',
@warehouse        nvarchar(10)='',
@deliver          nvarchar(10)='',
@cust_po          nvarchar(50)='',
@order_type       nvarchar(50)='',
@Baan_SO          nvarchar(15)='',
@ast_so           nvarchar(50)='',
@cust_code        nvarchar(50)='',
@startDate int = 0,
@endDate int = 0,
@totalOrderQty int output,
@totalBacklogQty int output,
@totalBacklogSqft bigint output,
@totalBacklogAmt bigint output
,@limitQty int = 0 output
,@sort nvarchar(100) = ''
,@pdname nvarchar(50)=''
,@plant nvarchar(10) = ''


as
declare @sqlstr varchar(max)
declare @afterSql varchar(100)
set nocount on

select * into #tmp from dbo.vMKT_backlog_cn where 1=0
/*disabled on 20121113
沒有巴西
select * into #tmp from 
(select top 1 * from dbo.vMKT_backlog_cn
union all select top 1 * from dbo.vMKT_backlog_de ) as x 
truncate table #tmp
*/
/*
select * into #tmp from 
(select top 1 * from dbo.vMKT_backlog_cn
union all select top 1 * from dbo.vMKT_backlog_br
union all select top 1 * from dbo.vMKT_backlog_de ) as x 
truncate table #tmp
*/

declare @isSa bit, @isPV bit, @isAC bit
set @limitQty = 1000
exec sp_MKTGAM_getRight @sysuid,@isSa output,@isPV output ,@isAC output,@limitQty output

--max 5K record downloaded.
set @sqlstr = 'insert into #tmp select top '+convert(varchar(10),@limitQty)+' a.* from '
set @afterSql = ''
if(@site <> '')
	set @sqlstr = @sqlstr +' dbo.vMKT_backlog_'+ @site +' as a '
if(@site <> 'cn')
	set @plant =''


if(@isAC=0)
	set @sqlstr = @sqlstr + ' where 1=0'
else
begin
	if(@isSa=1)
		set @sqlstr = @sqlstr +' join multek_bi.dbo.fx_getSalesForMKTRPT('+ convert(varchar(40),@sysuid)+') as b on a.oem_name=b.oemname and a.plant=b.plant '
/*duplicate found in below statement.
		set @sqlstr = @sqlstr +' join multek_bi.dbo.vMKT_salesman_OEM as b on a.oem_name = b.oemName and a.plant=b.plant '+
			'join multek_bi.dbo.fx_getSalesByManager('+convert(varchar(4),@sysuid)+') as sb on b.salesmanid=sb.sysUserId '
*/
/*		set @sqlstr = @sqlstr +' join multek_bi.dbo.vw_gam_OEMcomb as b on a.oem_name = b.oemName and a.plant=b.plant '+
			'join multek_bi.dbo.fx_getSalesByManager('+convert(varchar(4),@sysuid)+') as sb on  (b.salesmanid=sb.sysUserId or b.viewsalesmanid=sb.sysUserId) '
*/
	if(@isPV=0)
		set @afterSql = 'update #tmp set unitprice=0,bklog_amt_us=0'
	set @sqlstr = @sqlstr +' where 1=1 '+
	dbo.fx_fieldLikeValue('plant',@plant) +
	dbo.fx_fieldLikeValue('oem_name',@oem) +
	dbo.fx_fieldLikeValue('cem_name',@cem) +
	dbo.fx_fieldLikeValue('prj_no',@project) +
	dbo.fx_fieldLikeValue('part_no',@cust_part_no) +
	dbo.fx_fieldLikeValue('warehouse',@warehouse) +
	dbo.fx_fieldLikeValue('del_code',@deliver) +
	dbo.fx_fieldLikeValue('po_no',@cust_po) +
	dbo.fx_fieldLikeValue('order_type',@order_type) +
	dbo.fx_fieldLikeValue('baan_so',@Baan_SO) +
	dbo.fx_fieldLikeValue('ast_so',@ast_so) +
	dbo.fx_fieldLikeValue('cust_code',@cust_code) +
	dbo.fx_fieldLikeValue('product_name',@pdname)
	if(@startDate >0 and @endDate > 0)
		set @sqlstr = @sqlstr +' and iDate between '+ convert(varchar(8),@startDate) +' and '+ convert(varchar(8),@endDate)
	else
	begin
		if(@startDate > 0)
			set @sqlstr = @sqlstr + ' AND iDate >= '+ convert(varchar(8),@startDate)
		if(@endDate > 0)
			set @sqlstr = @sqlstr + ' and iDate <= '+ convert(varchar(8),@endDate)
	end
end

execute(@sqlstr + @sort) 
if  @afterSql <> ''
	execute(@afterSql) 

select @totalOrderQty = isnull(sum(order_qty),0),@totalBacklogQty=isnull(sum(bklog_qty),0),
 @totalBacklogAmt = round(isnull(sum(bklog_amt_us),0),0),@totalBacklogSqft=round(isnull(sum(bklog_sqft),0),0) from #tmp
select * from #tmp
drop table #tmp
set nocount off













GO

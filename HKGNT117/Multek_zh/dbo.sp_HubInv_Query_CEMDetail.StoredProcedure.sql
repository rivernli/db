USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_Query_CEMDetail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_HubInv_Query_CEMDetail]
@date int,
@OEM nvarchar(100),
@isOEM tinyint = 1,
@isQty bit = 1
as
if(@isQty=0)
begin
	if(@isOEM = 1)--OEM
	begin
		select CEM,round(sum(amount),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and OEM = @OEM group by CEM order by sum(amount) desc
	end
	if(@isOEM=2)--plant
	begin
		select CEM,round(sum(amount),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and plant = @OEM group by CEM order by sum(amount) desc
	end
	if(@isOEM=3)--CEM
	begin
		select l.location,round(sum(amount),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and CEM = @OEM group by l.location order by sum(amount) desc
	end
	if(@isOEM=4)--OEM+CEM
	begin
		select l.location,round(sum(amount),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and rtrim(isnull(OEM,''))+ '|' + rtrim(isnull(CEM,'')) = @OEM 
		group by l.location order by sum(amount) desc
	end
	if(@isOEM=5)--CEM+OEM
	begin
		select l.location,round(sum(amount),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) = @OEM 
		group by l.location order by sum(amount) desc
	end
	if(@isOEM=6)--CEM+location
	begin

		select OEM,round(sum(amount),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(l.location,'')) = @OEM 
		group by OEM order by sum(amount) desc
	end
end
else
begin
	if(@isOEM = 1)--OEM
	begin
		select CEM,round(sum(qty),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and OEM = @OEM group by CEM order by sum(qty) desc
	end
	if(@isOEM=2)--plant
	begin
		select CEM,round(sum(qty),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and plant = @OEM group by CEM order by sum(qty) desc
	end
	if(@isOEM=3)--CEM
	begin
		select l.location,round(sum(qty),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and CEM = @OEM group by l.location order by sum(qty) desc
	end
	if(@isOEM=4)--OEM+CEM
	begin
		select l.location,round(sum(qty),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and rtrim(isnull(OEM,''))+ '|' + rtrim(isnull(CEM,'')) = @OEM 
		group by l.location order by sum(qty) desc
	end
	if(@isOEM=5)--CEM+OEM
	begin
		select l.location,round(sum(qty),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) = @OEM 
		group by l.location order by sum(amount) desc
	end
	if(@isOEM=6)--CEM+location
	begin
		select OEM,round(sum(qty),0) as amt from 
		dbo.vw_4RP_HubInv as h left join dbo.hubInventoryCEMLocation as l on cust_code = customer_code
		where iDate = @date and rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(l.location,'')) = @OEM 
		group by OEM order by sum(amount) desc
	end
end






GO

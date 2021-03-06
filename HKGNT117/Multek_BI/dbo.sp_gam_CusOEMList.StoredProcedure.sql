USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_CusOEMList]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_CusOEMList]
@key nvarchar(100) = '',
@sales nvarchar(50) = '',
@salesId int = 0,
@isValid int = -1
as

if( @salesId > 0)
	if(@isvalid >=0)
		select * from vw_gam_oemcomb where salesmanId=@salesId and isValid=@isValid
	else
		select * from vw_gam_oemcomb where salesmanId=@salesId
else
begin
	select * into #oem from vw_gam_oemcomb where oemid=0
	if(@key <> '')
	begin
		insert into #oem select * from vw_gam_oemcomb where cusoem like '%'+@key +'%' or OEMName like '%'+ @key +'%' or GroupName = @key
	end
	else
		insert into #oem select * from vw_gam_oemcomb

	if(@isValid>=0)
		delete #oem where isValid <> @isValid

	if(@sales <> '')
		select * from #oem where userName=@sales or vname=@sales order by cusOEM
	else
		select * from #oem order by cusOEM

	drop table #oem
end




GO

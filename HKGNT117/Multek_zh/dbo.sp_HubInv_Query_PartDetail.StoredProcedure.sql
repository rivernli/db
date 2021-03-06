USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_Query_PartDetail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_HubInv_Query_PartDetail]
@date int,
@OEM nvarchar(100),
@isOEM tinyint = 1,
@isQty bit = 1
as
if(@isQty=0)
begin
	if(@isOEM = 1)--OEM
	begin
		select partNumber,round(sum(amount),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and OEM = @OEM group by partNumber order by sum(amount) desc
	end
	if(@isOEM=2)--plant
	begin
		select partNumber,round(sum(amount),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and plant = @OEM group by partNumber order by sum(amount) desc
	end
	if(@isOEM=3)--CEM
	begin
		select partNumber,round(sum(amount),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and CEM = @OEM group by partNumber order by sum(amount) desc
	end
	if(@isOEM=4)--OEM+CEM
	begin
		select partNumber,round(sum(amount),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and rtrim(isnull(OEM,''))+ '|' + rtrim(isnull(CEM,'')) = @OEM group by partNumber order by sum(amount) desc
	end
end
else
begin
	if(@isOEM = 1)--OEM
	begin
		select partNumber,round(sum(qty),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and OEM = @OEM group by partNumber order by sum(qty) desc
	end
	if(@isOEM=2)--plant
	begin
		select partNumber,round(sum(qty),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and plant = @OEM group by partNumber order by sum(qty) desc
	end
	if(@isOEM=3)--CEM
	begin
		select partNumber,round(sum(qty),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and CEM = @OEM group by partNumber order by sum(qty) desc
	end
	if(@isOEM=4)--OEM+CEM
	begin
		select partNumber,round(sum(qty),0) as amt from dbo.vw_4RP_HubInv
		where iDate = @date and rtrim(isnull(OEM,''))+ '|' + rtrim(isnull(CEM,'')) = @OEM group by partNumber order by sum(qty) desc
	end
end



GO

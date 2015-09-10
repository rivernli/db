USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInventoryDetailReport]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_HubInventoryDetailReport]
  @oem nvarchar(50),
  @proj nvarchar(50),
  @cusPartNo nvarchar(50),
  @warehouse nvarchar(10),
	@delveryCode nvarchar(10),
	@customerPO nvarchar(100),
	@customerCode nvarchar(100),
	@crfCode nvarchar(10),
@startDate int,
@endDate int
as
declare @sqlstr nvarchar(4000);

set @sqlstr = 'select * from dbo.vw_4RP_HubInventoryForMkt where 1=1 '+
dbo.fx_fieldLikeValue('oem',@oem) + 
dbo.fx_fieldLikeValue('partNumber',@proj) +
dbo.fx_fieldLikeValue('customerPartNo',@cusPartNo) +
dbo.fx_fieldLikeValue('warehouse',@warehouse) +
dbo.fx_fieldLikeValue('delCode',@delveryCode) +
dbo.fx_fieldLikeValue('customerPO',@customerPO) +
dbo.fx_fieldLikeValue('customerCode',@customerCode) +
dbo.fx_fieldLikeValue('crfCode',@crfCode)
if(@startDate >0 and @endDate > 0)
	set @sqlstr = @sqlstr +' and iDate between '+ convert(varchar(8),@startDate) +' and '+ convert(varchar(8),@endDate)
else
begin
	if(@startDate > 0)
		set @sqlstr = @sqlstr + ' AND iDate >= '+ convert(varchar(8),@startDate)
	if(@endDate > 0)
		set @sqlstr = @sqlstr + ' and iDate <= '+ convert(varchar(8),@endDate)
end

execute(@sqlstr) 


GO

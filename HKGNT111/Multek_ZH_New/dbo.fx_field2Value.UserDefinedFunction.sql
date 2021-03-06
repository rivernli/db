USE [Multek_ZH_New]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_field2Value]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fx_field2Value](@key nvarchar(50),@field nvarchar(50),@isExact bit = 0)
returns nvarchar(255)
as
begin 
declare @sql nvarchar(255)

if dbo.fx_trim(@key) <> ''
	if(@isExact=1)
		set @sql = ' and ' + dbo.fx_trim(@field) +' = N''' + dbo.fx_trim(@key) +''' '
	else
		set @sql = ' and ' + dbo.fx_trim(@field) +' like N''%' + dbo.fx_trim(@key) +'%'' '
else
	set @sql = ''

return @sql
end
GO

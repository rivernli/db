USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_AIS_CoA_jsExact]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[fx_AIS_CoA_jsExact]
(
@key nvarchar(50),
@field nvarchar(500),
@isExact bit = 0)
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

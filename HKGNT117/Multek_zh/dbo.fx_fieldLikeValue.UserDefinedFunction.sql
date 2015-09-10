USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_fieldLikeValue]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fx_fieldLikeValue](@field nvarchar(50),@value nvarchar(100))
returns nvarchar(255)
as
begin 
declare @sql nvarchar(255)

if dbo.fx_trim(@value) <> ''
	set @sql = ' and ' + dbo.fx_trim(@field) +' like N''%' + dbo.fx_trim(@value) +'%'' '
else
	set @sql = ''

return @sql
end 

	
	
GO

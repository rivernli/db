USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getMaterialType]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fx_getMaterialType](@id int)
returns nvarchar(100)
as
begin 
	declare @q nvarchar(100);
	set @q=''
	select @q= case @id
		when 0 then ''
		when 1 then 'non-production'
		when 2 then 'production'

		end
	return @q;
end	




GO

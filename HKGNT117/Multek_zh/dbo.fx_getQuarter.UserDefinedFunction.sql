USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getQuarter]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[fx_getQuarter](@iDate datetime)
returns int
as
begin 
	declare @q int;
	declare @m int;
	set @m = month(@iDate);
/*
	select @q= case @m
		case when @m between 1 and 3 then 1 else 
		case when @m between 4 and 6 then 2 else
		case when @m between 7 and 9 then 3 else
		4 end
		end end
*/

	select @q= case @m
		when 1 then 1  
		when 2 then 1  
		when 3 then 1  
		when 4 then 2 
		when 5 then 2  
		when 6 then 2  
		when 7 then 3 
		when 8 then 3  
		when 9 then 3
		else 4 end
	return @q;
end	


GO

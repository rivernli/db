USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getQuarterByPeriod]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fx_getQuarterByPeriod](@period int)
returns int
as
begin 
	declare @q int;

	select @q= case @period
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

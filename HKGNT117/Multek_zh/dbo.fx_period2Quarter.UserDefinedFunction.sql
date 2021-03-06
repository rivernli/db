USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_period2Quarter]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fx_period2Quarter](@period int)
returns int
as
begin 
	declare @q int,@n nvarchar(6)
	select @n=cast(@period as varchar(6)), @q=0
	if(@period >= 100000 and @period <= 999999)
	begin
		(select @q=case when q >4 then 0 else fy +q end from 
			(select (substring(@n,1,4) * 100) as fy,(substring(@n,5,2)-1)/3 +1 as q) as x)
	end
	return @q
end	



GO

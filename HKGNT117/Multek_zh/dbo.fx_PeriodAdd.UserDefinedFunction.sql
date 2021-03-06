USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_PeriodAdd]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create  function [dbo].[fx_PeriodAdd](@period int,@addP int)
returns int
as 
begin 
/*
declare @period int,@addP int
select @period=201405,@addP=1
*/
select @period=left(@period,6)
declare @y int,@p int
select @y = left(@period,4),@p=right(@period,2)
if(@p + @addP > 12)
	select @y=@y+1, @p=(@p+@addP)-12
else
begin
	if(@p + @addP < 1)
		select @y=@y-1, @p=(@p+@addP)+12
	else
		select @p=@p+@addP
end
while(@p < 1 or @p >12)
begin
	if(@p > 12)
		select @y=@y+1,@p=@p-12
	else
		select @y=@y-1,@p=@p+12
end
return @y*100+@p
end
GO

USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getAddPeriod]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create  function [dbo].[fx_getAddPeriod](@period int,@addPeriod int)
returns int
as 
begin 

declare @y int
declare @p int
set @y=0
select top 1 @p=fiscalPeriod,@y=fiscalYear from dbo.vw_Calender_ext where iperiod = @period
if(@y > 0)
begin
	set @p = @p+@addPeriod
	while(@p > 12)
	begin
		select @y=@y+1,@p=@p-12
	end
	while(@p <=0)
	begin
		select @y=@y-1, @p=@p+12
	end
	select @period = @y*100 + @p
end 
return @period

end

GO

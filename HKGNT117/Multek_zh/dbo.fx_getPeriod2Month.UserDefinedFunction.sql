USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getPeriod2Month]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create  function [dbo].[fx_getPeriod2Month](@period int)
returns datetime
as 
begin 
/*
declare @d datetime
select @d= convert(datetime,cast( multek_zh.dbo.fx_getAddPeriod(@period,-9) as varchar(6)) +'01')
return @d*/
return (select convert(datetime,cast( multek_zh.dbo.fx_getAddPeriod(@period,-9) as varchar(6)) +'01'))
end

GO

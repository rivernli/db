USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_week_day]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Loading_get_week_day](@period int)
returns int
as
begin
	declare @no_of_Project int
	declare @fweek int						--Fiscal Week
	
	if @period  = 1 or @period  = 4 or @period  = 7 or @period  = 10
			set @fweek = 5
	else
			set @fweek = 4

	return @fweek
end
GO

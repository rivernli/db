USE [Multek_ZH_New]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_plant2Number]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fx_plant2Number](@plant nchar(5))
returns int
as
begin 
	declare @q int;
/*
(0)=HK(VVI)
(1)=B1
(2)=B2F
(3)=B3
(4)=B4
(5)=B5
*/
	select @q= case @plant
		when 'hk' then 0
		when 'vvi' then 0
		when 'B1' then 1  
		when 'B2' then 2 
		when 'B2F' then 2  
		when 'B3' then 3
		when 'B4' then 4
		when 'B5' then 5
		else -1 end
		
	return @q;
end
GO

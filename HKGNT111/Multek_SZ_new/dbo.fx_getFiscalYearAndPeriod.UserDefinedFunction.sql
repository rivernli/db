USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getFiscalYearAndPeriod]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fx_getFiscalYearAndPeriod](@fiscalYear int,@FiscalPeriod int)
returns int
as
begin 
	return (@fiscalYear * 100) + @FiscalPeriod
end
GO

USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getFiscalYearAndPeriod]    Script Date: 2014/11/12 17:12:18 ******/
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

USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_currentPeriodAdd]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_currentPeriodAdd](@addNumber int)
as
select multek_zh.dbo.fx_getAddPeriod(multek_zh.dbo.fx_getCurrentPeriod(),@addNumber)


GO

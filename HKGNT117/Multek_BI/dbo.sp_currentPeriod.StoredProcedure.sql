USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_currentPeriod]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_currentPeriod]
as
select multek_zh.[dbo].[fx_getPeriodDate](default)
GO

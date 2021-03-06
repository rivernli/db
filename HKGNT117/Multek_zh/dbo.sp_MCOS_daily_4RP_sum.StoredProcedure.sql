USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MCOS_daily_4RP_sum]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_MCOS_daily_4RP_sum]

as
set nocount on

if exists (select 1 from sysobjects where name = 'MCOS_daily_4RP_MaterialSum')
	drop table MCOS_daily_4RP_MaterialSum
if exists (select 1 from sysobjects where name = 'MCOS_daily_4RP_RevenueSum') 
	drop table MCOS_daily_4RP_RevenueSum

select * into MCOS_daily_4RP_MaterialSum from dbo.vw_4RP_MaterialSum

select * into MCOS_daily_4RP_RevenueSum from dbo.vw_4RP_RevenueSum

set nocount off

GO

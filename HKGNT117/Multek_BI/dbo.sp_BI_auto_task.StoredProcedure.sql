USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_BI_auto_task]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_BI_auto_task]
as
exec multek_bi_cst.dbo.sp_FC_auto_log
exec dbo.sp_gam_AutoUpdate_from_Shipment_Backlog
exec multek_zh.dbo.sp_MCOS_daily_4RP_sum

GO

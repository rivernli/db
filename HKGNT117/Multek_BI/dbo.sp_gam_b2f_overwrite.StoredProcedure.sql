USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_b2f_overwrite]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_gam_b2f_overwrite]
as
declare @currPeriod int
select @currPeriod=multek_zh.dbo.fx_getCurrentPeriod()
delete gam_b2f where uploadperiod=@currPeriod

GO

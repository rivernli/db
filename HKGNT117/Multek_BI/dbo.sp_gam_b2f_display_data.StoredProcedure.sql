USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_b2f_display_data]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_b2f_display_data](@period int=0)
as
set nocount on
if(@period =0)
select @period=multek_zh.dbo.fx_getCurrentPeriod()

select * from gam_b2f where uploadPeriod=@period order by id
set nocount off


GO

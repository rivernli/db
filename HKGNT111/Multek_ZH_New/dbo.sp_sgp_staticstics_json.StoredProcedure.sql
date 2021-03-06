USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_sgp_staticstics_json]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec sp_sgp_staticstics
CREATE procedure [dbo].[sp_sgp_staticstics_json]
as
set nocount on
declare @total int, @a int,@b int, @ap decimal(8,2), @bp decimal(8,2),@cp decimal(8,2)
declare @msg nvarchar(max);

select @total=count(priced) from vw_sgp_QuoteCostPricing where status <2
select @a=count(priced) from vw_sgp_QuoteCostPricing where status <2 and priced=1

select @ap=convert(float,@a)/@total * 100.0, @bp=100-@ap
select @msg= '{statistics:{pricing:{Priced:{p:'+ convert(nvarchar(10),@ap)+',c:'+ 
convert(nvarchar(30),@a)+'},New:{p:'+ convert(nvarchar(10),@bp) +',c:'+ convert(nvarchar(30),@total-@a) +'}}'

select @total=count(wfstatus) from dbo.vw_SGP_WorkflowStatus 
select @a=count(wfstatus) from dbo.vw_SGP_WorkflowStatus where wfstatus=0
select @b=count(wfstatus) from dbo.vw_SGP_WorkflowStatus where wfstatus=1
select @ap=convert(float,@a)/@total * 100.0, @bp=convert(float,@b)/@total * 100.0,@cp = 100- (@ap+@bp)
select @msg +',workflow:{InProgress:{p:'+ convert(nvarchar(10),@ap)+',c:'+ convert(nvarchar(30),@a)+
'},Approved:{p:'+ convert(nvarchar(10),@bp) +',c:'+ convert(nvarchar(30),@b) +
'},Rejected:{p:'+ convert(nvarchar(10),@cp) +',c:'+ convert(nvarchar(30),@total - @a-@b) +'}}}}' as json

set nocount off
GO

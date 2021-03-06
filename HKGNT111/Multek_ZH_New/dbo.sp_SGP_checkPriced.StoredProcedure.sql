USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_checkPriced]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_checkPriced] @salesman nvarchar(50)='',@rfq nvarchar(50)='', @project nvarchar(50)='',
@priced tinyint=2
as
set nocount on

declare @sqlstr nvarchar(4000) 
select @sqlstr = 'select top 500 * from vw_SGP_pricing_simAll where costid > 0 and status < 2 '
+ dbo.fx_field2Value(case when @priced=2 then '' else cast(@priced as char(1)) end,'priced',0) 
+ dbo.fx_field2Value(@salesman,'salesman',0) +
+ dbo.fx_field2Value(@project,'project',0) +
+ dbo.fx_field2Value(@rfq,'rfq',0) +
' order by gpid desc'
exec(@sqlstr)
set nocount off
GO

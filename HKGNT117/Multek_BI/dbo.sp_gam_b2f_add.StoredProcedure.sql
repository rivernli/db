USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_b2f_add]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_b2f_add] @fcPeriod int,@sales nvarchar(50), @oem nvarchar(50),@cpn nvarchar(50),@pn nvarchar(50),
@sqft float,@qty int, @array float, @smt float, @fpc float, @bom float
as

declare @currPeriod int
select @currPeriod=multek_zh.dbo.fx_getCurrentPeriod()
if (@fcperiod > @currPeriod)
 insert into gam_b2f (uploadPeriod,sales,forecastPeriod,oem,cpn,pn,sqft,qty,array,smtprice,fpcprice,bomprice)
 values (@currPeriod,@sales,@fcperiod,@oem,@cpn,@pn,@sqft,@qty,@array,@smt,@fpc,@bom)


GO

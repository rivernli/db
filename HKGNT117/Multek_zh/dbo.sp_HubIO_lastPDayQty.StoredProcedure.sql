USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubIO_lastPDayQty]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_HubIO_lastPDayQty]
@inputTime int,@byTimeLine int,
@lastdate int output, @qty int output

as

select @lastdate=[dbo].[fx_getLastDate](@inputTime,@byTimeLine)
select @qty=isnull(round(sum(qty),0),0) from vw_4RP_HubInvExt where iDate=@lastdate



GO

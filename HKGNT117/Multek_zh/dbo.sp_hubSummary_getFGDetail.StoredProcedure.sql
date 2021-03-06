USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_hubSummary_getFGDetail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_hubSummary_getFGDetail] 
@idate int,@oem nvarchar(100)='', @plant nvarchar(10) =''
as
declare @iperiod int
select @iperiod=iperiod from dbo.vw_Calender_ext where idate = @idate
if(@oem<>'' and @plant<>'')
	select T$ECDT as oem ,T$plnt as plant,t$item as item,sum(fg_avaible) as fg_ava,sum(t$amnt) as amt 
	from vw_4RP_HubBacklog_ext where T$ECDT = @oem and T$plnt =@plant and iperiod=@iperiod
	group by T$ECDT,T$plnt,t$item order by T$ECDT,T$plnt,t$item
else
	select T$ECDT as oem ,T$plnt as plant,t$item as item,sum(fg_avaible) as fg_ava,sum(t$amnt) as amt 
	from vw_4RP_HubBacklog_ext where iperiod=@iperiod
	group by T$ECDT,T$plnt,t$item order by T$ECDT,T$plnt,t$item



GO

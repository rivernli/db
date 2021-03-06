USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_hubSummary_getHubIN]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_hubSummary_getHubIN]
@idate int,@oem nvarchar(100)='', @plant nvarchar(10) =''
as
declare @iperiod int
select @iperiod=iperiod from dbo.vw_Calender_ext where idate = @idate
if(@oem<>'' and @plant<>'')
	select oem,plant,partNumber,sum(amount) as amt from  vw_4RP_HubIn_extDate 
	where iperiod=@iperiod and oem=@oem and plant=@plant group by oem,plant,partNumber order by oem,plant,partnumber
else
	select oem,plant,partNumber,sum(amount) as amt from  vw_4RP_HubIn_extDate 
	where iperiod=@iperiod group by oem,plant,partNumber order by oem,plant,partnumber

GO

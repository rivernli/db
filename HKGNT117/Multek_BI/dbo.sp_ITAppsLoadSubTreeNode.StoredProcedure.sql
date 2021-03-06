USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsLoadSubTreeNode]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_ITAppsLoadSubTreeNode]

@parentAppId int
as
select appcnt.cnt as subAppsCount,itapps.appId,appName,description,author,support,isActive,sortPos,url,lastUpDate,createDate,isApp
from itapps join 
(
	select i1.appid,count(i2.appid) as cnt from itapps as i1 left join itapps as i2 on i1.appid=i2.parentappid
	where i1.parentAppId=@parentAppId group by i1.appid
) as appcnt on itapps.appid = appcnt.appid

order by sortPos
GO

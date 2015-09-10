USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_salesmanGet]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_salesmanGet] @managerId int=0, @salesmanId int=0
as

if(@salesmanId > 0)
	select * from dbo.GAM_USERS where sysUserId=@salesmanId and isSales=1 
else
	select * from dbo.GAM_USERS where isSales=1 and managerId=@managerId order by userName


GO

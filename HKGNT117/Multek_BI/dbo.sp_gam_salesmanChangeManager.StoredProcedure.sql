USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_salesmanChangeManager]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[sp_gam_salesmanChangeManager]
@managerId int,@sysId int
as
	if exists(select 1 from GAM_USERS where sysUserId=@managerId and isSales=1) and @managerId > 0
		update GAM_USERS set managerId=@managerId where sysUserId=@sysId
	if @managerId =0
		update GAM_USERS set managerId=0 where sysUserId=@sysId






GO

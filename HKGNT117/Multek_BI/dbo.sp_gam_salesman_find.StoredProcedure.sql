USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_salesman_find]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[sp_gam_salesman_find]
@key nvarchar(50) = '',
@salesOnly bit = 0
as

if(@salesOnly = 1)
	select top 50 sysUserId,uid,domain,userName,emailAddress,isActive 
	from dbo.GAM_USERS where 
	isSales=1 and isAdmin=0 and isActive=1
	and (userName like '%'+@key+'%')
else
	select top 50 sysUserId,uid,domain,userName,emailAddress,isActive 
	from dbo.GAM_USERS
	where userName like '%'+@key+'%' and isActive=1
	--or userName like '%'+@key+'%'




GO

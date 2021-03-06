USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_BaanOEMGroupList]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_BaanOEMGroupList]
as 

select groupName,groupName+' ('+cast(num as varchar(2))+')' as gn from (
select isnull(groupName,'') as groupName,count(groupName) as num from gam_baanoemlist 
group by isnull(groupName,'')
) as tmp
order by groupName
GO

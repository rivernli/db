USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsSearch_bk]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
declare @keywords nvarchar(1000)
set @keywords = 'hub out reports'
*/
create procedure [dbo].[sp_ITAppsSearch_bk] @keywords nvarchar(1000)

as 
IF object_id('tempdb..#appSearch') IS NOT NULL
	drop table #appSearch
IF object_id('tempdb..#tpk') IS NOT NULL
	drop table #tpk


create table #appSearch 
([aId] [int] NOT NULL,[title] [nvarchar](50) NOT NULL,[isKeyword] tinyint default 1)

select * into #tpK from dbo.fx_Split(@keywords,' ')

insert into #appSearch (aid,title,iskeyword)
select appid,appName,1 from itapps where appName = @keywords

if (select count(*) from #appSearch) =0 and (select count(*) from #tpK) > 1
	insert into #appSearch (aid,title,iskeyword)
	select appid,appName,2 from itapps where appName like @keywords+'%' or @keywords like appName+'%'
	
insert into #appSearch (aid,title,iskeyword)
select ak.app_id,keyword,3 from ITAppsKeywords as k join
#tpk as b on k.keyword = b.item join ITAppsJoinKeywords as ak on k.keyId=ak.key_id
where app_id not in (select aid from #appSearch)

/*
insert into #appSearch (aid,title,iskeyword)
select ak.app_id,keyword,4 from ITAppsKeywords as k join 
#tpK as b on k.keyword like b.item +'%' and k.keyword <> b.item
join ITAppsJoinKeywords as ak on k.keyId=ak.key_id
*/
insert into #appSearch (aid,title,iskeyword)
select ak.app_id,keyword,4 from ITAppsKeywords as k join 
#tpK as b on k.keyword like b.item +'%'
join ITAppsJoinKeywords as ak on k.keyId=ak.key_id
where app_id not in (select aid from #appSearch)


select counter,sorting,itapps.* from(
select aid,count(aid) as counter,min(isKeyword) as sorting from #appSearch group by aid
) as op join itapps on aid = appId
where url <> '' and isActive=1
 order by sorting,counter,sortPos desc,appId 

drop table #appSearch
drop table #tpK







GO

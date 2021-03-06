USE [BOC]
GO
/****** Object:  View [dbo].[Period_loading]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select T$plnt,T$year,T$dats,T$prno,T$bitm1,T$pcon1 from tfsboc108180
--where tfsboc108180.T$ooem = 'Total'
--order by T$plnt
CREATE view [dbo].[Period_loading]
as
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm1 as T$bitm,round(tfsboc108180.T$pcon1/100,4) as T$pcon
from tfsboc004180 left join tfsboc108180 on tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
where tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm1 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm2 as T$bitm,round(tfsboc108180.T$pcon2/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm2 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm3 as T$bitm,round(tfsboc108180.T$pcon3/100,4) as T$pcon 
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm3 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm4 as T$bitm,round(tfsboc108180.T$pcon4/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm4 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm5 as T$bitm,round(tfsboc108180.T$pcon5/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm5 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm6 as T$bitm,round(tfsboc108180.T$pcon6/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm6 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm7 as T$bitm,round(tfsboc108180.T$pcon7/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm7 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm8 as T$bitm,round(tfsboc108180.T$pcon8/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm8 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm9 as T$bitm,round(tfsboc108180.T$pcon9/100,4) as T$pcon 
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm9 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm10 as T$bitm,round(tfsboc108180.T$pcon10/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm10 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm11 as T$bitm,round(tfsboc108180.T$pcon11/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm11 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm12 as T$bitm,round(tfsboc108180.T$pcon12/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm12 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm13 as T$bitm,round(tfsboc108180.T$pcon13/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm13 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm14 as T$bitm,round(tfsboc108180.T$pcon14/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm14 = tfsboc004180.T$bitm

union all 
select tfsboc108180.T$plnt,tfsboc108180.T$year,tfsboc108180.T$prno,tfsboc108180.T$dats,tfsboc108180.T$bitm15 as T$bitm,round(tfsboc108180.T$pcon15/100,4) as T$pcon
from tfsboc004180 , tfsboc108180 
where tfsboc108180.T$plnt = tfsboc004180.T$plant and tfsboc108180.T$year = tfsboc004180.T$year 
and tfsboc108180.T$prno = tfsboc004180.T$prno
and	tfsboc004180.T$efft = 1
and tfsboc108180.T$ooem = 'Total'
and tfsboc108180.T$bitm15 = tfsboc004180.T$bitm
--order by tfsboc108180.T$plnt
GO

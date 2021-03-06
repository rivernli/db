USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_currency_rate]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_currency_rate]
as
select b.T$CCUR as currency,T$RATS as rate,T$STDT as last_update
  from TTCMCS008180 as a right join 
(select t$ccur,max(t$stdt) as d from TTCMCS008180 group by t$ccur) as b
on a.t$ccur=b.t$ccur and a.t$stdt=b.d

GO

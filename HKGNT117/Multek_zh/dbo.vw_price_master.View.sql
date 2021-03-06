USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_price_master]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_price_master]
as

select T$CUNO, T$ITEM,T$CNTR,T$DILE,T$QANP,T$STDT,T$TDAT,T$PRIC,T$DISC,T$DAMT,T$CDIS,T$GNPR,T$VERS,T$USED,T$TYPE,T$STAT,T$FILE,T$RSCD,T$REFCNTD,T$REFCNTU,T$CCUR,currency,rate,last_update,
t$pric*rate as usdPrice
from vw_TTDSLS030 as a left join vw_currency_rate as b on a.t$ccur=b.currency



GO

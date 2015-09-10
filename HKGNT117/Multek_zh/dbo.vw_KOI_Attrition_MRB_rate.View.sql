USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_KOI_Attrition_MRB_rate]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_KOI_Attrition_MRB_rate]
as

SELECT T$PLNT, T$IQTY, T$OQTY, '0' as T$MCOS,'0' as T$AMNT, T$DATE 
FROM tfsolp144180
UNION all
select T$PLNT, '0' as T$IQTY,'0' as T$OQTY, T$MCOS, T$AMNT, T$DATE
from vw_KOI_MRB_rate 
GO

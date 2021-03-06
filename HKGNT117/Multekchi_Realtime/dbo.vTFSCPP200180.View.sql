USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSCPP200180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE view [dbo].[vTFSCPP200180]
as
select ltrim(rtrim(T$PFIX))+ltrim(rtrim(T$PITM))+ltrim(rtrim(T$PVER)) as T$PROJ,
		T$ITEM,
	case T$OTYP
	when    '0' then ''
	when	'1' then 'J-Order'
	when	'2' then 'Normal Order'
	end  as T$OTYP,T$PRDN
from dbo.TFSCPP200180_link

GO

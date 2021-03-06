USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSOLP101180_temp]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTFSOLP101180_temp]
AS
SELECT
	a.T$ORNO,
	T$PONO,
	T$SRNB,
	T$BAD1,
	T$BAD2,
	T$COBA,
	A.T$CUNO,
	T$CUNM,
	a.T$ITEM,
	T$CUPN,
	T$CWAR,
	T$EONO,
	T$TTYP,
	T$INVN,
	T$INVD,
--		T$PODT = LEFT(T$PODT,2)+ '/' +RIGHT(LEFT(T$PODT,4),2)+ '/' +RIGHT(T$PODT,4),
		T$PODT,
--		T$RQDT=  LEFT(T$RQDT,2)+ '/' +RIGHT(LEFT(T$RQDT,4),2)+ '/' +RIGHT(T$RQDT,4),
		T$RQDT,
		T$DQUA,
		CAST(T$PRIC AS decimal(15, 4)) AS T$PRIC,
--		T$PRIC,
		T$CCUR,
		CAST(T$AMNT AS decimal(15, 4)) AS T$AMNT,
--		T$AMNT,
		CAST(T$AREA AS decimal(15, 4)) AS T$AREA,
--		T$AREA,
		T$REFA,
		T$ENDC,
		T$CODA,
		T$NAMA,
		T$CSCO,
		T$USNM,
		T$SEGM,
		T$COTP,
		T$CDSC,
--		T$SalesType,
		a.T$STYP,
		T$FIDS,
		T$PSPL,
		case 
			when len(rtrim(ltrim(a.T$ITEM))) < 9  then  a.T$PRDN
			when len(rtrim(ltrim(a.T$ITEM))) > 9  then  c.T$PRDN
		end as T$PRDN,
		T$FLEX,
		a.T$ISEG,
		T$DESC,
		b.T$CDEL,
		c.T$OTYP
	FROM	TFSOLP101180 a left join TFSDELCOD180 b
	on   a.T$ORNO = b.T$ORNO  left join vTFSCPP200180  c on a.T$ITEM = c.T$ITEM

GO

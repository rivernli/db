USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSOLP100180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vTFSOLP100180]
AS
SELECT	
--		CAST(T$ORNO AS [float]) AS  T$ORNO,
	             a.T$ORNO,
--		CAST(T$PONO AS [float]) AS  T$PONO,
		a.T$PONO,
                           T$BAD1,
		T$BAD2,
		T$COBA,
		a.T$CUNO,
		T$CUNM,
		T$CWAR,
		T$REFA,
		T$EONO,
		a.T$ITEM,
		T$CUPN,
--		T$PODT=LEFT(T$PODT,2)+ '/' +RIGHT(LEFT(T$PODT,4),2)+'/'+RIGHT(T$PODT,4),
		T$PODT,
--		T$DDTA=LEFT(T$DDTA,2)+ '/' +RIGHT(LEFT(T$DDTA,4),2)+'/'+RIGHT(T$DDTA,4),
		T$DDTA,
--		T$RQDT=LEFT(T$RQDT,2)+ '/' +RIGHT(LEFT(T$RQDT,4),2) +'/'+RIGHT(T$RQDT,4),
		T$RQDT,
		T$OQUA,
		T$BQUA,
		T$CCUR,
		CAST(T$PRIC AS decimal(15, 4)) AS T$PRIC,
--		T$PRIC,
		CAST(T$AMNT AS decimal(15, 4)) AS T$AMNT,
--		T$AMNT,
		CAST(T$AREA AS decimal(15, 4)) AS T$AREA,
--		T$AREA,
		T$ECDT,
		T$ADDR,
		T$NAMA,
		T$CSCO,
		T$USNM,
		T$SEGM,
		T$CDSC,
		T$COTP,
		T$STAT,
		a.T$STYP,
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
	FROM	TFSOLP100180 a left join HKGNT137.MultekChi_RealTime.dbo.TFSDELCOD180 b
	on   a.T$ORNO = b.T$ORNO  and a.T$pono = b.T$pono left join  vTFSCPP200180 c  on a.T$ITEM = c.T$ITEM



GO

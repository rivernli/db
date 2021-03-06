USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_Cost_Sheet_for_gp_TFSBOM400180_group_ontime]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vc_Cost_Sheet_for_gp_TFSBOM400180_group_ontime]
AS
SELECT * 
FROM OPENQUERY
(
	AS1P1,'SELECT A.T$PJNO,A.T$SERN,A.T$CRID,(CASE WHEN A.T$CRDT < TO_DATE(''1753-01-01'',''YYYY-MM-DD'') THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE A.T$CRDT END) AS T$CRDT,(CASE WHEN A.T$LCDT < TO_DATE(''1753-01-01'',''YYYY-MM-DD'') THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE A.T$LCDT END) AS T$LCDT,A.T$STAT,A.T$MBSP,A.T$ODSP,A.T$STSP,A.T$MASP,A.T$BUSP,A.T$CESU,A.T$CESP,A.T$CESS,A.T$CISU,A.T$CISP,A.T$CISS,A.T$DLIU,A.T$DLIP,A.T$DLIS,A.T$ILIU,A.T$ILIP,A.T$ILIS,A.T$MDSU,A.T$MDSP,A.T$MDSS,A.T$LDIU,A.T$LDIP,A.T$LDIS,A.T$LDMU,A.T$LDMP,A.T$LDMS,A.T$TCIU,A.T$TCIP,A.T$TCIS,A.T$GSRU,A.T$GSRP,A.T$GSRS,A.T$PRIC,A.T$MCSR,A.T$PRMG,A.T$PMGR,A.T$EPRP,A.T$EPPP,A.T$EPPC,A.T$VERS,A.T$AVER,A.T$TCUU,A.T$TCUP,A.T$TCUS,A.T$FDIR,A.T$BTYP,A.T$ATYP,A.T$TQTY,A.T$MRB1,A.T$MRB4,A.T$MR12,A.T$MR13,A.T$TXTA,A.T$PLNT,A.T$UFLG,A.T$SCRE,A.T$DCFA,(CASE WHEN A.T$CODA < TO_DATE(''1753-01-01'',''YYYY-MM-DD'') THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE A.T$CODA END) AS T$CODA,A.T$COTI,A.T$PVER,A.T$MVER,A.T$OU13,A.T$APRJ,A.T$TSCU,A.T$TSCP,A.T$TSCS,A.T$QSTA,A.T$PLEN,A.T$PWID,A.T$UNST,A.T$STPL,A.T$PLUP
			FROM BAAN.TFSBOM400180 A,
			(
				SELECT T$PJNO , MAX(T$SERN) AS T$SERN FROM BAAN.TFSBOM400180 GROUP BY T$PJNO
			) B
			WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN
	'
)


GO

USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[TFSBOM400180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM400180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$CRID] [char](10) NOT NULL,
	[T$CRDT] [datetime] NOT NULL,
	[T$LCDT] [datetime] NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$MBSP] [float] NOT NULL,
	[T$ODSP] [float] NOT NULL,
	[T$STSP] [float] NOT NULL,
	[T$MASP] [float] NOT NULL,
	[T$BUSP] [float] NOT NULL,
	[T$CESU] [float] NOT NULL,
	[T$CESP] [float] NOT NULL,
	[T$CESS] [float] NOT NULL,
	[T$CISU] [float] NOT NULL,
	[T$CISP] [float] NOT NULL,
	[T$CISS] [float] NOT NULL,
	[T$DLIU] [float] NOT NULL,
	[T$DLIP] [float] NOT NULL,
	[T$DLIS] [float] NOT NULL,
	[T$ILIU] [float] NOT NULL,
	[T$ILIP] [float] NOT NULL,
	[T$ILIS] [float] NOT NULL,
	[T$MDSU] [float] NOT NULL,
	[T$MDSP] [float] NOT NULL,
	[T$MDSS] [float] NOT NULL,
	[T$LDIU] [float] NOT NULL,
	[T$LDIP] [float] NOT NULL,
	[T$LDIS] [float] NOT NULL,
	[T$LDMU] [float] NOT NULL,
	[T$LDMP] [float] NOT NULL,
	[T$LDMS] [float] NOT NULL,
	[T$TCIU] [float] NOT NULL,
	[T$TCIP] [float] NOT NULL,
	[T$TCIS] [float] NOT NULL,
	[T$GSRU] [float] NOT NULL,
	[T$GSRP] [float] NOT NULL,
	[T$GSRS] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$MCSR] [float] NOT NULL,
	[T$PRMG] [float] NOT NULL,
	[T$PMGR] [float] NOT NULL,
	[T$EPRP] [float] NOT NULL,
	[T$EPPP] [float] NOT NULL,
	[T$EPPC] [float] NOT NULL,
	[T$VERS] [float] NOT NULL,
	[T$AVER] [float] NOT NULL,
	[T$TCUU] [float] NOT NULL,
	[T$TCUP] [float] NOT NULL,
	[T$TCUS] [float] NOT NULL,
	[T$FDIR] [char](100) NOT NULL,
	[T$BTYP] [char](40) NOT NULL,
	[T$ATYP] [char](40) NOT NULL,
	[T$TQTY] [float] NOT NULL,
	[T$MRB1] [float] NOT NULL,
	[T$MRB4] [float] NOT NULL,
	[T$MR12] [float] NOT NULL,
	[T$MR13] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$UFLG] [float] NOT NULL,
	[T$SCRE] [char](30) NOT NULL,
	[T$DCFA] [float] NOT NULL,
	[T$CODA] [datetime] NOT NULL,
	[T$COTI] [float] NOT NULL,
	[T$PVER] [char](8) NOT NULL,
	[T$MVER] [char](8) NOT NULL,
	[T$OU13] [float] NOT NULL,
	[T$APRJ] [char](10) NOT NULL,
	[T$TSCU] [float] NOT NULL,
	[T$TSCP] [float] NOT NULL,
	[T$TSCS] [float] NOT NULL,
	[T$QSTA] [float] NOT NULL,
	[T$PLEN] [float] NOT NULL,
	[T$PWID] [float] NOT NULL,
	[T$UNST] [float] NOT NULL,
	[T$STPL] [float] NOT NULL,
	[T$PLUP] [char](20) NOT NULL,
	[T$EAUD] [float] NOT NULL,
	[T$REMK] [char](50) NOT NULL,
	[T$CORE] [float] NOT NULL,
	[T$VERN] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [TFSBOM400180$IDX1]    Script Date: 2014/11/12 17:13:32 ******/
CREATE UNIQUE NONCLUSTERED INDEX [TFSBOM400180$IDX1] ON [dbo].[TFSBOM400180]
(
	[T$PJNO] ASC,
	[T$SERN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

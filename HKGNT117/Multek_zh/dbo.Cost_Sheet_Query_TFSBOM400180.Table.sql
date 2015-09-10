USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_Sheet_Query_TFSBOM400180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_Sheet_Query_TFSBOM400180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$CRID] [char](10) NOT NULL,
	[T$CRDT] [datetime] NULL,
	[T$LCDT] [datetime] NULL,
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
	[T$CODA] [datetime] NULL,
	[T$COTI] [float] NOT NULL,
	[T$PVER] [char](8) NOT NULL,
	[T$MVER] [char](8) NOT NULL,
	[T$OU13] [float] NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL,
	[T$CSGP] [char](6) NULL,
	[T$DSCA] [char](30) NULL,
	[T$UNST] [decimal](18, 4) NULL,
	[T$PANW] [decimal](18, 4) NULL,
	[T$PANL] [decimal](18, 4) NULL,
	[T$AREA] [decimal](18, 4) NULL,
	[T$CBPN] [decimal](18, 4) NULL,
	[T$PNWN] [decimal](18, 4) NULL,
	[T$PNLN] [decimal](18, 4) NULL,
	[T$BOMC] [decimal](18, 4) NULL,
	[T$DATE] [datetime] NULL,
	[T$APRJ] [char](10) NULL,
	[T$PLUP] [nvarchar](20) NULL,
	[T$STPL] [float] NULL,
	[T$TSCU] [decimal](18, 4) NULL,
	[T$TSCP] [decimal](18, 4) NULL,
	[T$TSCS] [decimal](18, 4) NULL,
	[T$CUTN] [nvarchar](100) NULL,
	[EDMCost] [decimal](18, 4) NULL,
	[DA_Cost] [decimal](18, 4) NULL,
	[VAR_MOH] [decimal](18, 4) NULL,
	[IDL_COST] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_project]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [index_project] ON [dbo].[Cost_Sheet_Query_TFSBOM400180]
(
	[T$PJNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index2]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Index2] ON [dbo].[Cost_Sheet_Query_TFSBOM400180]
(
	[T$PJNO] ASC,
	[T$SERN] DESC,
	[T$VERS] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [INDEX3]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [INDEX3] ON [dbo].[Cost_Sheet_Query_TFSBOM400180]
(
	[T$PJNO] ASC,
	[T$SERN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[TFSAMI002180]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSAMI002180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](16) NOT NULL,
	[T$CUTN] [char](100) NOT NULL,
	[T$BOAR] [char](100) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$GRAD] [char](1) NOT NULL,
	[T$LAMI] [char](12) NOT NULL,
	[T$LAML] [float] NOT NULL,
	[T$LAMW] [float] NOT NULL,
	[T$LATK] [float] NOT NULL,
	[T$PANL] [float] NOT NULL,
	[T$PANW] [float] NOT NULL,
	[T$HOTL] [float] NOT NULL,
	[T$HOTW] [float] NOT NULL,
	[T$CUFO] [char](80) NOT NULL,
	[T$SUNO] [char](20) NOT NULL,
	[T$BRDL] [float] NOT NULL,
	[T$BRDW] [float] NOT NULL,
	[T$COLR] [char](16) NOT NULL,
	[T$ULNO] [char](16) NOT NULL,
	[T$SIDE] [float] NOT NULL,
	[T$UNST] [float] NOT NULL,
	[T$CBSR] [char](8) NOT NULL,
	[T$CBPN] [float] NOT NULL,
	[T$CBSH] [float] NOT NULL,
	[T$PNLN] [float] NOT NULL,
	[T$PNWN] [float] NOT NULL,
	[T$UTLL] [float] NOT NULL,
	[T$UTLW] [float] NOT NULL,
	[T$UNTL] [float] NOT NULL,
	[T$UNTW] [float] NOT NULL,
	[T$UNLN] [float] NOT NULL,
	[T$UTUN] [char](6) NOT NULL,
	[T$UNWN] [float] NOT NULL,
	[T$DIMA] [float] NOT NULL,
	[T$DIMB] [float] NOT NULL,
	[T$BOAL] [float] NOT NULL,
	[T$BOAW] [float] NOT NULL,
	[T$USID] [char](20) NOT NULL,
	[T$LSTD] [datetime] NULL,
	[T$DESA] [char](50) NOT NULL,
	[T$DESB] [char](50) NOT NULL,
	[T$DESC] [char](50) NOT NULL,
	[T$DESD] [char](50) NOT NULL,
	[T$DESE] [char](80) NOT NULL,
	[T$SAML] [float] NOT NULL,
	[T$SAMW] [float] NOT NULL,
	[T$FONE] [char](1) NOT NULL,
	[T$FLAY] [char](2) NOT NULL,
	[T$PRJF] [char](10) NOT NULL,
	[T$PRJ4] [char](4) NOT NULL,
	[T$LPAN] [float] NOT NULL,
	[T$WPAN] [float] NOT NULL,
	[T$LLPN] [float] NOT NULL,
	[T$WLPN] [float] NOT NULL,
	[T$ULST] [float] NOT NULL,
	[T$ULPN] [float] NOT NULL,
	[T$MTXT] [float] NOT NULL,
	[T$MOLY] [char](2) NOT NULL,
	[T$BGA] [float] NOT NULL,
	[T$CRUS] [char](10) NOT NULL,
	[T$MDUS] [char](10) NOT NULL,
	[T$CRDT] [datetime] NULL,
	[T$MDDT] [datetime] NULL,
	[T$CYDR] [float] NOT NULL,
	[T$CYRU] [float] NOT NULL,
	[T$CYVC] [float] NOT NULL,
	[T$PATH] [float] NOT NULL,
	[T$SLOT] [float] NOT NULL,
	[T$VLEN] [float] NOT NULL,
	[T$VLNS] [float] NOT NULL,
	[T$CODE] [char](3) NOT NULL,
	[T$SETA] [float] NOT NULL,
	[T$EHSI] [float] NOT NULL,
	[T$CSID] [char](10) NOT NULL,
	[T$CSDT] [datetime] NULL,
	[T$UPID] [char](30) NOT NULL,
	[T$ACTF] [float] NOT NULL,
	[T$ACTD] [datetime] NULL,
	[T$SMPT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_TFSAMI002180] ON [dbo].[TFSAMI002180] 
(
	[T$PJNO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

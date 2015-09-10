USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[fsolp120180_emptyCcty]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fsolp120180_emptyCcty](
	[T$LOCA] [char](30) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$DRCT] [float] NOT NULL,
	[T$INVD] [datetime] NULL,
	[T$DDAT] [datetime] NULL,
	[T$S1DA] [datetime] NULL,
	[T$SH11] [float] NOT NULL,
	[T$SHTM] [datetime] NULL,
	[T$CUST] [char](6) NOT NULL,
	[T$BAD1] [char](35) NOT NULL,
	[T$SHCU] [char](30) NOT NULL,
	[T$SHCN] [char](35) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$INSN] [char](35) NOT NULL,
	[T$EONO] [char](30) NOT NULL,
	[T$BUSN] [char](8) NOT NULL,
	[T$SEGM] [char](30) NOT NULL,
	[T$DUDT] [datetime] NULL,
	[T$DODT] [datetime] NULL,
	[T$CUPN] [char](30) NOT NULL,
	[T$PARV] [char](30) NOT NULL,
	[T$CPID] [float] NOT NULL,
	[T$PRIY] [float] NOT NULL,
	[T$ORDS] [float] NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$NREE] [float] NOT NULL,
	[T$TSAL] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PROF] [float] NOT NULL,
	[T$UPRI] [float] NOT NULL,
	[T$PRIP] [float] NOT NULL,
	[T$COSP] [float] NOT NULL,
	[T$PROP] [float] NOT NULL,
	[T$PROT] [float] NOT NULL,
	[T$PROI] [float] NOT NULL,
	[T$SODT] [datetime] NULL,
	[T$SOTM] [float] NOT NULL,
	[T$COTP] [char](3) NOT NULL,
	[T$ORDT] [float] NOT NULL,
	[T$INNU] [float] NOT NULL,
	[T$NAMA] [char](30) NOT NULL,
	[T$ORNU] [char](5) NOT NULL,
	[T$USNM] [char](30) NOT NULL,
	[T$CONN] [char](6) NOT NULL,
	[T$CONA] [char](30) NOT NULL,
	[T$RATS] [float] NOT NULL,
	[T$PRON] [char](16) NOT NULL,
	[T$OEMM] [char](30) NOT NULL,
	[T$ENDC] [char](35) NOT NULL,
	[T$CARR] [char](30) NOT NULL,
	[T$TRAN] [char](30) NOT NULL,
	[T$LAYS] [char](4) NOT NULL,
	[T$SELC] [char](30) NOT NULL,
	[T$SHPA] [float] NOT NULL,
	[T$SHLY] [float] NOT NULL,
	[T$WIDB] [float] NOT NULL,
	[T$LENB] [float] NOT NULL,
	[T$AREB] [float] NOT NULL,
	[T$WIDP] [float] NOT NULL,
	[T$LENP] [float] NOT NULL,
	[T$AREP] [float] NOT NULL,
	[T$SUBS] [char](30) NOT NULL,
	[T$BASM] [char](30) NOT NULL,
	[T$HOLB] [float] NOT NULL,
	[T$HOLP] [float] NOT NULL,
	[T$SMAH] [float] NOT NULL,
	[T$THIC] [float] NOT NULL,
	[T$ASPR] [float] NOT NULL,
	[T$SHBD] [float] NOT NULL,
	[T$SHDD] [float] NOT NULL,
	[T$SHAY] [float] NOT NULL,
	[T$SHDL] [float] NOT NULL,
	[T$ATLC] [char](6) NOT NULL,
	[T$SHPN] [char](30) NOT NULL,
	[T$UPAR] [float] NOT NULL,
	[T$BRAR] [float] NOT NULL,
	[T$UARE] [float] NOT NULL,
	[T$CRRT] [float] NOT NULL,
	[T$INVB] [char](30) NOT NULL,
	[T$INVN] [float] NOT NULL,
	[T$CPRT] [float] NOT NULL,
	[T$PRTP] [char](30) NOT NULL,
	[T$SOSE] [float] NOT NULL,
	[T$SHDO] [float] NOT NULL,
	[T$NREL] [float] NOT NULL,
	[T$ITLS] [float] NOT NULL,
	[T$PRIB] [float] NOT NULL,
	[T$COSL] [float] NOT NULL,
	[T$PROL] [float] NOT NULL,
	[T$PRIL] [float] NOT NULL,
	[T$COPL] [float] NOT NULL,
	[T$PRPL] [float] NOT NULL,
	[T$PRFP] [float] NOT NULL,
	[T$PRFL] [float] NOT NULL,
	[T$SHOC] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$SHDT] [datetime] NULL,
	[T$SHID] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$BUSU] [char](30) NOT NULL,
	[T$CUNM] [char](35) NOT NULL,
	[T$BAD2] [char](35) NOT NULL,
	[T$COBA] [char](30) NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$PODT] [datetime] NULL,
	[T$RQDT] [datetime] NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$AREA] [float] NOT NULL,
	[T$REFA] [char](30) NOT NULL,
	[T$CODA] [char](30) NOT NULL,
	[T$CSCO] [char](30) NOT NULL,
	[T$CDSC] [char](35) NOT NULL,
	[T$STYP] [char](4) NOT NULL,
	[T$FIDS] [char](30) NOT NULL,
	[T$FLDT] [datetime] NULL,
	[T$PSPL] [float] NOT NULL,
	[T$PRDN] [char](30) NOT NULL,
	[T$FLEX] [float] NOT NULL,
	[T$ISEG] [char](6) NOT NULL,
	[T$DESC] [char](30) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$OTYP] [char](30) NOT NULL,
	[T$NAMB] [char](30) NOT NULL,
	[T$NAMC] [char](30) NOT NULL,
	[T$NAMD] [char](30) NOT NULL,
	[T$NAME] [char](30) NOT NULL,
	[T$NAMF] [char](30) NOT NULL,
	[T$PSTC] [char](10) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$CRTE] [char](5) NOT NULL,
	[T$CADR] [char](6) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

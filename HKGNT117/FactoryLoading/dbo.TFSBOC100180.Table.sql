USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSBOC100180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOC100180](
	[T$YEAR] [float] NOT NULL,
	[T$PRNO] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$PIT8] [char](8) NOT NULL,
	[T$PITA] [char](16) NOT NULL,
	[T$PIT4] [char](16) NOT NULL,
	[T$CUNA] [char](40) NOT NULL,
	[T$OEMN] [char](30) NOT NULL,
	[T$PRDN] [char](30) NOT NULL,
	[T$CUPN] [char](30) NOT NULL,
	[T$CONF] [char](30) NOT NULL,
	[T$LVPN] [char](30) NOT NULL,
	[T$RVPN] [char](30) NOT NULL,
	[T$SIZE] [char](15) NOT NULL,
	[T$UNPL] [float] NOT NULL,
	[T$PNSZ] [float] NOT NULL,
	[T$ULST] [float] NOT NULL,
	[T$MILW] [float] NOT NULL,
	[T$ITHO] [float] NOT NULL,
	[T$OTHO] [float] NOT NULL,
	[T$TTHO] [float] NOT NULL,
	[T$ILHO] [float] NOT NULL,
	[T$OLHO] [float] NOT NULL,
	[T$TLHO] [float] NOT NULL,
	[T$PLAT] [float] NOT NULL,
	[T$PRES] [float] NOT NULL,
	[T$IMTR] [float] NOT NULL,
	[T$EAUQ] [float] NOT NULL,
	[T$ETKQ] [float] NOT NULL,
	[T$HASQ] [float] NOT NULL,
	[T$GLPQ] [float] NOT NULL,
	[T$EAGQ] [float] NOT NULL,
	[T$ETNQ] [float] NOT NULL,
	[T$XOUT] [float] NOT NULL,
	[T$BITM$1] [char](12) NOT NULL,
	[T$BITM$2] [char](12) NOT NULL,
	[T$BITM$3] [char](12) NOT NULL,
	[T$BITM$4] [char](12) NOT NULL,
	[T$BITM$5] [char](12) NOT NULL,
	[T$BITM$6] [char](12) NOT NULL,
	[T$BITM$7] [char](12) NOT NULL,
	[T$BITM$8] [char](12) NOT NULL,
	[T$BITM$9] [char](12) NOT NULL,
	[T$BITM$10] [char](12) NOT NULL,
	[T$BITM$11] [char](12) NOT NULL,
	[T$BITM$12] [char](12) NOT NULL,
	[T$BITM$13] [char](12) NOT NULL,
	[T$BITM$14] [char](12) NOT NULL,
	[T$BITM$15] [char](12) NOT NULL,
	[T$CONS$1] [float] NOT NULL,
	[T$CONS$2] [float] NOT NULL,
	[T$CONS$3] [float] NOT NULL,
	[T$CONS$4] [float] NOT NULL,
	[T$CONS$5] [float] NOT NULL,
	[T$CONS$6] [float] NOT NULL,
	[T$CONS$7] [float] NOT NULL,
	[T$CONS$8] [float] NOT NULL,
	[T$CONS$9] [float] NOT NULL,
	[T$CONS$10] [float] NOT NULL,
	[T$CONS$11] [float] NOT NULL,
	[T$CONS$12] [float] NOT NULL,
	[T$CONS$13] [float] NOT NULL,
	[T$CONS$14] [float] NOT NULL,
	[T$CONS$15] [float] NOT NULL,
	[T$PRIT$1] [float] NOT NULL,
	[T$PRIT$2] [float] NOT NULL,
	[T$PRIT$3] [float] NOT NULL,
	[T$PRIT$4] [float] NOT NULL,
	[T$PRIT$5] [float] NOT NULL,
	[T$PRIT$6] [float] NOT NULL,
	[T$PRIT$7] [float] NOT NULL,
	[T$PRIT$8] [float] NOT NULL,
	[T$PRIT$9] [float] NOT NULL,
	[T$PRIT$10] [float] NOT NULL,
	[T$PRIT$11] [float] NOT NULL,
	[T$PRIT$12] [float] NOT NULL,
	[T$PRIT$13] [float] NOT NULL,
	[T$PRIT$14] [float] NOT NULL,
	[T$PRIT$15] [float] NOT NULL,
	[T$RCON$1] [float] NOT NULL,
	[T$RCON$2] [float] NOT NULL,
	[T$RCON$3] [float] NOT NULL,
	[T$RCON$4] [float] NOT NULL,
	[T$RCON$5] [float] NOT NULL,
	[T$RCON$6] [float] NOT NULL,
	[T$RCON$7] [float] NOT NULL,
	[T$RCON$8] [float] NOT NULL,
	[T$RCON$9] [float] NOT NULL,
	[T$RCON$10] [float] NOT NULL,
	[T$RCON$11] [float] NOT NULL,
	[T$RCON$12] [float] NOT NULL,
	[T$RCON$13] [float] NOT NULL,
	[T$RCON$14] [float] NOT NULL,
	[T$RCON$15] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$PRFT] [float] NOT NULL,
	[T$YIED] [float] NOT NULL,
	[T$MATC] [float] NOT NULL,
	[T$PRTC] [float] NOT NULL,
	[T$TOCO] [float] NOT NULL,
	[T$MARG] [float] NOT NULL,
	[T$PRPS] [float] NOT NULL,
	[T$BOOK] [float] NOT NULL,
	[T$BKFT] [float] NOT NULL,
	[T$PPFT] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$PTOS] [float] NOT NULL,
	[T$BTNO] [float] NOT NULL,
	[T$DATS] [float] NOT NULL,
	[T$MGPC] [float] NOT NULL,
	[T$MGTL] [float] NOT NULL,
	[T$DPRI] [float] NOT NULL,
	[T$DPRT] [float] NOT NULL,
	[T$DMAR] [float] NOT NULL,
	[T$DAMN] [float] NOT NULL,
	[T$DMGT] [float] NOT NULL,
	[T$DPRP] [float] NOT NULL,
	[T$DPRF] [float] NOT NULL,
	[T$DPTO] [float] NOT NULL,
	[T$DMGP] [float] NOT NULL,
	[T$DLCT] [float] NOT NULL,
	[T$ILCT] [float] NOT NULL,
	[T$MTRC] [float] NOT NULL,
	[T$PSMC] [float] NOT NULL,
	[T$DOSC] [float] NOT NULL,
	[T$ODCT] [float] NOT NULL,
	[T$OMCT] [float] NOT NULL,
	[T$LDCT] [float] NOT NULL,
	[T$LMCT] [float] NOT NULL,
	[T$ELCT] [float] NOT NULL,
	[T$FWCT] [float] NOT NULL,
	[T$WWCT] [float] NOT NULL,
	[T$OHCT] [float] NOT NULL,
	[T$GSRS] [float] NOT NULL,
	[T$TCUS] [float] NOT NULL,
	[T$MRBS] [float] NOT NULL,
	[T$ROWK] [float] NOT NULL,
	[T$MASP] [float] NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

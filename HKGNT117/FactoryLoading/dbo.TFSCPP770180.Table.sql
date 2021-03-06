USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSCPP770180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP770180](
	[T$SERN] [float] NOT NULL,
	[T$USER] [char](10) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$FLAG] [float] NOT NULL,
	[T$CUNO$F] [char](6) NOT NULL,
	[T$CUNO$T] [char](6) NOT NULL,
	[T$DSCA$F] [char](30) NOT NULL,
	[T$DSCA$T] [char](30) NOT NULL,
	[T$EONO$F] [char](30) NOT NULL,
	[T$EONO$T] [char](30) NOT NULL,
	[T$ITEM$F] [char](32) NOT NULL,
	[T$ITEM$T] [char](32) NOT NULL,
	[T$ODAT$F] [datetime] NULL,
	[T$ODAT$T] [datetime] NULL,
	[T$PCDT$F] [datetime] NULL,
	[T$PCDT$T] [datetime] NULL,
	[T$PODATE$F] [datetime] NULL,
	[T$PODATE$T] [datetime] NULL,
	[T$ORNO$F] [float] NOT NULL,
	[T$ORNO$T] [float] NOT NULL,
	[T$CWAR$F] [char](3) NOT NULL,
	[T$CWAR$T] [char](3) NOT NULL,
	[T$CREP$F] [float] NOT NULL,
	[T$CREP$T] [float] NOT NULL,
	[T$CSGS$F] [char](6) NOT NULL,
	[T$CSGS$T] [char](6) NOT NULL,
	[T$CBRN$F] [char](6) NOT NULL,
	[T$CBRN$T] [char](6) NOT NULL,
	[T$IATL] [float] NOT NULL,
	[T$ALLS] [float] NOT NULL,
	[T$HOLD] [float] NOT NULL,
	[T$CANCEL] [float] NOT NULL,
	[T$RELEASE] [float] NOT NULL,
	[T$ALLB] [float] NOT NULL,
	[T$BLOCK] [float] NOT NULL,
	[T$UNBLOK] [float] NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$NGSN] [float] NOT NULL,
	[T$CUST] [float] NOT NULL,
	[T$PBLG] [float] NOT NULL,
	[T$OHSH] [float] NOT NULL,
	[T$COTP$F] [char](3) NOT NULL,
	[T$COTP$T] [char](3) NOT NULL,
	[T$DLDT$F] [datetime] NULL,
	[T$DLDT$T] [datetime] NULL,
	[T$PLDT$F] [datetime] NULL,
	[T$PLDT$T] [datetime] NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTFCMG003180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTFCMG003180](
	[T$PAYM] [char](3) NOT NULL,
	[T$DESC] [char](30) NOT NULL,
	[T$REPA] [float] NOT NULL,
	[T$AUTO] [float] NOT NULL,
	[T$MAXA] [float] NOT NULL,
	[T$ALPM] [char](3) NOT NULL,
	[T$BANK] [float] NOT NULL,
	[T$BADR] [float] NOT NULL,
	[T$SESS] [char](20) NOT NULL,
	[T$RGRP] [float] NOT NULL,
	[T$RGR2] [float] NOT NULL,
	[T$COPT] [float] NOT NULL,
	[T$CLIM] [float] NOT NULL,
	[T$CACT] [float] NOT NULL,
	[T$DNUM] [float] NOT NULL,
	[T$NUMB] [float] NOT NULL,
	[T$CHEQ] [float] NOT NULL,
	[T$RS01] [float] NOT NULL,
	[T$RS02] [float] NOT NULL,
	[T$RS03] [float] NOT NULL,
	[T$PS01] [float] NOT NULL,
	[T$PS02] [float] NOT NULL,
	[T$TYPP] [float] NOT NULL,
	[T$DEV1] [char](14) NOT NULL,
	[T$DEV2] [char](14) NOT NULL,
	[T$ODV1] [float] NOT NULL,
	[T$BODD] [float] NOT NULL,
	[T$PACU] [float] NOT NULL,
	[T$FCUR] [float] NOT NULL,
	[T$FCTR] [float] NOT NULL,
	[T$UIBA] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

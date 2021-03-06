USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Charge_PPC_WIP_bk]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Charge_PPC_WIP_bk](
	[T$ORNO] [nvarchar](6) NULL,
	[T$ITEM] [nvarchar](30) NULL,
	[m3-00] [nvarchar](10) NULL,
	[MAL] [nchar](10) NULL,
	[PRE1] [nchar](10) NULL,
	[DRL1] [nchar](10) NULL,
	[SMR1] [nchar](10) NULL,
	[SMR2] [nchar](10) NULL,
	[PTH1] [nchar](10) NULL,
	[CPP1] [nchar](10) NULL,
	[DYM1] [nchar](10) NULL,
	[PAT1] [nchar](10) NULL,
	[EAP1] [nchar](10) NULL,
	[TMP1] [nchar](10) NULL,
	[QC11] [nchar](10) NULL,
	[WSM1] [nchar](10) NULL,
	[COM1] [nchar](10) NULL,
	[BPT1] [nchar](10) NULL,
	[IMP2] [nchar](10) NULL,
	[CBR1] [nchar](10) NULL,
	[ROU1] [nchar](10) NULL,
	[ETS1] [nchar](10) NULL,
	[FQC1] [nchar](10) NULL,
	[T$COST] [float] NULL
) ON [PRIMARY]

GO

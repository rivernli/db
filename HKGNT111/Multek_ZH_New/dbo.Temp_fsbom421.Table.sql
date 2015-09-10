USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[Temp_fsbom421]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Temp_fsbom421](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$ITEM] [char](16) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$PSRN] [float] NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$MTRC] [float] NOT NULL,
	[T$DLCT] [float] NOT NULL,
	[T$ILCT] [float] NOT NULL,
	[T$PSMC] [float] NOT NULL,
	[T$DOSC] [float] NOT NULL,
	[T$MDCT] [float] NOT NULL,
	[T$MMCT] [float] NOT NULL,
	[T$ELCT] [float] NOT NULL,
	[T$FWCT] [float] NOT NULL,
	[T$WWCT] [float] NOT NULL,
	[T$LDCT] [float] NOT NULL,
	[T$LOAD] [float] NOT NULL,
	[T$SNCO] [float] NOT NULL,
	[T$COCO] [float] NOT NULL,
	[T$CUCO] [float] NOT NULL,
	[T$CHCO] [float] NOT NULL,
	[T$DRTI] [float] NOT NULL,
	[T$ROTI] [float] NOT NULL,
	[T$LATI] [float] NOT NULL,
	[T$PUTI] [float] NOT NULL,
	[T$SID] [float] NOT NULL,
	[T$BOMC] [float] NOT NULL,
	[T$DPAM] [float] NOT NULL,
	[T$EQEX] [float] NOT NULL,
	[T$FAUT] [float] NOT NULL,
	[T$CMPT] [float] NOT NULL,
	[T$SUPP] [float] NOT NULL,
	[T$TREN] [float] NOT NULL,
	[T$OTER] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

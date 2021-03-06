USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_sheet_Report_for_MKT]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_sheet_Report_for_MKT](
	[T$PLNT] [nchar](2) NULL,
	[T$PJNO] [char](10) NOT NULL,
	[OEM] [char](30) NULL,
	[CUSPART] [char](100) NULL,
	[T$SERN] [float] NOT NULL,
	[T$VERS] [float] NOT NULL,
	[T$MASP] [float] NOT NULL,
	[T$BUSP] [float] NOT NULL,
	[T$CESU] [float] NOT NULL,
	[T$CESP] [float] NOT NULL,
	[T$CISU] [float] NOT NULL,
	[T$TCIU] [float] NOT NULL,
	[T$TCUU] [float] NOT NULL,
	[T$CISS] [float] NOT NULL,
	[T$TCIS] [float] NOT NULL,
	[T$TCUS] [float] NOT NULL,
	[T$BOMC] [decimal](18, 4) NULL,
	[T$UNST] [decimal](18, 4) NULL,
	[T$CBPN] [decimal](18, 4) NULL,
	[T$QUTY] [float] NULL,
	[T$UNIT] [char](3) NULL,
	[T$CODA] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

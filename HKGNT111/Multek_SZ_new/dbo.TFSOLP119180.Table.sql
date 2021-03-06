USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TFSOLP119180]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP119180](
	[T$SERN] [float] NOT NULL,
	[T$CSGS] [char](6) NOT NULL,
	[T$NAMA] [char](30) NOT NULL,
	[T$CEMN] [char](6) NOT NULL,
	[T$NAMB] [char](30) NOT NULL,
	[T$CUNO] [char](6) NOT NULL,
	[T$CDEL] [char](3) NOT NULL,
	[T$NAMC] [char](30) NOT NULL,
	[T$PB12] [float] NOT NULL,
	[T$PB3] [float] NOT NULL,
	[T$PB4] [float] NOT NULL,
	[T$PB5] [float] NOT NULL,
	[T$B2F] [float] NOT NULL,
	[T$NOPT] [float] NOT NULL,
	[T$SUB1] [float] NOT NULL,
	[T$SUB2] [float] NOT NULL,
	[T$TOTL] [float] NOT NULL,
	[T$PRD1] [float] NOT NULL,
	[T$PRD2] [float] NOT NULL,
	[T$PRD3] [float] NOT NULL,
	[T$PRD4] [float] NOT NULL,
	[T$OTER] [float] NOT NULL,
	[T$BOOK] [float] NOT NULL,
	[T$PROJ] [char](32) NOT NULL,
	[T$ASP] [float] NOT NULL,
	[T$DATF] [datetime] NULL,
	[T$DATT] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$PCDT] [datetime] NULL,
	[T$SQFT] [float] NOT NULL,
	[T$CRFN] [char](6) NOT NULL,
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$ODAT] [datetime] NULL,
	[T$ASDT] [datetime] NULL,
	[T$B12] [float] NOT NULL,
	[T$OQUA] [float] NOT NULL,
	[T$FIWK] [char](2) NOT NULL,
	[T$CAWK] [char](2) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

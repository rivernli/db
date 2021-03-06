USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP150180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP150180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$BOMC] [float] NOT NULL,
	[T$SQFT] [float] NOT NULL,
	[T$BUSP] [float] NOT NULL,
	[T$EDMC] [float] NOT NULL,
	[T$MRBY] [float] NOT NULL,
	[T$DLIU] [float] NOT NULL,
	[T$SUBVAR] [float] NOT NULL,
	[T$DEPRE] [float] NOT NULL,
	[T$GSRU] [float] NOT NULL,
	[T$FIXC] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTCCOM025180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTCCOM025180](
	[T$SUNO] [char](6) NOT NULL,
	[T$CBAN] [char](3) NOT NULL,
	[T$CTOB] [float] NOT NULL,
	[T$CBAD] [char](12) NOT NULL,
	[T$BANO] [char](25) NOT NULL,
	[T$TOAC] [float] NOT NULL,
	[T$SWFT] [char](12) NOT NULL,
	[T$BNID] [char](11) NOT NULL,
	[T$IBAN] [char](34) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

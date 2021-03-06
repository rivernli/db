USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM469180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM469180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$TYPE] [char](8) NOT NULL,
	[T$DESC] [char](60) NOT NULL,
	[T$SELE] [float] NOT NULL,
	[T$VERN] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

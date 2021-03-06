USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSBOM462180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM462180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$PITM] [char](16) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$PSRN] [float] NOT NULL,
	[T$MNWC] [char](3) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$SELE] [float] NOT NULL,
	[T$COST] [float] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$VERS] [char](8) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

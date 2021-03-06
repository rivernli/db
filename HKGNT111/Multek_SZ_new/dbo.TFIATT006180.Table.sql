USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TFIATT006180]    Script Date: 11/06/2014 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFIATT006180](
	[T$ITEM] [char](32) NOT NULL,
	[T$SERL] [float] NOT NULL,
	[T$ATTR] [char](20) NOT NULL,
	[T$ASTR] [char](30) NOT NULL,
	[T$ANUM] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$USET] [char](6) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

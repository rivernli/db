USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[TFSBOM401180_bk2013_10_17]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSBOM401180_bk2013_10_17](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$SQNO] [float] NOT NULL,
	[T$META] [char](20) NOT NULL,
	[T$COSP] [float] NOT NULL,
	[T$COSU] [float] NOT NULL,
	[T$COSS] [float] NOT NULL,
	[T$COPR] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

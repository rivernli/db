USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_Sheet_Query_TFSBOM401180_BK_2013_04_16]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_Sheet_Query_TFSBOM401180_BK_2013_04_16](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$AVER] [float] NULL,
	[T$VERS] [float] NULL,
	[T$SQNO] [float] NOT NULL,
	[T$META] [char](20) NOT NULL,
	[T$COSP] [decimal](18, 4) NULL,
	[T$COSU] [decimal](18, 4) NULL,
	[T$COSS] [decimal](18, 4) NULL,
	[T$COPR] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

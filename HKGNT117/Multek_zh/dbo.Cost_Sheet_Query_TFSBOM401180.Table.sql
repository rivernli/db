USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_Sheet_Query_TFSBOM401180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_Sheet_Query_TFSBOM401180](
	[T$PJNO] [char](10) NOT NULL,
	[T$SERN] [float] NOT NULL,
	[T$AVER] [float] NULL,
	[T$VERS] [float] NULL,
	[T$SQNO] [float] NOT NULL,
	[T$META] [char](20) NOT NULL,
	[T$COSP] [decimal](18, 4) NULL,
	[T$COSU] [decimal](18, 4) NULL,
	[T$COSS] [decimal](18, 4) NULL,
	[T$COPR] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Cost_Sheet_Query_TFSBOM401180] PRIMARY KEY CLUSTERED 
(
	[T$PJNO] ASC,
	[T$SERN] ASC,
	[T$SQNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [FSCPP401_INDEX1]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [FSCPP401_INDEX1] ON [dbo].[Cost_Sheet_Query_TFSBOM401180]
(
	[T$PJNO] ASC,
	[T$SERN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

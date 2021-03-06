USE [BOC]
GO
/****** Object:  Table [dbo].[period]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[period](
	[Date_EN] [datetime] NOT NULL,
	[Date] [nvarchar](50) NULL,
	[Datec] [nchar](50) NULL,
	[FYear] [int] NULL,
	[Period] [int] NULL,
	[Week_Period] [int] NULL,
 CONSTRAINT [PK_period_1] PRIMARY KEY CLUSTERED 
(
	[Date_EN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_period]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [IX_period] ON [dbo].[period]
(
	[FYear] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[YieldTrend_Site]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[YieldTrend_Site](
	[SiteCode] [varchar](10) NOT NULL,
	[SiteDesc] [varchar](50) NOT NULL,
	[SiteState] [bit] NOT NULL,
 CONSTRAINT [PK_YieldTrend_Site] PRIMARY KEY CLUSTERED 
(
	[SiteCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

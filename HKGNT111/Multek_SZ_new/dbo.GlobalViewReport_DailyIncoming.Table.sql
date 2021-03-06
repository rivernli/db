USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[GlobalViewReport_DailyIncoming]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalViewReport_DailyIncoming](
	[Plant] [varchar](10) NOT NULL,
	[Day] [date] NOT NULL,
	[Amount] [numeric](18, 2) NULL,
 CONSTRAINT [PK_GlobalViewReport_DailyIncoming] PRIMARY KEY CLUSTERED 
(
	[Plant] ASC,
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

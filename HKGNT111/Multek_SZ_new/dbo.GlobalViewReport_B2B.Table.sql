USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[GlobalViewReport_B2B]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalViewReport_B2B](
	[Year] [varchar](4) NOT NULL,
	[WeekNo] [int] NOT NULL,
	[WeekDesc] [varchar](50) NOT NULL,
	[WeekFrom] [date] NULL,
	[WeekTo] [date] NULL,
	[ReportCode] [varchar](3) NOT NULL,
	[B1] [numeric](18, 2) NOT NULL,
	[B2F] [numeric](18, 2) NOT NULL,
	[B3] [numeric](18, 2) NOT NULL,
	[B4] [numeric](18, 2) NOT NULL,
	[B5] [numeric](18, 2) NOT NULL,
	[VVI] [numeric](18, 2) NOT NULL,
	[TotalNotB2F] [numeric](18, 2) NOT NULL,
	[Total] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_GlobalViewReport_B2B_1] PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[WeekNo] ASC,
	[ReportCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_B1]  DEFAULT ((0)) FOR [B1]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_B2F]  DEFAULT ((0)) FOR [B2F]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_B3]  DEFAULT ((0)) FOR [B3]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_B4]  DEFAULT ((0)) FOR [B4]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_B5]  DEFAULT ((0)) FOR [B5]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_VVI]  DEFAULT ((0)) FOR [VVI]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_TotalNotVVI]  DEFAULT ((0)) FOR [TotalNotB2F]
GO
ALTER TABLE [dbo].[GlobalViewReport_B2B] ADD  CONSTRAINT [DF_GlobalViewReport_B2B_Total]  DEFAULT ((0)) FOR [Total]
GO

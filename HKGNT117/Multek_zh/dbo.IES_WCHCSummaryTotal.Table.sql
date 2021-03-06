USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_WCHCSummaryTotal]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_WCHCSummaryTotal](
	[Building] [varchar](10) NOT NULL,
	[Process] [varchar](50) NOT NULL,
	[KeyMachine] [varchar](50) NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[YearWeek] [int] NOT NULL,
	[Loading] [decimal](18, 4) NOT NULL,
	[HC] [int] NOT NULL,
	[DataType] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[IES_WCHCSummaryTotal] ADD  CONSTRAINT [DF_IES_WCHCSummary_Supporting_Loading]  DEFAULT ((0)) FOR [Loading]
GO
ALTER TABLE [dbo].[IES_WCHCSummaryTotal] ADD  CONSTRAINT [DF_IES_WCHCSummary_Supporting_HC]  DEFAULT ((0)) FOR [HC]
GO

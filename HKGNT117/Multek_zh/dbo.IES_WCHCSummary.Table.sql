USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_WCHCSummary]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IES_WCHCSummary](
	[MCID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[YearWeek] [int] NOT NULL,
	[Loading] [decimal](18, 4) NOT NULL,
	[HC] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[IES_WCHCSummary] ADD  CONSTRAINT [DF_IES_WCHCSummary_HC]  DEFAULT ((0)) FOR [HC]
GO

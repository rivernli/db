USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_DailyOutputPnl_History]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_DailyOutputPnl_History](
	[ID] [int] NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[Project] [varchar](50) NOT NULL,
	[OutputDate] [datetime] NOT NULL,
	[Month] [int] NULL,
	[YearWeek] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

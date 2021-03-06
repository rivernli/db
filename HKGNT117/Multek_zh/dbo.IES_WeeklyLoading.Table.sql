USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_WeeklyLoading]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_WeeklyLoading](
	[LoadingType] [varchar](10) NOT NULL,
	[Building] [varchar](5) NOT NULL,
	[PBPID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[YearWeek] [int] NOT NULL,
	[WorkingDay] [int] NULL,
	[CapacityHours] [decimal](18, 2) NOT NULL,
	[TotalTime] [decimal](18, 4) NULL,
	[Loading] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

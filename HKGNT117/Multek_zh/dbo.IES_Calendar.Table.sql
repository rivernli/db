USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_Calendar]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_Calendar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[CalendarDate] [datetime] NOT NULL,
	[WODate] [varchar](20) NOT NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[Quarter] [int] NULL,
	[YearWeek] [int] NULL,
	[Date] [int] NULL,
	[FinWeek] [int] NULL,
	[WorkingDay] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_ByMPSCalc_Source]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_ByMPSCalc_Source](
	[Building] [varchar](50) NOT NULL,
	[Project] [varchar](50) NOT NULL,
	[Customer] [varchar](200) NULL,
	[CalendarDate] [datetime] NOT NULL,
	[BookingQty] [decimal](18, 2) NULL,
	[BacklogSqFt] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

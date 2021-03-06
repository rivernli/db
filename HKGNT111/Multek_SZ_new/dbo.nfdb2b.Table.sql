USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[nfdb2b]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[nfdb2b](
	[Date] [date] NOT NULL,
	[BU] [varchar](50) NOT NULL,
	[WeeklyOrderIntake] [numeric](18, 4) NOT NULL,
	[B2B4Weeks] [numeric](18, 4) NOT NULL,
	[B2B13Weeks] [numeric](18, 4) NOT NULL,
	[OrderBacklog] [numeric](18, 4) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

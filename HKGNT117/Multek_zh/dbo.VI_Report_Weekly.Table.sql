USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[VI_Report_Weekly]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VI_Report_Weekly](
	[Year] [varchar](4) NOT NULL,
	[Week] [smallint] NOT NULL,
	[WeekDesc] [varchar](50) NOT NULL,
	[Loc] [varchar](50) NULL,
	[Amount] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

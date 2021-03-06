USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PPS_WIP]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_PPS_WIP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[Project] [varchar](50) NOT NULL,
	[ProjectWV] [varchar](50) NULL,
	[SubProject] [varchar](50) NOT NULL,
	[SubProjectWV] [varchar](50) NULL,
	[WorkCenter] [varchar](50) NULL,
	[CalendarDate] [datetime] NOT NULL,
	[Core] [int] NULL,
	[Calc] [int] NULL,
	[Qty] [decimal](18, 2) NULL,
	[Pnl] [decimal](18, 2) NULL,
	[Seq] [int] NULL,
	[QtyOS] [decimal](18, 2) NULL,
	[PnlOS] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

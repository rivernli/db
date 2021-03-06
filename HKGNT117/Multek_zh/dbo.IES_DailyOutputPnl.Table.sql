USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_DailyOutputPnl]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_DailyOutputPnl](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[Project] [varchar](50) NOT NULL,
	[OutputDate] [datetime] NOT NULL,
	[Month] [int] NULL,
	[YearWeek] [int] NULL,
 CONSTRAINT [PK_IES_DailyOutputPnl] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

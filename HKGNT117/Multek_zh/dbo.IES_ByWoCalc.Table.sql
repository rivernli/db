USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_ByWoCalc]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_ByWoCalc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[Project] [varchar](50) NOT NULL,
	[Customer] [varchar](200) NULL,
	[CalendarDate] [datetime] NOT NULL,
	[BookingQty] [decimal](18, 2) NULL,
	[BacklogSqFt] [decimal](18, 2) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[YearWeek] [int] NULL,
	[ProductionType] [varchar](50) NULL,
 CONSTRAINT [PK_IES_ByWoCalc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

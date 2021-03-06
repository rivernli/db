USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_ChinaOrderBooking]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_ChinaOrderBooking](
	[Period] [varchar](50) NULL,
	[Description] [nvarchar](128) NULL,
	[B1] [float] NOT NULL,
	[B2F] [float] NOT NULL,
	[B3] [float] NOT NULL,
	[B4] [float] NOT NULL,
	[B5] [float] NOT NULL,
	[VVI] [float] NOT NULL,
	[Overall] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

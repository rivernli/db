USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_Forecast_History]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_Forecast_History](
	[ChangedDate] [datetime] NULL,
	[Type] [varchar](10) NULL,
	[Plant] [varchar](50) NULL,
	[FYear] [varchar](6) NULL,
	[Period] [int] NOT NULL,
	[Forecast] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

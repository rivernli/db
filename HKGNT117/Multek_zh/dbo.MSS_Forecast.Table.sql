USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_Forecast]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_Forecast](
	[Type] [varchar](10) NOT NULL,
	[FYear] [varchar](6) NOT NULL,
	[Period] [int] NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Forecast] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MCOS_daily_4RP_MaterialSum]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MCOS_daily_4RP_MaterialSum](
	[plant] [char](2) NOT NULL,
	[year] [char](15) NOT NULL,
	[period] [float] NOT NULL,
	[productionType] [varchar](14) NOT NULL,
	[sum] [float] NULL,
	[fiscalYear] [nvarchar](4) NULL,
	[quarter] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

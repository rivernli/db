USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Forecast_bk_20130307]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Forecast_bk_20130307](
	[Type] [varchar](10) NOT NULL,
	[Site] [varchar](3) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[M1] [bigint] NULL,
	[M2] [bigint] NULL,
	[M3] [bigint] NULL,
	[M4] [bigint] NULL,
	[M5] [bigint] NULL,
	[M6] [bigint] NULL,
	[M7] [bigint] NULL,
	[M8] [bigint] NULL,
	[M9] [bigint] NULL,
	[M10] [bigint] NULL,
	[M11] [bigint] NULL,
	[M12] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

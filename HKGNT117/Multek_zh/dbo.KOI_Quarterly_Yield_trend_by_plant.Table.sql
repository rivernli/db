USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Quarterly_Yield_trend_by_plant]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_Quarterly_Yield_trend_by_plant](
	[ReportCode] [varchar](3) NOT NULL,
	[Year] [nvarchar](4) NOT NULL,
	[Quarter] [smallint] NOT NULL,
	[Plant] [nvarchar](50) NOT NULL,
	[Scrap_sqft] [decimal](18, 2) NULL,
	[FGin_sqft] [decimal](18, 2) NULL,
	[Yield_Percentage] [float] NULL,
 CONSTRAINT [PK_KOI_Quarterly_Yield_trend_by_plant] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[Year] ASC,
	[Quarter] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

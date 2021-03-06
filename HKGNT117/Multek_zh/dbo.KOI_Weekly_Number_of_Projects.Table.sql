USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Weekly_Number_of_Projects]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_Weekly_Number_of_Projects](
	[ReportCode] [varchar](3) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Week] [smallint] NOT NULL,
	[Plant] [nvarchar](50) NOT NULL,
	[Sale] [nvarchar](50) NOT NULL,
	[Over1000Sqft] [int] NULL,
	[To501_1000Sqft] [int] NULL,
	[To301_500Sqft] [int] NULL,
	[To101_300Sqft] [int] NULL,
	[To100Sqft] [int] NULL,
	[Total] [int] NULL,
 CONSTRAINT [PK_KOI_Weekly_Number_of_Projects] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[Year] ASC,
	[Week] ASC,
	[Plant] ASC,
	[Sale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

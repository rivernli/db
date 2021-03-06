USE [BOC]
GO
/****** Object:  Table [dbo].[ttfgld006180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttfgld006180](
	[Fiscal_Year] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
	[End_date_of_last_Per] [nvarchar](50) NULL,
	[End_date_of_Last_Report] [nvarchar](50) NULL,
	[End_date_of_Last_Tax] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_ttfgld006180] PRIMARY KEY CLUSTERED 
(
	[Fiscal_Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

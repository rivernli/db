USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qry-datein-dateout]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qry-datein-dateout](
	[TN] [int] NULL,
	[DateSmplRcvd] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[Date Report Issued] [datetime] NULL,
	[location] [int] NULL,
	[Analyst] [int] NULL,
	[AnalyticalTest] [int] NULL,
	[WkCat] [nvarchar](50) NULL,
	[Category] [int] NULL
) ON [PRIMARY]

GO

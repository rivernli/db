USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryEdy-ENIG]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryEdy-ENIG](
	[TN] [int] NULL,
	[DateSmplRcvd] [datetime] NULL,
	[Sample descripton] [nvarchar](max) NULL,
	[ReportTitle] [nvarchar](150) NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[location] [int] NULL,
	[AnalyticalTest] [int] NULL,
	[Category] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

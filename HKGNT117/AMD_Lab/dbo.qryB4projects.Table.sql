USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryB4projects]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryB4projects](
	[TN] [int] NULL,
	[DateSmplRcvd] [datetime] NULL,
	[Category] [int] NULL,
	[AnalyticalTest] [int] NULL,
	[Applicant] [nvarchar](50) NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[Sample descripton] [nvarchar](max) NULL,
	[location] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

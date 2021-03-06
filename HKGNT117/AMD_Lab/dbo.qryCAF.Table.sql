USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryCAF]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryCAF](
	[TN] [int] NULL,
	[AnalyticalTest] [int] NULL,
	[DateSmplRcvd] [datetime] NULL,
	[location] [int] NULL,
	[Dept] [nvarchar](50) NULL,
	[Applicant] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](50) NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[Customer] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

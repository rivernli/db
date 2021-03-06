USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[Flex_Work]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flex_Work](
	[TN] [int] NULL,
	[DateSmplRcvd By Month] [nvarchar](255) NULL,
	[StartDate By Month] [nvarchar](255) NULL,
	[DueDate By Month] [nvarchar](255) NULL,
	[Date Report Issued By Month] [nvarchar](255) NULL,
	[Applicant] [nvarchar](50) NULL,
	[location] [int] NULL,
	[samplequan] [smallint] NULL,
	[First Of ProjDesc] [nvarchar](max) NULL,
	[First Of tblTimeSheet_TN] [int] NULL,
	[First Of Description] [nvarchar](max) NULL,
	[First Of Analyst] [int] NULL,
	[Sum Of Hours] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

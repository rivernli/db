USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryFlex_work]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryFlex_work](
	[tblAMDSamples_TN] [int] NULL,
	[DateSmplRcvd] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[Date Report Issued] [datetime] NULL,
	[Sample descripton] [nvarchar](max) NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[Applicant] [nvarchar](50) NULL,
	[location] [int] NULL,
	[samplequan] [smallint] NULL,
	[tblTimeSheet_TN] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Analyst] [int] NULL,
	[Hours] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

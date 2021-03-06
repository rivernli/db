USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[Paste Errors]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paste Errors](
	[TN] [float] NULL,
	[Bldg] [nvarchar](255) NULL,
	[Dept] [nvarchar](255) NULL,
	[Applicant] [nvarchar](255) NULL,
	[Customer] [nvarchar](255) NULL,
	[Project#] [nvarchar](255) NULL,
	[Test Name] [nvarchar](255) NULL,
	[Chamber] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[DateRec'd] [datetime] NULL,
	[Hours] [float] NULL,
	[Temp] [nvarchar](255) NULL,
	[%RH] [nvarchar](255) NULL,
	[StartDate] [datetime] NULL,
	[FinishDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[Leader] [nvarchar](255) NULL,
	[Notes] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

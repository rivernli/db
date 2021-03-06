USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryVC4034#3]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryVC4034#3](
	[Chamber] [nvarchar](255) NULL,
	[TN] [float] NULL,
	[Bldg] [nvarchar](255) NULL,
	[Dept] [nvarchar](255) NULL,
	[Applicant] [nvarchar](255) NULL,
	[Customer] [nvarchar](255) NULL,
	[Project#] [nvarchar](255) NULL,
	[TestName] [nvarchar](255) NULL,
	[Hours] [float] NULL,
	[Temp] [nvarchar](255) NULL,
	[%RH] [nvarchar](50) NULL,
	[DateReceived] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[DateIn] [datetime] NULL,
	[DateOut] [datetime] NULL,
	[Leader] [int] NULL,
	[Status] [int] NULL,
	[Notes] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

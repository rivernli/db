USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryIST-Pending-delete]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryIST-Pending-delete](
	[ProjectName] [nvarchar](50) NULL,
	[TN] [int] NULL,
	[Customer] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[DoneDate] [datetime] NULL,
	[MaxCycles] [int] NULL,
	[#samples] [int] NULL,
	[Status] [int] NULL,
	[ProjectCode] [nvarchar](50) NULL,
	[Applicant] [nvarchar](50) NULL,
	[Dept] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

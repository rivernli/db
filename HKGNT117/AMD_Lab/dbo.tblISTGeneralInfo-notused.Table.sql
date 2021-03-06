USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTGeneralInfo-notused]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblISTGeneralInfo-notused](
	[Project ID] [int] NOT NULL,
	[ProjectName] [nvarchar](50) NOT NULL,
	[TN] [int] NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[Customer] [nvarchar](50) NULL,
	[ContactName] [nvarchar](30) NULL,
	[Date] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[DoneDate] [datetime] NULL,
	[MaxCycles] [int] NULL,
	[#samples] [int] NULL,
	[ProjectCode] [nvarchar](50) NULL,
	[ISTTestLoc] [nvarchar](50) NULL,
	[Applicant] [nvarchar](50) NULL,
	[Dept] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[DocsFusionRpt#] [int] NULL,
	[ProcessMon] [bit] NOT NULL,
	[Qualification] [bit] NOT NULL,
	[Month] [nvarchar](50) NULL,
	[year] [smallint] NULL,
	[B1] [bit] NOT NULL,
	[B4] [bit] NOT NULL,
	[B5] [bit] NOT NULL,
	[Status] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

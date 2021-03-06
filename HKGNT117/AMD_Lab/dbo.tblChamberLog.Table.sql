USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblChamberLog]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChamberLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
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
	[Notes] [nvarchar](max) NULL,
	[Leader] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_tblChamberLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblCAFGenInfo]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCAFGenInfo](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](100) NOT NULL,
	[TN] [nvarchar](50) NULL,
	[TestMethod] [int] NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[Customer] [nvarchar](50) NULL,
	[ContactName] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Project#] [nvarchar](50) NULL,
	[ProductionPN] [nvarchar](50) NULL,
	[TestLoc] [nvarchar](50) NULL,
	[Applicant] [nvarchar](50) NULL,
	[Dept] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[ProjectClosed?] [bit] NOT NULL,
	[DocsFusionRpt#] [int] NULL,
	[Qualification] [bit] NOT NULL,
	[ReportName] [nvarchar](max) NULL,
	[PlatingThk] [smallint] NULL,
	[Roughness] [smallint] NULL,
	[DataLogger] [bit] NOT NULL,
	[DataLoggerIntvl] [int] NULL,
	[DecDrop] [bit] NOT NULL,
	[MinRes?] [bit] NOT NULL,
	[MinRes] [int] NULL,
	[THChamber] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblCAFGenInfo] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

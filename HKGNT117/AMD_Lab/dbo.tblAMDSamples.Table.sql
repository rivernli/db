USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblAMDSamples]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAMDSamples](
	[Primary Key] [int] IDENTITY(1,1) NOT NULL,
	[TN] [int] NOT NULL,
	[DateSmplRcvd] [smalldatetime] NULL,
	[StartDate] [smalldatetime] NULL,
	[DueDate] [smalldatetime] NULL,
	[Date Report Issued] [smalldatetime] NULL,
	[Sample descripton] [nvarchar](max) NULL,
	[Post Test Sample Ownership] [nvarchar](200) NULL,
	[ProjectName] [nvarchar](200) NULL,
	[ProjDesc] [nvarchar](max) NULL,
	[Field1] [nvarchar](200) NULL,
	[Material1] [nvarchar](200) NULL,
	[Material2] [nvarchar](200) NULL,
	[Material3] [nvarchar](200) NULL,
	[Material4] [nvarchar](200) NULL,
	[Customer] [nvarchar](200) NULL,
	[Project#] [nvarchar](200) NULL,
	[Applicant] [nvarchar](200) NULL,
	[location] [int] NULL,
	[Dept] [nvarchar](200) NULL,
	[Manager] [nvarchar](200) NULL,
	[Analyst] [int] NULL,
	[AnalyticalTest] [int] NULL,
	[WkCat] [nvarchar](200) NULL,
	[Category] [int] NULL,
	[ReportTitle] [nvarchar](200) NULL,
	[YrBook] [bit] NOT NULL CONSTRAINT [DF_tblAMDSamples_YrBook]  DEFAULT ((0)),
	[samplequan] [smallint] NULL,
	[FPC?] [bit] NOT NULL CONSTRAINT [DF_tblAMDSamples_FPC?]  DEFAULT ((0)),
	[ClimateChamber] [bit] NOT NULL CONSTRAINT [DF_tblAMDSamples_ClimateChamber]  DEFAULT ((0)),
	[LLTS] [bit] NOT NULL CONSTRAINT [DF_tblAMDSamples_LLTS]  DEFAULT ((0)),
	[month] [nvarchar](10) NULL,
	[year] [smallint] NULL,
	[Sampletype] [nvarchar](50) NULL,
	[TestTimeSum] [nvarchar](50) NULL,
	[CalculationsTimeSum] [nvarchar](50) NULL,
	[SampleQuantity] [varchar](50) NULL,
 CONSTRAINT [PK_tblAMDSamples_1] PRIMARY KEY CLUSTERED 
(
	[TN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

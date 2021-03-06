USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblLaminateProjects]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLaminateProjects](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[TN] [int] NULL,
	[MulPN] [nvarchar](50) NULL,
	[CustPN] [nvarchar](50) NULL,
	[Cust] [nvarchar](50) NULL,
	[Bldg] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[qualnumber] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[ReporTitle] [nvarchar](255) NULL,
	[Department] [nvarchar](50) NULL,
	[RequestorName] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](200) NULL,
 CONSTRAINT [PK_tblLaminateProjects] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblAnalyst]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAnalyst](
	[AnalystID] [int] IDENTITY(1,1) NOT NULL,
	[Analyst] [nvarchar](50) NULL,
	[Current] [bit] NOT NULL,
	[EmpID] [int] NULL,
	[Title] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblAnalyst] PRIMARY KEY CLUSTERED 
(
	[AnalystID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

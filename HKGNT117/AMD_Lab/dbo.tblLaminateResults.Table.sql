USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblLaminateResults]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLaminateResults](
	[SampleID] [int] IDENTITY(1,1) NOT NULL,
	[SampleName] [nvarchar](50) NOT NULL,
	[Laminate] [nvarchar](50) NULL,
	[TN] [int] NOT NULL,
	[DSCTg1] [real] NULL,
	[DSCTg2] [real] NULL,
	[DSCTgD] [real] NULL,
	[TMATg1] [real] NULL,
	[TMATg2] [real] NULL,
	[TMACTElow] [int] NULL,
	[TMACTEhi] [int] NULL,
	[T260] [nvarchar](50) NULL,
	[T288] [nvarchar](50) NULL,
	[ResinContent] [int] NULL,
	[DC] [nvarchar](50) NULL,
	[thickness] [real] NULL,
	[Td5] [real] NULL,
	[Td05] [real] NULL,
 CONSTRAINT [PK_tblLaminateResults] PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

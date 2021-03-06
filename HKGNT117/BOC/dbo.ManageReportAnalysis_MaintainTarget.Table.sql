USE [BOC]
GO
/****** Object:  Table [dbo].[ManageReportAnalysis_MaintainTarget]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManageReportAnalysis_MaintainTarget](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Target] [nvarchar](50) NULL,
	[FiscalYear] [nvarchar](50) NULL,
	[Cyc] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[Value] [nvarchar](50) NULL,
 CONSTRAINT [PK_ManageReportAnalysis_MaintainTarget] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

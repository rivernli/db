USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblTimeSheet]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTimeSheet](
	[timesheet_ID] [int] IDENTITY(1,1) NOT NULL,
	[TN] [int] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Analyst] [int] NULL,
	[Hours] [real] NULL,
 CONSTRAINT [PK_tblTimeSheet] PRIMARY KEY CLUSTERED 
(
	[timesheet_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

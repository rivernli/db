USE [BOC]
GO
/****** Object:  Table [dbo].[Week_Period]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Week_Period](
	[Fiscal_Year] [int] NOT NULL,
	[Fiscal_Period] [int] NOT NULL,
	[Week_Period] [nvarchar](50) NULL,
 CONSTRAINT [PK_week_period121108150409] PRIMARY KEY CLUSTERED 
(
	[Fiscal_Year] ASC,
	[Fiscal_Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

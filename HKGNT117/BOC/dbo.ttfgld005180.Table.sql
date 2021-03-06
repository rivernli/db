USE [BOC]
GO
/****** Object:  Table [dbo].[ttfgld005180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttfgld005180](
	[Period_Type] [nvarchar](50) NOT NULL,
	[FYear] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[Period_Start_Date] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Correction_Period] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_ttfgld005180] PRIMARY KEY CLUSTERED 
(
	[Period_Type] ASC,
	[FYear] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

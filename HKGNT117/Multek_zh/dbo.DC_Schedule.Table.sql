USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[DC_Schedule]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DC_Schedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Days] [int] NULL,
	[Time] [varchar](20) NULL,
	[Email] [varchar](4000) NULL,
	[PrevExecutionTime] [varchar](20) NULL,
	[NextExecutionTime] [varchar](20) NULL,
 CONSTRAINT [PK_DC_Schedule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MRB_Log]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRB_Log](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NULL,
	[IP] [varchar](50) NULL,
	[Action] [varchar](50) NULL,
	[ActionDate] [datetime] NULL,
	[ActionUrl] [varchar](500) NULL,
	[ActionDetail] [varchar](2000) NULL,
 CONSTRAINT [PK_MRB_Log] PRIMARY KEY NONCLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

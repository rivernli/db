USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MG_EMailHistory]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MG_EMailHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[ServerName] [varchar](50) NULL,
	[Warning] [varchar](1000) NULL,
	[EmailTO] [varchar](max) NULL,
	[EmailCC] [varchar](max) NULL,
	[EmailBCC] [varchar](max) NULL,
	[HistoryID] [bigint] NULL,
	[CreateTime] [varchar](20) NULL CONSTRAINT [DF_EMailHistory_Time]  DEFAULT (getdate()),
	[Finished] [bit] NULL CONSTRAINT [DF_EMailHistory_Finished]  DEFAULT ((0)),
	[FinishedTime] [varchar](20) NULL,
 CONSTRAINT [PK_EMailHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

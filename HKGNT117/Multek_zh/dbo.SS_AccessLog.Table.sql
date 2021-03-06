USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SS_AccessLog]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_AccessLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[AccessPage] [varchar](150) NULL,
	[AccessDate] [datetime] NULL CONSTRAINT [DF_SS_AccessLog_AccessDate]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SS_ShutdownLog]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_ShutdownLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NULL,
	[ShutdownTime] [varchar](50) NULL,
	[Message] [nvarchar](1000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

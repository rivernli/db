USE [DBMonitor]
GO
/****** Object:  Table [dbo].[querytemp]    Script Date: 11/06/2014 15:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[querytemp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [varchar](100) NULL,
	[Parameters] [int] NULL,
	[Eventinfo] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

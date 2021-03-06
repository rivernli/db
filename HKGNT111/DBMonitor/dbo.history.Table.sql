USE [DBMonitor]
GO
/****** Object:  Table [dbo].[history]    Script Date: 11/06/2014 15:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[history](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[session] [varchar](5) NOT NULL,
	[eventinfo] [varchar](max) NULL,
	[time] [datetime] NULL,
	[hostname] [varchar](100) NULL,
	[blocked] [varchar](max) NULL,
	[HostBlocked] [varchar](100) NULL,
	[dbname] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

USE [DBMonitor]
GO
/****** Object:  Table [dbo].[query2]    Script Date: 11/06/2014 15:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[query2](
	[sesion] [varchar](10) NOT NULL,
	[dbname] [varchar](50) NULL,
	[Eventinfo] [varchar](2048) NOT NULL,
	[Host] [varchar](100) NULL,
	[Blocked] [varchar](2048) NULL,
	[HostBlocked] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

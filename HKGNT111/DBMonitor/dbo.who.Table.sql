USE [DBMonitor]
GO
/****** Object:  Table [dbo].[who]    Script Date: 11/06/2014 15:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[who](
	[spid] [int] NULL,
	[status] [varchar](50) NULL,
	[login] [varchar](50) NULL,
	[hostname] [varchar](50) NULL,
	[blkby] [varchar](4) NULL,
	[dbname] [varchar](50) NULL,
	[command] [varchar](255) NULL,
	[cputime] [int] NULL,
	[diskio] [int] NULL,
	[lastbatch] [varchar](50) NULL,
	[programname] [varchar](255) NULL,
	[spid2] [int] NULL,
	[request] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

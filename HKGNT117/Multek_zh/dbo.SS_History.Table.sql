USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SS_History]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[ServerName] [varchar](50) NULL,
	[Ping] [varchar](200) NULL,
	[CPUUsage] [varchar](200) NULL,
	[HardDisk] [varchar](200) NULL,
	[PhysicalMemory] [varchar](200) NULL,
	[CreateTime] [varchar](20) NULL CONSTRAINT [DF_SS_History_CreateTime]  DEFAULT (getdate()),
	[Warning] [varchar](1000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

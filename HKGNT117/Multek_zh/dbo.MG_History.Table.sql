USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MG_History]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MG_History](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[ServerName] [varchar](50) NULL,
	[Ping] [varchar](200) NULL,
	[CPUUsage] [varchar](200) NULL,
	[HardDisk] [varchar](200) NULL,
	[PhysicalMemory] [varchar](200) NULL,
	[CreateTime] [varchar](20) NULL CONSTRAINT [DF_History_QueryTime]  DEFAULT (getdate()),
	[PingTime] [varchar](20) NULL,
	[WMITime] [varchar](20) NULL,
	[Warning] [varchar](1000) NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

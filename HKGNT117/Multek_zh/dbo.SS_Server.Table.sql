USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SS_Server]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_Server](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](50) NULL,
	[Address] [varchar](200) NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](100) NULL,
	[Enabled] [bit] NULL,
	[PingMessage] [varchar](200) NULL,
	[CPUUsageMessage] [varchar](200) NULL,
	[HardDiskMessage] [varchar](200) NULL,
	[PhysicalMemoryMessage] [varchar](200) NULL,
	[Warning] [varchar](1000) NULL,
	[CreateTime] [varchar](20) NULL,
	[UpdataTime] [varchar](20) NULL,
	[LogInterval] [int] NULL,
	[SendEmail] [bit] NULL,
	[EmailAddress] [varchar](1000) NULL,
	[PingFailed] [bit] NULL,
	[RoundTripTimes] [int] NULL,
	[AvilableMemory] [int] NULL,
	[SystemDisk] [int] NULL,
	[CPUUsage] [int] NULL,
 CONSTRAINT [PK_SS_Server] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SS_Server] ADD  CONSTRAINT [DF_SS_Server_Enabled]  DEFAULT ((0)) FOR [Enabled]
GO

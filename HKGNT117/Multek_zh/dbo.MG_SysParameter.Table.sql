USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MG_SysParameter]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MG_SysParameter](
	[LogInterval] [int] NULL,
	[SendEmail] [bit] NULL,
	[EmailTO] [varchar](max) NULL,
	[EmailCC] [varchar](max) NULL,
	[EmailBCC] [varchar](max) NULL,
	[PingFailed] [bit] NULL,
	[RoundTripTimes] [int] NULL,
	[AvilableMemory] [int] NULL,
	[SystemDisk] [int] NULL,
	[CPUUsage] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

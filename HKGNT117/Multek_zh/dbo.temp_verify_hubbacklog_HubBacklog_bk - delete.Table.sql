USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[temp_verify_hubbacklog_HubBacklog_bk - delete]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[temp_verify_hubbacklog_HubBacklog_bk - delete](
	[T$ORNO] [float] NULL,
	[T$PONO] [float] NULL,
	[T$ITEM] [char](32) NULL,
	[T$ECDT] [char](30) NULL,
	[FG_avaible] [float] NULL,
	[T$AMNT] [float] NULL,
	[T$DDTA] [datetime] NULL,
	[T$PLNT] [char](2) NULL,
	[T$CDSC] [char](35) NULL,
	[T$DATE] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

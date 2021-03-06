USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vw_4RP_HubBacklog_ext_20111208]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vw_4RP_HubBacklog_ext_20111208](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$ECDT] [char](30) NOT NULL,
	[FG_avaible] [float] NULL,
	[T$AMNT] [float] NOT NULL,
	[T$DDTA] [datetime] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CDSC] [char](35) NOT NULL,
	[iPeriod] [int] NULL,
	[iDate] [varchar](8) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

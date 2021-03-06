USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[HubBacklog]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HubBacklog](
	[T$ORNO] [float] NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$ECDT] [char](30) NOT NULL,
	[FG_avaible] [float] NULL,
	[T$AMNT] [float] NOT NULL,
	[T$DDTA] [datetime] NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$CDSC] [char](35) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

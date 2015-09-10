USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_ProcessMapMaxtrix]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_ProcessMapMaxtrix](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](10) NULL,
	[Project] [varchar](50) NULL,
	[WorkCenter] [varchar](10) NULL,
	[SubWorkCenter] [varchar](10) NULL,
	[FlowCount] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

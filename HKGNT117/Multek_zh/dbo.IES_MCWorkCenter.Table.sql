USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_MCWorkCenter]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_MCWorkCenter](
	[Building] [varchar](10) NOT NULL,
	[WorkCenter] [varchar](50) NOT NULL,
	[SubWorkCenter] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_Project_Map_Tech]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_Project_Map_Tech](
	[T$PLNT] [char](3) NOT NULL,
	[T$PJNO] [char](10) NOT NULL,
	[T$TECH] [char](30) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

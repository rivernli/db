USE [BOC]
GO
/****** Object:  Table [dbo].[TempIndex]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TempIndex](
	[INDEX_NAME] [varchar](5000) NULL,
	[INDEX_DESCRIPTION] [varchar](5000) NULL,
	[INDEX_KEYS] [varchar](5000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

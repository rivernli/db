USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MaterialInventory_Menu]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MaterialInventory_Menu](
	[ID] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[Page] [varchar](500) NULL,
	[Target] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

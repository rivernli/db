USE [BOC]
GO
/****** Object:  Table [dbo].[Authority_User_bk_2012_1_13]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authority_User_bk_2012_1_13](
	[userid] [nvarchar](50) NOT NULL,
	[username] [nvarchar](50) NULL,
	[role] [int] NULL,
	[price] [int] NULL
) ON [PRIMARY]

GO

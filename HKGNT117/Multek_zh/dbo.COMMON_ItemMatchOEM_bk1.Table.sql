USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[COMMON_ItemMatchOEM_bk1]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMMON_ItemMatchOEM_bk1](
	[ITEM] [nvarchar](55) NOT NULL,
	[OEM] [nvarchar](6) NULL,
	[OEM_Name] [nvarchar](50) NULL
) ON [PRIMARY]

GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EHS_post_description]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EHS_post_description](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Content_Text] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

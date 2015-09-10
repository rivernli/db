USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Menu]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[B1Parts_Menu](
	[ID] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[Page] [varchar](500) NULL,
	[Modoul] [varchar](200) NULL,
 CONSTRAINT [PK_B1Parts_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

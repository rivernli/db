USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Tracibility_Menu]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Tracibility_Menu](
	[ID] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[Page] [varchar](500) NULL,
 CONSTRAINT [Tracibility_PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

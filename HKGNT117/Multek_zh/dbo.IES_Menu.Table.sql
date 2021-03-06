USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_Menu]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_Menu](
	[ID] [varchar](50) NOT NULL,
	[ParentID] [varchar](50) NULL,
	[Description] [varchar](50) NOT NULL,
	[Page] [varchar](50) NULL,
	[Module] [varchar](50) NOT NULL,
	[Icon] [varchar](20) NULL,
	[Sort] [varchar](50) NULL,
 CONSTRAINT [PK_IES_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

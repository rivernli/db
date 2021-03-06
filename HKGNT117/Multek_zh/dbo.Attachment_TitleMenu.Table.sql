USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Attachment_TitleMenu]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachment_TitleMenu](
	[Lsh] [nvarchar](50) NOT NULL CONSTRAINT [DF_Attachment_TitleMenu_Lsh]  DEFAULT ((0)),
	[PLsh] [nvarchar](50) NULL,
	[NodeName] [nvarchar](50) NULL,
	[SN] [int] NULL,
 CONSTRAINT [PK_Attachment_TitleMenu] PRIMARY KEY CLUSTERED 
(
	[Lsh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

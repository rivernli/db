USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[UMS_Individual]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UMS_Individual](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[file_content] [nvarchar](max) NULL,
 CONSTRAINT [PK_UMS_Individual] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

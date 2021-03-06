USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Index_Introduction]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SQM_Index_Introduction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MenuID] [varchar](50) NULL,
	[Introduction] [nvarchar](max) NULL,
 CONSTRAINT [PK_SQM_Index_Introduction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

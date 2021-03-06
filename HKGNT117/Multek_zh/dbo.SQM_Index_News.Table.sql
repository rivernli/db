USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Index_News]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_Index_News](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[news_Title] [nvarchar](200) NULL,
	[news_Content] [nvarchar](max) NULL,
	[news_Author] [nvarchar](50) NULL,
	[new_Date] [datetime] NULL CONSTRAINT [DF_SQM_Index_News_new_Date]  DEFAULT (getdate()),
 CONSTRAINT [PK_SQM_Index_News] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

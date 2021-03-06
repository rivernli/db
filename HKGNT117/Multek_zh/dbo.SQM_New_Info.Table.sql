USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_New_Info]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_New_Info](
	[info_ID] [int] IDENTITY(1,1) NOT NULL,
	[info_Title] [nvarchar](200) NULL,
	[info_content] [nvarchar](max) NULL,
	[info_ImgUrl] [nvarchar](200) NULL,
	[info_Author] [nvarchar](50) NULL,
	[info_Date] [datetime] NULL,
 CONSTRAINT [PK_SQM_New_Info] PRIMARY KEY CLUSTERED 
(
	[info_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[SQM_New_Info] ADD  CONSTRAINT [DF_SQM_New_Info_info_Date]  DEFAULT (getdate()) FOR [info_Date]
GO

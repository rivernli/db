USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Attachment_upFiles_Logs]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachment_upFiles_Logs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileID] [nvarchar](50) NULL,
	[Downloaded] [nvarchar](50) NULL,
	[Downloaded_Date] [datetime] NULL,
 CONSTRAINT [PK_Attachment_upFiles_Logs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Attachment_upFiles_Logs] ADD  CONSTRAINT [DF_Attachment_upFiles_Logs_Downloaded_Date]  DEFAULT (getdate()) FOR [Downloaded_Date]
GO

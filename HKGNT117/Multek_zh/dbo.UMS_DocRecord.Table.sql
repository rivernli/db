USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[UMS_DocRecord]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UMS_DocRecord](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Doc_Name] [nvarchar](200) NULL,
	[NewName] [nvarchar](50) NULL,
	[Doc_Text] [nvarchar](max) NULL,
	[DocTextString] [nvarchar](max) NULL,
	[Doc_Dir] [nvarchar](50) NULL,
	[Uploaded] [nvarchar](50) NULL,
	[UploadedDate] [datetime] NULL CONSTRAINT [DF_UMS_DocRecord_UploadedDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_UMS_DocRecord] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

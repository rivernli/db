USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QuotationUploadFile_upFiles]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[QuotationUploadFile_upFiles](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PkID] [varchar](50) NULL,
	[orgName] [nvarchar](255) NOT NULL,
	[newName] [varchar](35) NULL,
	[FileType] [varchar](15) NULL,
	[FileSize] [bigint] NULL,
	[FileDir] [nvarchar](60) NULL,
	[AuthorID] [nvarchar](50) NULL,
	[UploadData] [datetime] NULL,
	[FileDescription] [nvarchar](max) NULL,
	[Downloaded] [nvarchar](max) NULL,
 CONSTRAINT [PK_QuotationUploadFile_upFiles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[QuotationUploadFile_upFiles] ADD  CONSTRAINT [DF_QuotationUploadFile_upFiles_UploadData]  DEFAULT (getdate()) FOR [UploadData]
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[UMS_upFiles]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UMS_upFiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PkID] [varchar](25) NULL,
	[orgName] [nvarchar](255) NULL,
	[newName] [varchar](35) NULL,
	[FileSize] [bigint] NULL,
	[FileType] [varchar](15) NULL,
	[FileDir] [varchar](60) NULL,
	[AuthorID] [nvarchar](50) NULL,
	[UploadData] [varchar](25) NULL,
 CONSTRAINT [PK_UMS_upFiles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

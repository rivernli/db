USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[E_quote_upFiles]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[E_quote_upFiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PkID] [varchar](50) NULL,
	[orgName] [nvarchar](255) NOT NULL,
	[newName] [varchar](35) NULL,
	[FileType] [varchar](15) NULL,
	[FileSize] [bigint] NULL,
	[FileDir] [nvarchar](60) NULL,
	[UploadData] [datetime] NULL,
 CONSTRAINT [PK_E_quote_upFiles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

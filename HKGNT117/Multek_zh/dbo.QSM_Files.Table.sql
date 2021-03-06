USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[QSM_Files]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QSM_Files](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RelationKey] [varchar](20) NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[SourceName] [nvarchar](100) NOT NULL,
	[Folder] [varchar](50) NULL,
	[FileSize] [bigint] NOT NULL,
	[FileType] [varchar](10) NULL,
	[Hash] [varchar](50) NULL,
	[IsAlbum] [int] NOT NULL CONSTRAINT [DF_QSM_Files_IsAlbum]  DEFAULT ((0)),
	[IsSwf] [int] NOT NULL CONSTRAINT [DF_QSM_Files_IsSwf]  DEFAULT ((0)),
	[CreateTime] [datetime] NULL CONSTRAINT [DF_QSM_Files_CreateTime]  DEFAULT (getdate()),
	[Creator] [varchar](50) NULL,
 CONSTRAINT [PK_QSM_Files] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

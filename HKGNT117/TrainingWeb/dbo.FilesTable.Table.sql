USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[FilesTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilesTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[parentId] [int] NULL,
	[Type] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[Url] [nvarchar](255) NULL,
	[user] [nvarchar](255) NULL,
 CONSTRAINT [PK_FilesTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

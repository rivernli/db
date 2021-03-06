USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ProductWarranty_Attachment]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductWarranty_Attachment](
	[FileId] [uniqueidentifier] NOT NULL,
	[WarrantyId] [uniqueidentifier] NULL,
	[FileName] [nvarchar](200) NULL,
	[FileType] [varchar](150) NULL,
	[FileSize] [int] NULL,
	[AttachedBy] [uniqueidentifier] NULL,
	[AttachedDate] [datetime] NULL,
 CONSTRAINT [PK_ProductWarranty_Attachment] PRIMARY KEY NONCLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

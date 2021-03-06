USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[Quotation_List]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Quotation_List](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Lsh] [varchar](20) NULL,
	[FileName] [nvarchar](50) NULL,
	[NewName] [varchar](20) NULL,
	[Uploaded] [nvarchar](50) NULL,
	[UploadDate] [datetime] NULL,
 CONSTRAINT [PK_Quotation_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Quotation_List] ADD  CONSTRAINT [DF_Quotation_List_UploadDate]  DEFAULT (getdate()) FOR [UploadDate]
GO

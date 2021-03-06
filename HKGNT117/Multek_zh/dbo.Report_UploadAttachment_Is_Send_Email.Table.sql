USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Report_UploadAttachment_Is_Send_Email]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Report_UploadAttachment_Is_Send_Email](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MenuID] [varchar](50) NULL,
	[IsTag] [bit] NULL CONSTRAINT [DF_Report_UploadAttachment_Is_Send_Email_IsTag]  DEFAULT ((0)),
 CONSTRAINT [PK_Report_UploadAttachment_Is_Send_Email] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

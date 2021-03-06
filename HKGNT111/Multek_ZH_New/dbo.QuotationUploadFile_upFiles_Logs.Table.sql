USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QuotationUploadFile_upFiles_Logs]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[QuotationUploadFile_upFiles_Logs](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FileID] [varchar](50) NULL,
	[Downloaded] [nvarchar](max) NULL,
	[Downloaded_Date] [datetime] NULL,
 CONSTRAINT [PK_QuotationUploadFile_upFiles_Logs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[QuotationUploadFile_upFiles_Logs] ADD  CONSTRAINT [DF_QuotationUploadFile_upFiles_Logs_Downloaded_Date]  DEFAULT (getdate()) FOR [Downloaded_Date]
GO

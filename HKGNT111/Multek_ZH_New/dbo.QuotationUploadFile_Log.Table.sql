USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QuotationUploadFile_Log]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[QuotationUploadFile_Log](
	[AutoID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Operation] [varchar](50) NOT NULL,
	[OperatedDate] [datetime] NOT NULL,
	[Remark] [varchar](500) NULL,
 CONSTRAINT [PK_QuotationUploadFile_Log] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[QuotationUploadFile_Log] ADD  CONSTRAINT [DF_QuotationUploadFile_Log_OperatedDate]  DEFAULT (getdate()) FOR [OperatedDate]
GO

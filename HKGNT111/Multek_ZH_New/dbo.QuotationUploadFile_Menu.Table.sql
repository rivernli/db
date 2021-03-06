USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QuotationUploadFile_Menu]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[QuotationUploadFile_Menu](
	[ID] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[Page] [varchar](500) NULL,
	[Modoul] [varchar](200) NULL,
 CONSTRAINT [PK_QuotationUploadFile_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

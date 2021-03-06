USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[E_quote_Supplier_guestbook_Reply]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[E_quote_Supplier_guestbook_Reply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Pur_Id] [int] NULL,
	[guestbookId] [int] NULL,
	[Email] [nvarchar](50) NULL,
	[Posted_Date] [datetime] NULL,
	[Ip_address] [varchar](50) NULL,
	[Remark] [nvarchar](max) NULL,
	[Attachment] [nvarchar](50) NULL,
 CONSTRAINT [PK_E_quote_Supplier_guestbook_Reply] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

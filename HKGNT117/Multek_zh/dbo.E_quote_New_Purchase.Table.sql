USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[E_quote_New_Purchase]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[E_quote_New_Purchase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subject] [nvarchar](200) NULL,
	[supplier] [nvarchar](max) NULL,
	[SupplierEmail] [nvarchar](max) NULL,
	[Pur_Content] [nvarchar](max) NULL,
	[Initiator] [nvarchar](50) NULL,
	[Initiator_Date] [datetime] NULL,
	[Modify] [nvarchar](50) NULL,
	[Modify_Date] [datetime] NULL,
	[ViewState] [bit] NULL CONSTRAINT [DF_E_quote_Create_purchase_order_ViewState]  DEFAULT ((0)),
	[Views] [int] NULL,
	[Attachment] [nvarchar](50) NULL,
	[End_date] [datetime] NULL,
	[EndDateState] [bit] NULL CONSTRAINT [DF_E_quote_New_Purchase_EndDateState]  DEFAULT ((0)),
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK_E_quote_Create_purchase_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

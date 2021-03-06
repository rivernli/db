USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[E_quote_supplier_group]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[E_quote_supplier_group](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierGroup] [nvarchar](50) NULL,
	[CreateUser] [varchar](50) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_E_quote_supplier_group_CreateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_E_quote_supplier_group] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

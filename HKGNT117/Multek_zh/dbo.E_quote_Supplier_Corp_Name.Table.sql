USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[E_quote_Supplier_Corp_Name]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[E_quote_Supplier_Corp_Name](
	[SupplierCorpId] [int] IDENTITY(1,1) NOT NULL,
	[SupplierCorpName] [nvarchar](50) NULL,
 CONSTRAINT [PK_E_quote_Supplier_Corp_Name] PRIMARY KEY CLUSTERED 
(
	[SupplierCorpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

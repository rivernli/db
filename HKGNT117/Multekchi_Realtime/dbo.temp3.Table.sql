USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[temp3]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[temp3](
	[oem_name] [char](30) NOT NULL,
	[part_no] [char](30) NOT NULL,
	[prj_no] [char](32) NOT NULL,
	[po_no] [char](30) NOT NULL,
	[UnitPrice] [decimal](15, 4) NULL,
	[po_date] [datetime] NULL,
	[cust_req_date] [datetime] NULL,
	[invoice_date] [datetime] NULL,
	[currency] [char](3) NOT NULL,
	[del_qty] [float] NOT NULL,
	[del_sqft] [decimal](15, 4) NULL,
	[Del_Amt_USD] [decimal](15, 4) NULL,
	[ship_to_cty] [char](30) NOT NULL,
	[order_type] [char](3) NOT NULL,
	[sale_type] [char](4) NOT NULL,
	[Unit_panel] [float] NOT NULL,
	[invoice_no] [int] NULL,
	[baan_so] [nvarchar](10) NULL,
	[site] [varchar](2) NOT NULL,
	[warehouse] [char](3) NOT NULL,
	[ast_so] [char](30) NOT NULL,
	[cust_code] [char](6) NOT NULL,
	[product_name] [char](30) NULL,
	[Del_Code] [varchar](50) NULL,
	[Project_type] [varchar](12) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

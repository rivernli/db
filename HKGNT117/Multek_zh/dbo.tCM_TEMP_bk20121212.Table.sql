USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[tCM_TEMP_bk20121212]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tCM_TEMP_bk20121212](
	[company] [varchar](50) NULL,
	[customer] [nvarchar](50) NULL,
	[delivery] [nvarchar](50) NULL,
	[selling_org] [nvarchar](50) NULL,
	[selling_org_del] [nvarchar](50) NULL,
	[del_cust] [nvarchar](100) NULL,
	[del_addr] [nvarchar](255) NULL,
	[bill_cust] [nvarchar](100) NULL,
	[bill_addr] [nvarchar](255) NULL,
	[currency] [nvarchar](50) NULL,
	[fin_grp] [nvarchar](50) NULL,
	[fin_desc] [nvarchar](255) NULL,
	[terms_pay] [nvarchar](100) NULL,
	[terms_del] [nvarchar](100) NULL,
	[cust_status] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

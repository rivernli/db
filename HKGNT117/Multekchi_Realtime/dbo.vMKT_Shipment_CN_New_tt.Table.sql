USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[vMKT_Shipment_CN_New_tt]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vMKT_Shipment_CN_New_tt](
	[BaaN_SO] [nvarchar](10) NULL,
	[Prj_No] [char](32) NOT NULL,
	[Part_No] [char](30) NOT NULL,
	[PO_No] [char](30) NOT NULL,
	[Invoice_No] [int] NULL,
	[Del_Qty] [float] NOT NULL,
	[Invoice_Date] [datetime] NULL,
	[UnitPrice] [decimal](15, 4) NULL,
	[Currency] [char](3) NOT NULL,
	[Del_Amt_USD] [decimal](15, 4) NULL,
	[Del_SqFt] [decimal](15, 4) NULL,
	[Ship_To_Cty] [char](30) NOT NULL,
	[Cust_Code] [char](6) NOT NULL,
	[OEM_NAME] [char](30) NOT NULL,
	[CEM_NAME] [char](35) NOT NULL,
	[AST_SO] [char](30) NOT NULL,
	[PO_Date] [datetime] NULL,
	[Cust_Req_Date] [datetime] NULL,
	[Order_type] [char](3) NOT NULL,
	[Warehouse] [char](3) NOT NULL,
	[Site] [varchar](2) NOT NULL,
	[SALE_TYPE] [char](4) NOT NULL,
	[Financial_Group] [char](30) NOT NULL,
	[Unit_Panel] [float] NOT NULL,
	[Product_Name] [char](30) NULL,
	[Flex_Order] [float] NOT NULL,
	[Segment] [char](6) NOT NULL,
	[Segment_Description] [char](30) NOT NULL,
	[Del_Code] [varchar](50) NULL,
	[Project_Type] [varchar](12) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

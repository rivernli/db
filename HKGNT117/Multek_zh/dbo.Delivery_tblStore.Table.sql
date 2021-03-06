USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Delivery_tblStore]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Delivery_tblStore](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[P_ID] [int] NULL CONSTRAINT [DF_tblStore_P_ID]  DEFAULT ((0)),
	[DeliveryID] [int] NULL,
	[Vendor] [nvarchar](50) NULL,
	[Material_Numbers] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[StoreType] [nvarchar](50) NULL,
	[Units] [nvarchar](50) NULL,
	[Quantity] [varchar](10) NULL,
	[Date_requested] [datetime] NULL,
	[Note] [nvarchar](max) NULL,
	[Operation_dates] [datetime] NULL,
	[Operation_people] [nvarchar](50) NULL,
	[State] [bigint] NULL CONSTRAINT [DF_tblStore_State]  DEFAULT ((0)),
	[Effective_date] [datetime] NULL,
	[Actual_receiving] [numeric](18, 0) NULL,
	[Tax_Category] [nvarchar](20) NULL,
	[Confirm_receipt] [varchar](1) NULL,
	[Confirm_Date] [datetime] NULL,
	[Confirmor] [nvarchar](50) NULL,
	[Send_material] [numeric](18, 0) NULL,
	[Send_material_people] [nvarchar](20) NULL,
	[Send_material_Date] [datetime] NULL,
	[process] [nvarchar](50) NULL,
	[MRU] [nvarchar](20) NULL,
	[Remainder] [numeric](18, 0) NULL,
	[Completion] [bigint] NULL CONSTRAINT [DF_tblStore_Completion]  DEFAULT ((0)),
	[DN_NO] [nvarchar](100) NULL,
	[Receivingdate] [datetime] NULL,
	[Modeoftransport] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblStore] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

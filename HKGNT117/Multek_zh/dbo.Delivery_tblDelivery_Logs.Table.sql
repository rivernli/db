USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Delivery_tblDelivery_Logs]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Delivery_tblDelivery_Logs](
	[LogsID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[P_ID] [int] NULL,
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
	[State] [bigint] NULL,
	[Effective_date] [datetime] NULL,
	[Actual_receiving] [nvarchar](20) NULL,
	[Tax_Category] [nvarchar](20) NULL,
	[Confirm_receipt] [varchar](1) NULL,
	[Confirm_Date] [datetime] NULL,
	[Confirmor] [nvarchar](50) NULL,
	[Send_material] [varchar](20) NULL,
	[Send_material_people] [nvarchar](20) NULL,
	[Send_material_Date] [datetime] NULL,
	[process] [nvarchar](50) NULL,
	[MRU] [nvarchar](20) NULL,
	[Remainder] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblDelivery_Logs] PRIMARY KEY CLUSTERED 
(
	[LogsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Delivery_tblDelivery_Logs] ADD  CONSTRAINT [DF_tblDelivery_Logs_P_ID]  DEFAULT ((0)) FOR [P_ID]
GO
ALTER TABLE [dbo].[Delivery_tblDelivery_Logs] ADD  CONSTRAINT [DF_tblDelivery_Logs_State]  DEFAULT ((0)) FOR [State]
GO

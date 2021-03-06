USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Delivery_tblDelivery]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Delivery_tblDelivery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
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
	[State] [bigint] NULL CONSTRAINT [DF_tblDelivery_State]  DEFAULT ((0)),
 CONSTRAINT [PK_tblDelivery] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

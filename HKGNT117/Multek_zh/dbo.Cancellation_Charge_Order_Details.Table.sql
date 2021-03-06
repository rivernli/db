USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Charge_Order_Details]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Charge_Order_Details](
	[ID] [int] NOT NULL,
	[T$ORNO] [nvarchar](6) NOT NULL,
	[T$PONO] [nvarchar](4) NOT NULL,
	[T$ITEM] [nvarchar](50) NULL,
	[T$DDTA] [datetime] NULL,
	[T$PLNT] [nvarchar](5) NULL,
	[T$OQUA] [int] NULL,
	[T$BQUA] [int] NULL,
	[T$CCUR] [nvarchar](5) NULL,
	[T$PRIC] [decimal](18, 4) NULL,
	[T$COPR] [decimal](18, 4) NULL,
	[T$ECDT] [nvarchar](30) NULL,
	[T$DATE] [datetime] NULL,
	[T$MESTAT] [nvarchar](15) NULL,
 CONSTRAINT [PK_Cancellation_Charge_Order_Details] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[T$ORNO] ASC,
	[T$PONO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Layer]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Layer](
	[Year] [varchar](4) NOT NULL,
	[column_1] [numeric](18, 2) NULL,
	[column_2] [numeric](18, 2) NULL,
	[column_3] [numeric](18, 2) NULL,
	[column_4] [numeric](18, 2) NULL,
	[column_5] [numeric](18, 2) NULL,
	[column_6] [numeric](18, 2) NULL,
	[column_7] [numeric](18, 2) NULL,
	[column_8] [numeric](18, 2) NULL,
	[Column_9] [numeric](18, 2) NULL,
	[column_10] [numeric](18, 2) NULL,
	[Column_11] [numeric](18, 2) NULL,
	[column_12] [numeric](18, 2) NULL,
	[Column_13] [numeric](18, 2) NULL,
	[column_14] [numeric](18, 2) NULL,
	[column_16] [numeric](18, 2) NULL,
	[column_18] [numeric](18, 2) NULL,
	[column_20] [numeric](18, 2) NULL,
	[column_22] [numeric](18, 2) NULL,
	[column_24] [numeric](18, 2) NULL,
	[column_26] [numeric](18, 2) NULL,
	[column_28] [numeric](18, 2) NULL,
	[column_30] [numeric](18, 2) NULL,
	[column_32] [numeric](18, 2) NULL,
	[column_34] [numeric](18, 2) NULL,
	[column_36] [numeric](18, 2) NULL,
	[column_38] [numeric](18, 2) NULL,
	[column_40] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Fixed_Layer] PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Charge_Summary]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Charge_Summary](
	[ID] [int] NULL,
	[TYPE] [nvarchar](20) NULL,
	[ITEM] [nvarchar](35) NULL,
	[SO] [nvarchar](6) NULL,
	[WIP_Status] [nvarchar](35) NULL,
	[WIP_Qty] [decimal](18, 0) NULL,
	[Attrition_Rate] [decimal](18, 2) NULL,
	[Qty] [decimal](18, 0) NULL,
	[Unit_Cost] [decimal](18, 4) NULL,
	[Total_Cost] [decimal](18, 4) NULL,
	[Selling_Price] [decimal](18, 4) NULL,
	[Sales] [decimal](18, 4) NULL
) ON [PRIMARY]

GO

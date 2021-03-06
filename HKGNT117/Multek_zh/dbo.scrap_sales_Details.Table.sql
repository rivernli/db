USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[scrap_sales_Details]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[scrap_sales_Details](
	[LOCATION] [varchar](6) NULL,
	[FISCAL_YEAR] [float] NULL,
	[FISCAL_PERIOD] [float] NULL,
	[PLANT] [char](2) NULL,
	[Project] [char](32) NOT NULL,
	[Description] [char](60) NULL,
	[SUPPLIER] [char](6) NULL,
	[SUP_Name] [char](80) NULL,
	[amount] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

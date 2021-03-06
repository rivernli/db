USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[SalesAnalysis_Amount_Fiscal_OEMCustomerLayer]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SalesAnalysis_Amount_Fiscal_OEMCustomerLayer](
	[ReportCode] [varchar](3) NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[OEMCustomerLayer] [varchar](300) NULL,
	[M1] [numeric](18, 2) NULL,
	[M2] [numeric](18, 2) NULL,
	[M3] [numeric](18, 2) NULL,
	[M4] [numeric](18, 2) NULL,
	[M5] [numeric](18, 2) NULL,
	[M6] [numeric](18, 2) NULL,
	[M7] [numeric](18, 2) NULL,
	[M8] [numeric](18, 2) NULL,
	[M9] [numeric](18, 2) NULL,
	[M10] [numeric](18, 2) NULL,
	[M11] [numeric](18, 2) NULL,
	[M12] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

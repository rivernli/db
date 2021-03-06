USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[RevenueTrend_RevenueAdjust]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RevenueTrend_RevenueAdjust](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FiscalYear] [varchar](50) NULL,
	[Plant] [varchar](50) NULL,
	[Period] [varchar](50) NULL,
	[sales_Local_sum] [decimal](18, 3) NULL,
	[salesOversea_sum] [decimal](18, 3) NULL,
	[sales_Total_Consol] [decimal](18, 3) NULL,
	[Scrap_Local_sum] [decimal](18, 3) NULL,
	[Scrap_Oversea_sum] [decimal](18, 3) NULL,
	[Scrap_Total_Consol] [decimal](18, 3) NULL,
	[Local_TotalSales] [decimal](18, 3) NULL,
	[Oversea_TotalSales] [decimal](18, 3) NULL,
	[TotalSales_Consol] [decimal](18, 3) NULL,
	[Automatic_posting_Local] [decimal](18, 3) NULL,
	[Automatic_posting_Oversea] [decimal](18, 3) NULL,
	[DirectPO_Local] [decimal](18, 3) NULL,
	[DirectPO_Oversea] [decimal](18, 3) NULL,
	[SalesTools_Local] [decimal](18, 3) NULL,
	[SalesTools_Oversea] [decimal](18, 3) NULL,
	[RMA_Local] [decimal](18, 3) NULL,
	[RMA_Oversea] [decimal](18, 3) NULL,
	[Hub_Local] [decimal](18, 3) NULL,
	[Hub_Oversea] [decimal](18, 3) NULL,
	[Manual_Local] [decimal](18, 3) NULL,
	[Manual_Oversea] [decimal](18, 3) NULL,
	[Sorting_Local] [decimal](18, 3) NULL,
	[Sorting_Oversea] [decimal](18, 3) NULL,
	[Manual_RMA_Local] [decimal](18, 3) NULL,
	[Manual_RMA_Oversea] [decimal](18, 3) NULL,
	[RecoveryCost_Local] [decimal](18, 3) NULL,
	[RecoveryCost_Oversea] [decimal](18, 3) NULL,
	[DDU_CIF_Local] [decimal](18, 3) NULL,
	[DDU_CIF_Oversea] [decimal](18, 3) NULL,
	[IBMRebate_Local] [decimal](18, 3) NULL,
	[IBMRebate_Oversea] [decimal](18, 3) NULL,
	[rejectinvoices_Local] [decimal](18, 3) NULL,
	[rejectinvoices_Oversea] [decimal](18, 3) NULL,
	[DreditNotes_Local] [decimal](18, 3) NULL,
	[DreditNotes_Oversea] [decimal](18, 3) NULL,
	[Creditcharge_Local] [decimal](18, 3) NULL,
	[Creditcharge_Oversea] [decimal](18, 3) NULL,
	[Processingcharge_Local] [decimal](18, 3) NULL,
	[Processingcharge_Oversea] [decimal](18, 3) NULL,
	[AdjRMA_Local] [decimal](18, 3) NULL,
	[AdjRMA_Oversea] [decimal](18, 3) NULL,
	[ScrapSales_Local] [decimal](18, 3) NULL,
	[ScrapSales_Oversea] [decimal](18, 3) NULL,
	[ScrapSales_in_Local] [decimal](18, 3) NULL,
	[ScrapSales_in_Oversea] [decimal](18, 3) NULL,
	[Sales_matchledgers_Local] [decimal](18, 3) NULL,
	[Sales_matchledgers_Oversea] [decimal](18, 3) NULL,
	[Initiator] [nvarchar](50) NULL,
	[InitiatorDate] [datetime] NULL CONSTRAINT [DF_RevenueTrend_RevenueAdjust_InitiatorDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RevenueTrend_RevenueAdjust] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

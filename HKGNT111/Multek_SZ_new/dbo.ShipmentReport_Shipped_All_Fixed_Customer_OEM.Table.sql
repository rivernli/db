USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM](
	[OEMCustomer] [varchar](100) NULL,
	[ReportCode] [varchar](3) NOT NULL,
	[Site] [varchar](50) NULL,
	[Plant] [varchar](50) NULL,
	[Year] [varchar](4) NULL,
	[M1] [bigint] NULL,
	[M2] [bigint] NULL,
	[M3] [bigint] NULL,
	[M4] [bigint] NULL,
	[M5] [bigint] NULL,
	[M6] [bigint] NULL,
	[M7] [bigint] NULL,
	[M8] [bigint] NULL,
	[M9] [bigint] NULL,
	[M10] [bigint] NULL,
	[M11] [bigint] NULL,
	[M12] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [OEMCustomerReportCodeSitePlantYear] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM] 
(
	[OEMCustomer] ASC,
	[ReportCode] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

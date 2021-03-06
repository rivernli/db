USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Initial_Data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Initial_Data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
/****** Object:  Table [dbo].[Calendar]    Script Date: 12/06/2010 17:26:43 ******/
DROP TABLE [dbo].[Calendar]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Daily]    Script Date: 12/06/2010 17:26:43 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Daily]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Daily_OEM]    Script Date: 12/06/2010 17:26:43 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Daily_OEM]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed]    Script Date: 12/06/2010 17:26:43 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Layer]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Layer]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Layer_Fiscal]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Layer_Fiscal]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc]    Script Date: 12/06/2010 17:26:44 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal]    Script Date: 12/06/2010 17:26:45 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc]    Script Date: 12/06/2010 17:26:45 ******/
DROP TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc]    Script Date: 12/06/2010 17:26:45 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc](
	[Loc] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[OEM] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[B1Amount] [numeric](18, 2) NULL,
	[B12Amount] [numeric](18, 2) NULL,
	[B2FAmount] [numeric](18, 2) NULL,
	[B3Amount] [numeric](18, 2) NULL,
	[B4Amount] [numeric](18, 2) NULL,
	[B5Amount] [numeric](18, 2) NULL,
	[HKAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal]    Script Date: 12/06/2010 17:26:45 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal](
	[Year] [varchar](4) NULL,
	[OEM] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DisAmount] [numeric](18, 2) NULL,
	[ChiAmount] [numeric](18, 2) NULL,
	[NfdAmount] [numeric](18, 2) NULL,
	[SaoAmount] [numeric](18, 2) NULL,
	[GerAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc](
	[Loc] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[OEM] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[B1Amount] [numeric](18, 2) NULL,
	[B12Amount] [numeric](18, 2) NULL,
	[B2FAmount] [numeric](18, 2) NULL,
	[B3Amount] [numeric](18, 2) NULL,
	[B4Amount] [numeric](18, 2) NULL,
	[B5Amount] [numeric](18, 2) NULL,
	[HKAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM](
	[Year] [varchar](4) NULL,
	[OEM] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DisAmount] [numeric](18, 2) NULL,
	[ChiAmount] [numeric](18, 2) NULL,
	[NfdAmount] [numeric](18, 2) NULL,
	[SaoAmount] [numeric](18, 2) NULL,
	[GerAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc](
	[Loc] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[Customer] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[B1Amount] [numeric](18, 2) NULL,
	[B12Amount] [numeric](18, 2) NULL,
	[B2FAmount] [numeric](18, 2) NULL,
	[B3Amount] [numeric](18, 2) NULL,
	[B4Amount] [numeric](18, 2) NULL,
	[B5Amount] [numeric](18, 2) NULL,
	[HKAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal](
	[Year] [varchar](4) NULL,
	[Customer] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DisAmount] [numeric](18, 2) NULL,
	[ChiAmount] [numeric](18, 2) NULL,
	[NfdAmount] [numeric](18, 2) NULL,
	[SaoAmount] [numeric](18, 2) NULL,
	[GerAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc](
	[Loc] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[Customer] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[B1Amount] [numeric](18, 2) NULL,
	[B12Amount] [numeric](18, 2) NULL,
	[B2FAmount] [numeric](18, 2) NULL,
	[B3Amount] [numeric](18, 2) NULL,
	[B4Amount] [numeric](18, 2) NULL,
	[B5Amount] [numeric](18, 2) NULL,
	[HKAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer](
	[Year] [varchar](4) NULL,
	[Customer] [varchar](500) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DisAmount] [numeric](18, 2) NULL,
	[ChiAmount] [numeric](18, 2) NULL,
	[NfdAmount] [numeric](18, 2) NULL,
	[SaoAmount] [numeric](18, 2) NULL,
	[GerAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Layer_Fiscal]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Layer_Fiscal](
	[Year] [varchar](4) NOT NULL,
	[column_1] [bigint] NULL,
	[column_2] [bigint] NULL,
	[column_3] [bigint] NULL,
	[column_4] [bigint] NULL,
	[column_5] [bigint] NULL,
	[column_6] [bigint] NULL,
	[column_7] [bigint] NULL,
	[column_8] [bigint] NULL,
	[column_10] [bigint] NULL,
	[column_12] [bigint] NULL,
	[column_14] [bigint] NULL,
	[column_16] [bigint] NULL,
	[column_18] [bigint] NULL,
	[column_20] [bigint] NULL,
	[column_22] [bigint] NULL,
	[column_24] [bigint] NULL,
	[column_26] [bigint] NULL,
	[column_28] [bigint] NULL,
	[column_30] [bigint] NULL,
	[column_32] [bigint] NULL,
	[column_34] [bigint] NULL,
	[column_36] [bigint] NULL,
	[column_38] [bigint] NULL,
	[column_40] [bigint] NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Fixed_Layer_Fiscal] PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Layer]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Layer](
	[Year] [varchar](4) NOT NULL,
	[column_1] [bigint] NULL,
	[column_2] [bigint] NULL,
	[column_3] [bigint] NULL,
	[column_4] [bigint] NULL,
	[column_5] [bigint] NULL,
	[column_6] [bigint] NULL,
	[column_7] [bigint] NULL,
	[column_8] [bigint] NULL,
	[column_10] [bigint] NULL,
	[column_12] [bigint] NULL,
	[column_14] [bigint] NULL,
	[column_16] [bigint] NULL,
	[column_18] [bigint] NULL,
	[column_20] [bigint] NULL,
	[column_22] [bigint] NULL,
	[column_24] [bigint] NULL,
	[column_26] [bigint] NULL,
	[column_28] [bigint] NULL,
	[column_30] [bigint] NULL,
	[column_32] [bigint] NULL,
	[column_34] [bigint] NULL,
	[column_36] [bigint] NULL,
	[column_38] [bigint] NULL,
	[column_40] [bigint] NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Fixed_Layer] PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal](
	[ReportCode] [varchar](3) NULL,
	[Site] [varchar](50) NULL,
	[Plant] [varchar](50) NULL,
	[Year] [varchar](4) NULL,
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
--GO
SET ANSI_PADDING OFF
--GO
CREATE NONCLUSTERED INDEX [Plant] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal] 
(
	[Plant] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
CREATE NONCLUSTERED INDEX [ReportCode] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal] 
(
	[ReportCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
CREATE NONCLUSTERED INDEX [Site] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal] 
(
	[Site] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
CREATE NONCLUSTERED INDEX [Year] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Fiscal] 
(
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM]    Script Date: 12/06/2010 17:26:44 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM](
	[OEMCustomer] [varchar](300) NULL,
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
--GO
SET ANSI_PADDING OFF
--GO
CREATE NONCLUSTERED INDEX [OEMCustomerReportCodeSitePlantYear] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Customer_OEM] 
(
	[OEMCustomer] ASC,
	[ReportCode] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed]    Script Date: 12/06/2010 17:26:43 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed](
	[ReportCode] [varchar](3) NULL,
	[Site] [varchar](50) NULL,
	[Plant] [varchar](50) NULL,
	[Year] [varchar](4) NULL,
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
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Daily_OEM]    Script Date: 12/06/2010 17:26:43 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Daily_OEM](
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[OEM] [varchar](500) NOT NULL,
	[Day] [datetime] NOT NULL,
	[RevenueAmount] [bigint] NOT NULL,
	[MaterialAmount] [bigint] NULL,
	[MaterialPercent] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Daily_OEM] PRIMARY KEY CLUSTERED 
(
	[Site] ASC,
	[Plant] ASC,
	[OEM] ASC,
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Daily]    Script Date: 12/06/2010 17:26:43 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
SET ANSI_PADDING ON
--GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Daily](
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Day] [datetime] NOT NULL,
	[Amount] [bigint] NOT NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Daily] PRIMARY KEY CLUSTERED 
(
	[Site] ASC,
	[Plant] ASC,
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
--GO
SET ANSI_PADDING OFF
--GO
/****** Object:  Table [dbo].[Calendar]    Script Date: 12/06/2010 17:26:43 ******/
SET ANSI_NULLS ON
--GO
SET QUOTED_IDENTIFIER ON
--GO
CREATE TABLE [dbo].[Calendar](
	[calenderDate] [datetime] NULL,
	[calenderYear] [int] NULL,
	[calenderMonth] [nvarchar](50) NULL,
	[calenderquarter] [int] NULL,
	[calenderWeek] [int] NULL,
	[enWeek] [nvarchar](50) NULL,
	[enMonth] [nvarchar](15) NULL,
	[FiscalYear] [int] NULL,
	[FiscalYearDesc] [nvarchar](50) NULL,
	[FiscalPeriod] [int] NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalPeriodFrom] [date] NULL,
	[FiscalPeriodTo] [date] NULL,
	[FiscalYearFrom] [date] NULL,
	[FiscalYearTo] [date] NULL,
	[FiscalQuarterFrom] [date] NULL,
	[FiscalQuarterTo] [date] NULL
) ON [PRIMARY]
--GO
CREATE NONCLUSTERED INDEX [CalendarDate] ON [dbo].[Calendar] 
(
	[calenderDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
CREATE NONCLUSTERED INDEX [FiscalYearPeriod] ON [dbo].[Calendar] 
(
	[FiscalYear] ASC,
	[FiscalPeriod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO

END
GO

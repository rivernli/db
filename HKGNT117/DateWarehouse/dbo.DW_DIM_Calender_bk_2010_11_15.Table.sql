USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[DW_DIM_Calender_bk_2010_11_15]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DW_DIM_Calender_bk_2010_11_15](
	[calenderDate] [datetime] NULL,
	[calenderYear] [int] NULL,
	[calenderMonth] [nvarchar](50) NULL,
	[calenderquarter] [int] NULL,
	[calenderYearWeek] [int] NULL,
	[calenderWeek] [int] NULL,
	[enWeek] [nvarchar](50) NULL,
	[enWeekSub] [nvarchar](5) NULL,
	[enMonth] [nvarchar](15) NULL,
	[FiscalYear] [int] NULL,
	[FiscalYearDesc] [nvarchar](50) NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalQuarterDesc] [nvarchar](50) NULL,
	[FiscalPeriod] [int] NULL,
	[FiscalPeriodDesc] [nvarchar](50) NULL,
	[FiscalWeek] [int] NULL,
	[FiscalWeekDesc] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Index [Index_CalenderDate]    Script Date: 2014/11/12 17:04:26 ******/
CREATE NONCLUSTERED INDEX [Index_CalenderDate] ON [dbo].[DW_DIM_Calender_bk_2010_11_15]
(
	[calenderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index_FiscalYear]    Script Date: 2014/11/12 17:04:26 ******/
CREATE NONCLUSTERED INDEX [Index_FiscalYear] ON [dbo].[DW_DIM_Calender_bk_2010_11_15]
(
	[FiscalYearDesc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index_FYearPeriod]    Script Date: 2014/11/12 17:04:26 ******/
CREATE NONCLUSTERED INDEX [Index_FYearPeriod] ON [dbo].[DW_DIM_Calender_bk_2010_11_15]
(
	[FiscalYearDesc] ASC,
	[FiscalPeriod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

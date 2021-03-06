USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[DW_DIM_Calender_bk_2014_02_10]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DW_DIM_Calender_bk_2014_02_10](
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
	[FiscalWeekDesc] [nvarchar](50) NULL,
	[FiscalPeriodFrom] [datetime] NULL,
	[FiscalPeriodTo] [datetime] NULL,
	[FiscalYearFrom] [datetime] NULL,
	[FiscalYearTo] [datetime] NULL,
	[FiscalQuarterFrom] [datetime] NULL,
	[FiscalQuarterTo] [datetime] NULL,
	[FiscalWeekFrom] [datetime] NULL,
	[FiscalWeekTo] [datetime] NULL
) ON [PRIMARY]

GO

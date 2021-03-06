USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[Calendar]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Calendar](
	[calenderDate] [date] NULL,
	[calenderYear] [int] NULL,
	[calenderMonth] [nvarchar](50) NULL,
	[calenderquarter] [int] NULL,
	[calenderWeek] [int] NULL,
	[enWeek] [nvarchar](50) NULL,
	[enMonth] [nvarchar](15) NULL,
	[FiscalYear] [int] NULL,
	[FiscalYearDesc] [varchar](6) NULL,
	[FiscalPeriod] [int] NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalPeriodFrom] [date] NULL,
	[FiscalPeriodTo] [date] NULL,
	[FiscalYearFrom] [date] NULL,
	[FiscalYearTo] [date] NULL,
	[FiscalQuarterFrom] [date] NULL,
	[FiscalQuarterTo] [date] NULL,
	[FiscalWeek] [int] NULL,
	[FiscalWeekDesc] [varchar](50) NULL,
	[FiscalWeekFrom] [date] NULL,
	[FiscalWeekTo] [date] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [CalendarDate] ON [dbo].[Calendar] 
(
	[calenderDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [FiscalYearPeriod] ON [dbo].[Calendar] 
(
	[FiscalYear] ASC,
	[FiscalPeriod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

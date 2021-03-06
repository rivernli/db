USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[MRBST_Calender]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_Calender](
	[calenderDate] [datetime] NULL,
	[calenderYear] [int] NULL,
	[calenderMonth] [int] NULL,
	[CalenderMonthDesc] [varchar](20) NULL,
	[calenderquarter] [int] NULL,
	[CalenderQuarterDesc] [varchar](20) NULL,
	[calenderWeek] [int] NULL,
	[CalenderWeekDesc] [varchar](20) NULL,
	[enWeek] [varchar](20) NULL,
	[enMonth] [varchar](20) NULL,
	[FiscalYear] [int] NULL,
	[FiscalYearDesc] [varchar](20) NULL,
	[FiscalPeriod] [int] NULL,
	[FiscalPeriodDesc] [varchar](20) NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalQuarterDesc] [varchar](20) NULL,
	[FiscalWeek] [int] NULL,
	[FiscalWeekDesc] [varchar](20) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

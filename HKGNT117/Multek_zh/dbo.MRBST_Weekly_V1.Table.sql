USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MRBST_Weekly_V1]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_Weekly_V1](
	[Plant] [varchar](50) NULL,
	[Customer] [varchar](100) NULL,
	[OEM] [varchar](30) NULL,
	[Technology] [varchar](30) NULL,
	[MRBCost] [float] NULL,
	[MRBSqft] [float] NULL,
	[FgInCost] [float] NULL,
	[FgInSqft] [float] NULL,
	[FgInSqftRigid] [float] NULL,
	[FgInSqftRigidL] [float] NULL,
	[FgOutCost] [float] NULL,
	[CalenderDateMax] [datetime] NULL,
	[CalenderDateMin] [datetime] NULL,
	[CalenderYear] [int] NULL,
	[CalenderMonthDesc] [varchar](50) NULL,
	[CalenderQuarterDesc] [varchar](50) NULL,
	[CalenderWeekDesc] [varchar](50) NULL,
	[FiscalYearDesc] [varchar](50) NULL,
	[FiscalQuarterDesc] [varchar](50) NULL,
	[FiscalPeriodDesc] [varchar](50) NULL,
	[FiscalWeekDesc] [varchar](50) NULL,
	[RWeek] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

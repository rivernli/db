USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[MRBST_Level33]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_Level33](
	[Plant] [varchar](50) NOT NULL,
	[Project] [varchar](50) NULL,
	[Customer] [varchar](100) NULL,
	[OEM] [varchar](30) NULL,
	[Defect] [varchar](50) NULL,
	[Technology] [varchar](30) NULL,
	[Process] [varchar](50) NULL,
	[OuterOrInner] [varchar](10) NULL,
	[MRBSqftDay] [float] NULL,
	[FgInSqftDay] [float] NULL,
	[RateDay] [float] NULL,
	[MRBSqftWeekToDay] [float] NULL,
	[FgInSqftWeekToDay] [float] NULL,
	[RateWeekToDay] [float] NULL,
	[InnerRateWeekToDay] [float] NULL,
	[MRBSqftPeriodToDay] [float] NULL,
	[FgInSqftPeriodToDay] [float] NULL,
	[RatePeriodToDay] [float] NULL,
	[MRBSqftQuarterToDay] [float] NULL,
	[FgInSqftQuarterToDay] [float] NULL,
	[RateQuarterToDay] [float] NULL,
	[MRBSqftYearToDay] [float] NULL,
	[FgInSqftYearToDay] [float] NULL,
	[RateYearToDay] [float] NULL,
	[MRBSqftR4W] [float] NULL,
	[FgInSqftR4W] [float] NULL,
	[RateR4W] [float] NULL,
	[MRBSqftR13W] [float] NULL,
	[FgInSqftR13W] [float] NULL,
	[RateR13W] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

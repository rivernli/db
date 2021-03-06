USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[MRBST_TargetLine]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_TargetLine](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PeriodDesc] [varchar](50) NULL,
	[FOC] [varchar](50) NULL,
	[TL] [varchar](50) NULL,
	[BaseLineDollar] [decimal](18, 2) NULL,
	[TargetLineDollar] [decimal](18, 2) NULL,
	[BaseLineSqft] [decimal](18, 2) NULL,
	[TargetLineSqft] [decimal](18, 2) NULL,
	[BaseLineInSqft] [decimal](18, 2) NULL,
	[TargetLineInSqft] [decimal](18, 2) NULL,
	[BaseLineOut] [decimal](18, 2) NULL,
	[TargetLineOut] [decimal](18, 2) NULL,
	[BaseLineIn] [decimal](18, 2) NULL,
	[TargetLineIn] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

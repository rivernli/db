USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblLLTSLog]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLLTSLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TN] [int] NULL,
	[LowT] [smallint] NULL,
	[HiT] [smallint] NULL,
	[LowDwell] [smallint] NULL,
	[HiDwell] [smallint] NULL,
	[Xtime] [nvarchar](50) NULL,
	[TotalCycles] [smallint] NULL,
	[CyclesDone] [smallint] NULL,
	[DateReceived] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[FinishDate] [datetime] NULL,
	[Notes] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[wt] [real] NULL,
	[days] [tinyint] NULL,
	[Equipment] [nvarchar](50) NULL
) ON [PRIMARY]

GO

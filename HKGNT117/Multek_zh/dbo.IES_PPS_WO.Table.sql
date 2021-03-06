USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PPS_WO]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_PPS_WO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[PJID] [int] NOT NULL,
	[SubPJID] [int] NULL,
	[Project] [varchar](50) NOT NULL,
	[ProjectWV] [varchar](50) NOT NULL,
	[SubProject] [varchar](50) NOT NULL,
	[SubProjectWV] [varchar](50) NOT NULL,
	[WorkCenter] [varchar](50) NOT NULL,
	[CalendarDate] [datetime] NOT NULL,
	[Unit] [decimal](18, 4) NULL,
	[Yield] [decimal](18, 4) NULL,
	[AttritionRate] [decimal](18, 4) NULL,
	[BookingQty] [decimal](18, 2) NULL,
	[SubTotalQty] [decimal](18, 2) NULL,
	[BookingPnlQty] [decimal](18, 2) NULL,
	[PnlQty] [decimal](18, 2) NULL,
	[CompletedQty] [decimal](18, 2) NULL CONSTRAINT [DF_IES_PPS_WO_CompletedQty]  DEFAULT ((0)),
	[OweQty] [decimal](18, 2) NULL CONSTRAINT [DF_IES_PPS_WO_OweQty]  DEFAULT ((0)),
	[OweTotalQty] [decimal](18, 2) NULL CONSTRAINT [DF_IES_PPS_WO_TotalQty]  DEFAULT ((0)),
	[CompletedQtyOS] [decimal](18, 2) NULL,
	[OweQtyOS] [decimal](18, 2) NULL,
	[OweTotalQtyOS] [decimal](18, 2) NULL,
	[Core] [int] NULL,
	[LT] [decimal](18, 2) NULL,
	[Seq] [int] NULL,
	[PlanDate] [datetime] NULL,
	[PlanDateShort] [datetime] NULL,
	[MRH] [decimal](18, 2) NULL,
	[QTA] [int] NULL CONSTRAINT [DF_IES_PPS_WO_QTA]  DEFAULT ((0)),
	[LRString] [varchar](4000) NULL,
	[WIP] [decimal](18, 2) NULL,
	[WIPOS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_IES_PPS_WO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_PPS_WO]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PPS_WO] ON [dbo].[IES_PPS_WO]
(
	[Building] ASC,
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

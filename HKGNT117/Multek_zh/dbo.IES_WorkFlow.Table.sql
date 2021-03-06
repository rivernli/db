USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_WorkFlow]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_WorkFlow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NULL,
	[Project] [varchar](50) NULL,
	[LayerNo] [varchar](50) NULL,
	[WorkCenter] [varchar](50) NULL,
	[Core] [int] NULL,
	[Pos] [int] NULL,
	[Calc] [int] NULL CONSTRAINT [DF_IES_WorkFlow_Calc]  DEFAULT ((0)),
	[LT] [decimal](18, 2) NULL,
	[QTALT] [decimal](18, 2) NULL,
	[BPLT] [decimal](18, 2) NULL CONSTRAINT [DF_IES_WorkFlow_BPLT]  DEFAULT ((0)),
	[PLT] [decimal](18, 2) NULL CONSTRAINT [DF_IES_WorkFlow_PLT]  DEFAULT ((0)),
	[PQTALT] [decimal](18, 2) NULL CONSTRAINT [DF_IES_WorkFlow_PQTALT]  DEFAULT ((0)),
	[CreateTime] [datetime] NULL CONSTRAINT [DF_IES_WorkFlow_CreateTime]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_WorkFlow]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_WorkFlow] ON [dbo].[IES_WorkFlow]
(
	[LayerNo] ASC,
	[Building] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

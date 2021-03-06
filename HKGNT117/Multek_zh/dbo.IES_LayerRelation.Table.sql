USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_LayerRelation]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_LayerRelation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NULL,
	[MLayer] [varchar](50) NULL,
	[RLayer] [varchar](50) NULL,
	[Project] [varchar](50) NULL,
	[SRNo] [int] NULL,
	[FmLayer] [int] NULL,
	[ToLayer] [int] NULL,
	[Seq] [int] NULL,
	[LT] [decimal](18, 2) NULL,
	[QTALT] [decimal](18, 2) NULL,
	[Calc] [int] NULL CONSTRAINT [DF_IES_LayerRelation_Calc]  DEFAULT ((0)),
	[Core] [int] NULL,
	[CreateTime] [datetime] NULL CONSTRAINT [DF_IES_LayerRelation_CreateTime]  DEFAULT (getdate()),
	[LRString] [varchar](4000) NULL,
 CONSTRAINT [PK_IES_LayerRelation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_LayerRelation]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_LayerRelation] ON [dbo].[IES_LayerRelation]
(
	[RLayer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

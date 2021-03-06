USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJDatabase]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_PJDatabase](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [int] NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[Project] [varchar](50) NOT NULL,
	[ProjectWV] [varchar](50) NULL,
	[Unit] [decimal](18, 4) NULL,
	[Sqft] [decimal](18, 4) NULL,
	[Yield] [decimal](18, 4) NULL,
	[BaanYield] [decimal](18, 4) NULL,
	[AdjustYield] [decimal](18, 4) NULL,
	[AttritionRate] [decimal](18, 4) NULL,
	[CreateTime] [datetime] NULL CONSTRAINT [DF_IES_PJDatabase_CreateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_IES_PJDatabase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_PJDatabase]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PJDatabase] ON [dbo].[IES_PJDatabase]
(
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_PJDatabase_1]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PJDatabase_1] ON [dbo].[IES_PJDatabase]
(
	[Project] ASC,
	[Building] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IES_PJDatabase_2]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PJDatabase_2] ON [dbo].[IES_PJDatabase]
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJDatabase_SubCycleTime]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_PJDatabase_SubCycleTime](
	[PJID] [int] NOT NULL,
	[PBPID] [int] NOT NULL,
	[WorkCenter] [varchar](20) NULL,
	[CycleTime] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_PJDatabase_SubCycleTime]    Script Date: 2014/11/12 17:12:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IES_PJDatabase_SubCycleTime] ON [dbo].[IES_PJDatabase_SubCycleTime]
(
	[PJID] ASC,
	[PBPID] ASC,
	[WorkCenter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

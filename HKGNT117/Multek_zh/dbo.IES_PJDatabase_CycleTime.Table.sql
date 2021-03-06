USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJDatabase_CycleTime]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IES_PJDatabase_CycleTime](
	[PJID] [int] NOT NULL,
	[PBPID] [int] NOT NULL,
	[CycleTime] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
/****** Object:  Index [IX_IES_PJDatabase_CycleTime]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PJDatabase_CycleTime] ON [dbo].[IES_PJDatabase_CycleTime]
(
	[PJID] ASC,
	[PBPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IES_PJDatabase_CycleTime]  WITH NOCHECK ADD  CONSTRAINT [FK_IES_PJDatabase_CycleTime_IES_PJDatabase] FOREIGN KEY([PJID])
REFERENCES [dbo].[IES_PJDatabase] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_PJDatabase_CycleTime] CHECK CONSTRAINT [FK_IES_PJDatabase_CycleTime_IES_PJDatabase]
GO

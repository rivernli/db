USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJConfig_CycleTime]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IES_PJConfig_CycleTime](
	[PJID] [int] NOT NULL,
	[PBPID] [int] NOT NULL,
	[CycleTime] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Index [IX_IES_PJConfig_CycleTime]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PJConfig_CycleTime] ON [dbo].[IES_PJConfig_CycleTime]
(
	[PJID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IES_PJConfig_CycleTime]  WITH CHECK ADD  CONSTRAINT [FK_IES_PJConfig_CycleTime_IES_PJConfig] FOREIGN KEY([PJID])
REFERENCES [dbo].[IES_PJConfig] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_PJConfig_CycleTime] CHECK CONSTRAINT [FK_IES_PJConfig_CycleTime_IES_PJConfig]
GO

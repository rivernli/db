USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Authority]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL,
	[CanAdd] [bit] NOT NULL,
	[CanModify] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
 CONSTRAINT [PK_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [MenuID] ON [dbo].[DistributionReport_Authority] 
(
	[MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [UserID] ON [dbo].[DistributionReport_Authority] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributionReport_Authority]  WITH CHECK ADD  CONSTRAINT [FK_Authority_Menu] FOREIGN KEY([UserID], [MenuID])
REFERENCES [dbo].[DistributionReport_Authority] ([UserID], [MenuID])
GO
ALTER TABLE [dbo].[DistributionReport_Authority] CHECK CONSTRAINT [FK_Authority_Menu]
GO
ALTER TABLE [dbo].[DistributionReport_Authority]  WITH NOCHECK ADD  CONSTRAINT [FK_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[DistributionReport_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DistributionReport_Authority] CHECK CONSTRAINT [FK_Authority_Users]
GO
ALTER TABLE [dbo].[DistributionReport_Authority] ADD  CONSTRAINT [DF_Authority_CanSee]  DEFAULT ((0)) FOR [CanSee]
GO
ALTER TABLE [dbo].[DistributionReport_Authority] ADD  CONSTRAINT [DF_Authority_CanAdd]  DEFAULT ((0)) FOR [CanAdd]
GO
ALTER TABLE [dbo].[DistributionReport_Authority] ADD  CONSTRAINT [DF_Authority_CanModify]  DEFAULT ((0)) FOR [CanModify]
GO
ALTER TABLE [dbo].[DistributionReport_Authority] ADD  CONSTRAINT [DF_Authority_CanDelete]  DEFAULT ((0)) FOR [CanDelete]
GO

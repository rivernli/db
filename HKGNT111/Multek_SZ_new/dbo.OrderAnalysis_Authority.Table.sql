USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[OrderAnalysis_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderAnalysis_Authority](
	[UserID] [varchar](100) NOT NULL,
	[MenuID] [varchar](500) NOT NULL,
	[CanSee] [bit] NOT NULL,
	[CanAdd] [bit] NOT NULL,
	[CanModify] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
 CONSTRAINT [PK_OrderAnalysis_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority]  WITH CHECK ADD  CONSTRAINT [FK_OrderAnalysis_Authority_OrderAnalysis_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[OrderAnalysis_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority] CHECK CONSTRAINT [FK_OrderAnalysis_Authority_OrderAnalysis_Menu]
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority]  WITH CHECK ADD  CONSTRAINT [FK_OrderAnalysis_Authority_OrderAnalysis_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[OrderAnalysis_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority] CHECK CONSTRAINT [FK_OrderAnalysis_Authority_OrderAnalysis_Users]
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority] ADD  CONSTRAINT [DF_OrderAnalysis_Authority_CanSee]  DEFAULT ((0)) FOR [CanSee]
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority] ADD  CONSTRAINT [DF_OrderAnalysis_Authority_CanAdd]  DEFAULT ((0)) FOR [CanAdd]
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority] ADD  CONSTRAINT [DF_OrderAnalysis_Authority_CanModify]  DEFAULT ((0)) FOR [CanModify]
GO
ALTER TABLE [dbo].[OrderAnalysis_Authority] ADD  CONSTRAINT [DF_OrderAnalysis_Authority_CanDelete]  DEFAULT ((0)) FOR [CanDelete]
GO

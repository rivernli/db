USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_Membership]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IES_Membership](
	[UserID] [int] NOT NULL,
	[GroupID] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[IES_Membership]  WITH CHECK ADD  CONSTRAINT [FK_IES_Membership_IES_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[IES_Group] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_Membership] CHECK CONSTRAINT [FK_IES_Membership_IES_Group]
GO
ALTER TABLE [dbo].[IES_Membership]  WITH CHECK ADD  CONSTRAINT [FK_IES_Membership_IES_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[IES_User] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_Membership] CHECK CONSTRAINT [FK_IES_Membership_IES_User]
GO

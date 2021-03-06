USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_GroupPermission]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_GroupPermission](
	[GroupID] [int] NOT NULL,
	[MenuID] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[IES_GroupPermission]  WITH CHECK ADD  CONSTRAINT [FK_IES_GroupPermission_IES_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[IES_Group] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_GroupPermission] CHECK CONSTRAINT [FK_IES_GroupPermission_IES_Group]
GO
ALTER TABLE [dbo].[IES_GroupPermission]  WITH CHECK ADD  CONSTRAINT [FK_IES_GroupPermission_IES_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[IES_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_GroupPermission] CHECK CONSTRAINT [FK_IES_GroupPermission_IES_Menu]
GO

USE [BOC]
GO
/****** Object:  Table [dbo].[Cost_Authority]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL CONSTRAINT [DF_Authority_CanSee]  DEFAULT ((0)),
	[CanAdd] [bit] NOT NULL CONSTRAINT [DF_Authority_CanAdd]  DEFAULT ((0)),
	[CanModify] [bit] NOT NULL CONSTRAINT [DF_Authority_CanModify]  DEFAULT ((0)),
	[CanDelete] [bit] NOT NULL CONSTRAINT [DF_Authority_CanDelete]  DEFAULT ((0)),
 CONSTRAINT [PK_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Cost_Authority]  WITH CHECK ADD  CONSTRAINT [FK_Authority_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Cost_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cost_Authority] CHECK CONSTRAINT [FK_Authority_Menu]
GO
ALTER TABLE [dbo].[Cost_Authority]  WITH NOCHECK ADD  CONSTRAINT [FK_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Cost_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cost_Authority] CHECK CONSTRAINT [FK_Authority_Users]
GO

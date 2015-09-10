USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Tracibility_Authority]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Tracibility_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL CONSTRAINT [Tracibility_Authority_CanSee]  DEFAULT ((0)),
	[CanAdd] [bit] NOT NULL CONSTRAINT [Tracibility_Authority_CanAdd]  DEFAULT ((0)),
	[CanModify] [bit] NOT NULL CONSTRAINT [Tracibility_Authority_CanModify]  DEFAULT ((0)),
	[CanDelete] [bit] NOT NULL CONSTRAINT [Tracibility_Authority_CanDelete]  DEFAULT ((0)),
 CONSTRAINT [Tracibility_PK_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Tracibility_Authority]  WITH CHECK ADD  CONSTRAINT [Tracibility_Authority_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Tracibility_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tracibility_Authority] CHECK CONSTRAINT [Tracibility_Authority_Menu]
GO
ALTER TABLE [dbo].[Tracibility_Authority]  WITH NOCHECK ADD  CONSTRAINT [Tracibility_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Tracibility_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tracibility_Authority] CHECK CONSTRAINT [Tracibility_Authority_Users]
GO

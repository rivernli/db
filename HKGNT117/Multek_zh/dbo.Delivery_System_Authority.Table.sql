USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Delivery_System_Authority]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Delivery_System_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL CONSTRAINT [DF_System_Authority_CanSee]  DEFAULT ((0)),
	[CanAdd] [bit] NOT NULL CONSTRAINT [DF_System_Authority_CanAdd]  DEFAULT ((0)),
	[CanModify] [bit] NOT NULL CONSTRAINT [DF_System_Authority_CanModify]  DEFAULT ((0)),
	[CanDelete] [bit] NOT NULL CONSTRAINT [DF_System_Authority_CanDelete]  DEFAULT ((0)),
	[User_Right] [varchar](1) NULL,
 CONSTRAINT [PK_System_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Delivery_System_Authority]  WITH CHECK ADD  CONSTRAINT [System_Authority_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Delivery_System_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Delivery_System_Authority] CHECK CONSTRAINT [System_Authority_Menu]
GO
ALTER TABLE [dbo].[Delivery_System_Authority]  WITH NOCHECK ADD  CONSTRAINT [System_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Delivery_System_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Delivery_System_Authority] CHECK CONSTRAINT [System_Authority_Users]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限[0为无权限/1查看/2修改] ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Delivery_System_Authority', @level2type=N'COLUMN',@level2name=N'User_Right'
GO

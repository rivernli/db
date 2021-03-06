USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Product_Cost_Analysis_Authority]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Product_Cost_Analysis_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL CONSTRAINT [DF_Product_Cost_Analysis_Authority_CanSee]  DEFAULT ((0)),
	[CanAdd] [bit] NOT NULL CONSTRAINT [DF_Product_Cost_Analysis_Authority_CanAdd]  DEFAULT ((0)),
	[CanModify] [bit] NOT NULL CONSTRAINT [DF_Product_Cost_Analysis_Authority_CanModify]  DEFAULT ((0)),
	[CanDelete] [bit] NOT NULL CONSTRAINT [DF_Product_Cost_Analysis_Authority_CanDelete]  DEFAULT ((0))
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Product_Cost_Analysis_Authority] ADD [User_Right] [varchar](1) NULL
 CONSTRAINT [PK_Product_Cost_Analysis_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Product_Cost_Analysis_Authority]  WITH CHECK ADD  CONSTRAINT [Product_Cost_Analysis_Authority_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Product_Cost_Analysis_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Cost_Analysis_Authority] CHECK CONSTRAINT [Product_Cost_Analysis_Authority_Menu]
GO
ALTER TABLE [dbo].[Product_Cost_Analysis_Authority]  WITH NOCHECK ADD  CONSTRAINT [Product_Cost_Analysis_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Product_Cost_Analysis_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Cost_Analysis_Authority] CHECK CONSTRAINT [Product_Cost_Analysis_Authority_Users]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限[0为无权限/1查看/2修改] ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product_Cost_Analysis_Authority', @level2type=N'COLUMN',@level2name=N'User_Right'
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Report_UploadAttachment_Authority]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Report_UploadAttachment_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL CONSTRAINT [DF_Report_UploadAttachment_Authority_CanSee]  DEFAULT ((0)),
	[CanAdd] [bit] NOT NULL CONSTRAINT [DF_Report_UploadAttachment_Authority_CanAdd]  DEFAULT ((0)),
	[CanModify] [bit] NOT NULL CONSTRAINT [DF_Report_UploadAttachment_Authority_CanModify]  DEFAULT ((0)),
	[CanDelete] [bit] NOT NULL CONSTRAINT [DF_Report_UploadAttachment_Authority_CanDelete]  DEFAULT ((0)),
	[User_Right] [bit] NULL CONSTRAINT [DF_Report_UploadAttachment_Authority_User_Right]  DEFAULT ((0)),
 CONSTRAINT [PK_Report_UploadAttachment_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Report_UploadAttachment_Authority]  WITH CHECK ADD  CONSTRAINT [FK_Report_UploadAttachment_Authority_MenuID] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Report_UploadAttachment_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Report_UploadAttachment_Authority] CHECK CONSTRAINT [FK_Report_UploadAttachment_Authority_MenuID]
GO
ALTER TABLE [dbo].[Report_UploadAttachment_Authority]  WITH NOCHECK ADD  CONSTRAINT [Report_UploadAttachment_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Report_UploadAttachment_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Report_UploadAttachment_Authority] CHECK CONSTRAINT [Report_UploadAttachment_Authority_Users]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限[0为无权限/1查看/2修改] ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Report_UploadAttachment_Authority', @level2type=N'COLUMN',@level2name=N'User_Right'
GO

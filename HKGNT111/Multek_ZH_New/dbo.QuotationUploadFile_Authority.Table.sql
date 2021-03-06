USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QuotationUploadFile_Authority]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuotationUploadFile_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL,
	[CanAdd] [bit] NOT NULL,
	[CanModify] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
	[User_Right] [bit] NULL,
 CONSTRAINT [PK_QuotationUploadFile_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限[0为无权限/1查看/2修改] ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuotationUploadFile_Authority', @level2type=N'COLUMN',@level2name=N'User_Right'
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority]  WITH CHECK ADD  CONSTRAINT [FK_QuotationUploadFile_Authority_QuotationUploadFile_Authority] FOREIGN KEY([MenuID])
REFERENCES [dbo].[QuotationUploadFile_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] CHECK CONSTRAINT [FK_QuotationUploadFile_Authority_QuotationUploadFile_Authority]
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority]  WITH CHECK ADD  CONSTRAINT [FK_QuotationUploadFile_Authority_QuotationUploadFile_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[QuotationUploadFile_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] CHECK CONSTRAINT [FK_QuotationUploadFile_Authority_QuotationUploadFile_Users]
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] ADD  CONSTRAINT [DF_QuotationUploadFile_Authority_CanSee]  DEFAULT ((0)) FOR [CanSee]
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] ADD  CONSTRAINT [DF_QuotationUploadFile_Authority_CanAdd]  DEFAULT ((0)) FOR [CanAdd]
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] ADD  CONSTRAINT [DF_QuotationUploadFile_Authority_CanModify]  DEFAULT ((0)) FOR [CanModify]
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] ADD  CONSTRAINT [DF_QuotationUploadFile_Authority_CanDelete]  DEFAULT ((0)) FOR [CanDelete]
GO
ALTER TABLE [dbo].[QuotationUploadFile_Authority] ADD  CONSTRAINT [DF_QuotationUploadFile_Authority_User_Right]  DEFAULT ((0)) FOR [User_Right]
GO

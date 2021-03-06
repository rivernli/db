USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[PriceTrend_Authority]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PriceTrend_Authority](
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PriceTrend_Authority] ADD  CONSTRAINT [DF_Authority_CanSee]  DEFAULT ((0)) FOR [CanSee]
GO
ALTER TABLE [dbo].[PriceTrend_Authority] ADD  CONSTRAINT [DF_Authority_CanAdd]  DEFAULT ((0)) FOR [CanAdd]
GO
ALTER TABLE [dbo].[PriceTrend_Authority] ADD  CONSTRAINT [DF_Authority_CanModify]  DEFAULT ((0)) FOR [CanModify]
GO
ALTER TABLE [dbo].[PriceTrend_Authority] ADD  CONSTRAINT [DF_Authority_CanDelete]  DEFAULT ((0)) FOR [CanDelete]
GO
ALTER TABLE [dbo].[PriceTrend_Authority]  WITH CHECK ADD  CONSTRAINT [FK_Authority_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[PriceTrend_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PriceTrend_Authority] CHECK CONSTRAINT [FK_Authority_Menu]
GO

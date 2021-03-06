USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_GroupBuilding]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_GroupBuilding](
	[GroupID] [int] NOT NULL,
	[Building] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[IES_GroupBuilding]  WITH CHECK ADD  CONSTRAINT [FK_IES_GroupBuilding_IES_Building] FOREIGN KEY([Building])
REFERENCES [dbo].[IES_Building] ([Building])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_GroupBuilding] CHECK CONSTRAINT [FK_IES_GroupBuilding_IES_Building]
GO
ALTER TABLE [dbo].[IES_GroupBuilding]  WITH CHECK ADD  CONSTRAINT [FK_IES_GroupBuilding_IES_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[IES_Group] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_GroupBuilding] CHECK CONSTRAINT [FK_IES_GroupBuilding_IES_Group]
GO

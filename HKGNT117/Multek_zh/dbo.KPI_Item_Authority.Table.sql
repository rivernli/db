USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KPI_Item_Authority]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KPI_Item_Authority](
	[KPI_Id] [varchar](50) NULL,
	[UserId] [varchar](50) NULL,
	[CanSee] [bit] NULL CONSTRAINT [DF_KPI_Item_Authority_CanSee]  DEFAULT ((0)),
	[CanUpload] [bit] NULL CONSTRAINT [DF_KPI_Item_Authority_CanUpload]  DEFAULT ((0))
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[PhotoTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhotoTable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nid] [int] NULL,
	[Title] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[LargeImg] [nvarchar](100) NULL,
	[SmartImg] [nvarchar](100) NULL
) ON [PRIMARY]

GO

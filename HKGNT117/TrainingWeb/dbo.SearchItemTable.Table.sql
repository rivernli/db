USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[SearchItemTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchItemTable](
	[sid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[show] [bit] NOT NULL,
	[obligate] [nvarchar](50) NULL
) ON [PRIMARY]

GO

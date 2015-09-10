USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[StaffTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffTable](
	[id] [int] NOT NULL,
	[username] [nvarchar](50) NULL,
	[age] [int] NULL,
	[sex] [nvarchar](50) NULL,
	[pic] [nvarchar](50) NULL,
	[explain] [ntext] NULL,
	[good] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

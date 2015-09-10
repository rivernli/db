USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[CalendarTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Start] [datetime] NULL,
	[End] [datetime] NULL
) ON [PRIMARY]

GO

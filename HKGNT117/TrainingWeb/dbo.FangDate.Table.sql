USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[FangDate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FangDate](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[seetime] [nvarchar](50) NULL,
	[ipadress] [nvarchar](50) NULL
) ON [PRIMARY]

GO

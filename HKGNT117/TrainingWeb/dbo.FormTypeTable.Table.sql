USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[FormTypeTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormTypeTable](
	[fid] [int] IDENTITY(1,1) NOT NULL,
	[fname] [nvarchar](50) NULL,
	[f_desc] [nvarchar](50) NULL
) ON [PRIMARY]

GO

USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[RebateTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RebateTable](
	[rid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[rebate] [nvarchar](50) NULL,
	[state] [bit] NOT NULL
) ON [PRIMARY]

GO

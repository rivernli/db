USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[r_id] [int] NOT NULL,
	[r_name] [nvarchar](50) NULL,
	[r_desc] [nvarchar](50) NULL,
	[r_bid] [int] NULL
) ON [PRIMARY]

GO

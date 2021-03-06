USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[OneFormTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OneFormTable](
	[oid] [int] IDENTITY(1,1) NOT NULL,
	[oname] [nvarchar](50) NULL,
	[fid] [int] NULL,
	[parentendid] [int] NULL,
	[isleaf] [nvarchar](50) NULL,
	[pic] [nvarchar](50) NULL,
	[saveurl] [nvarchar](50) NULL,
	[gotourl] [nvarchar](50) NULL,
	[template] [ntext] NULL,
	[bid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

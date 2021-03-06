USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[OrderTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTable](
	[oid] [nvarchar](50) NULL,
	[uid] [int] NULL,
	[rid] [int] NULL,
	[phone] [nvarchar](50) NULL,
	[mobile] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[ordertime] [datetime] NULL,
	[sessionid] [int] NULL,
	[totalprice] [nvarchar](50) NULL,
	[obligate1] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

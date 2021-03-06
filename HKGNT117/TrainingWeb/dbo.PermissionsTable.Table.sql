USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[PermissionsTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionsTable](
	[p_id] [int] NOT NULL,
	[r_id] [int] NULL,
	[p_name] [nvarchar](50) NULL,
	[oid] [int] NULL,
	[fid] [int] NULL,
	[parentendid] [int] NULL,
	[p_bid] [int] NULL,
	[p_add] [bit] NULL,
	[p_del] [bit] NULL,
	[p_up] [bit] NULL,
	[p_Value] [bit] NULL
) ON [PRIMARY]

GO

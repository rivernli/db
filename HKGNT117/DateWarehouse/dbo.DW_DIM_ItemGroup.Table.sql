USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[DW_DIM_ItemGroup]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DW_DIM_ItemGroup](
	[T$CITG] [char](6) NOT NULL,
	[T$DSCA] [char](30) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

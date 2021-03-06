USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[DW_DIM_Item_Match_OEM]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DW_DIM_Item_Match_OEM](
	[t$item] [char](32) NOT NULL,
	[t$csgs] [char](6) NOT NULL,
	[T$DESC] [nvarchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index_Item]    Script Date: 2014/11/12 17:04:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Index_Item] ON [dbo].[DW_DIM_Item_Match_OEM]
(
	[t$item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

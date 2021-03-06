USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[ItemPriceMasterQuery_Data_Plant_Temp]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemPriceMasterQuery_Data_Plant_Temp](
	[T$CUNO] [varchar](32) NOT NULL,
	[T$ITEM] [varchar](50) NOT NULL,
	[T$PLNT] [varchar](2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ItemPriceMasterQuery_Data_Plant_Temp]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_ItemPriceMasterQuery_Data_Plant_Temp] ON [dbo].[ItemPriceMasterQuery_Data_Plant_Temp]
(
	[T$CUNO] ASC,
	[T$ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

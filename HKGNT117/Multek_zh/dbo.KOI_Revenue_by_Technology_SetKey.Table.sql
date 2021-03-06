USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Revenue_by_Technology_SetKey]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KOI_Revenue_by_Technology_SetKey](
	[Plant] [nvarchar](4) NULL,
	[Technology] [nvarchar](200) NULL,
	[CreateUser] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_KOI_Revenue_by_Technology_SetKey]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_KOI_Revenue_by_Technology_SetKey] ON [dbo].[KOI_Revenue_by_Technology_SetKey]
(
	[Plant] ASC,
	[CreateUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

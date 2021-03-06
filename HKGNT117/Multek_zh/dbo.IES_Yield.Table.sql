USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_Yield]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IES_Yield](
	[plnt] [nchar](2) NULL,
	[pitm] [nchar](16) NULL,
	[ryie] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_Yield]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_Yield] ON [dbo].[IES_Yield]
(
	[plnt] ASC,
	[pitm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

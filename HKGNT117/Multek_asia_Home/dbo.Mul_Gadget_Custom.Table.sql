USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Gadget_Custom]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Gadget_Custom](
	[Ggc_Id] [int] NOT NULL,
	[Ggc_Col] [int] NOT NULL,
	[Ggc_SortId] [int] NOT NULL,
	[Ggc_Owner] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Mul_Gadget_Custom] PRIMARY KEY NONCLUSTERED 
(
	[Ggc_Id] ASC,
	[Ggc_Owner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Mul_Gadget_Custom_Owner]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_Mul_Gadget_Custom_Owner] ON [dbo].[Mul_Gadget_Custom]
(
	[Ggc_Owner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

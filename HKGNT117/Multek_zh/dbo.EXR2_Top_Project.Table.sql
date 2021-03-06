USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Top_Project]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Top_Project](
	[TopProject] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Index [Top]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Top] ON [dbo].[EXR2_Top_Project]
(
	[TopProject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

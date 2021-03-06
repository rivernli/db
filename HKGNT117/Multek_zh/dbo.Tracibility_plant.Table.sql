USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Tracibility_plant]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tracibility_plant](
	[T$PLNT] [char](2) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index1_Plant]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Index1_Plant] ON [dbo].[Tracibility_plant]
(
	[T$PLNT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

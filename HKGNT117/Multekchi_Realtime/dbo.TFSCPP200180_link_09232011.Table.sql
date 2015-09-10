USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[TFSCPP200180_link_09232011]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSCPP200180_link_09232011](
	[T$PITM] [char](4) NOT NULL,
	[T$PVER] [char](1) NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$PFIX] [char](3) NOT NULL,
	[T$OTYP] [float] NOT NULL,
	[T$PRDN] [char](30) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

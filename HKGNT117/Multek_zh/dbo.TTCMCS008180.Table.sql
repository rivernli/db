USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTCMCS008180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTCMCS008180](
	[T$CCUR] [char](3) NOT NULL,
	[T$STDT] [datetime] NULL,
	[T$RATP] [float] NOT NULL,
	[T$RATS] [float] NOT NULL,
	[T$ECRT] [float] NOT NULL,
	[T$RATF] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

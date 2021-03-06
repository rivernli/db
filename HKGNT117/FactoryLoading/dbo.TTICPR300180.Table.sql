USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTICPR300180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTICPR300180](
	[T$ITEM] [char](32) NOT NULL,
	[T$CNTR] [char](3) NOT NULL,
	[T$INDT] [datetime] NULL,
	[T$CPCP] [char](3) NOT NULL,
	[T$NUNI] [float] NOT NULL,
	[T$ACTF] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

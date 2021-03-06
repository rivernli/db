USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFSSLS024180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSSLS024180](
	[T$ORNO] [char](15) NOT NULL,
	[T$SQNO] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$RTAX] [float] NOT NULL,
	[T$UNIT] [char](3) NOT NULL,
	[T$NQTY] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$AMNT] [float] NOT NULL,
	[T$PRID] [float] NOT NULL,
	[T$AMND] [float] NOT NULL,
	[T$RMKA] [char](100) NOT NULL,
	[T$PENO] [char](15) NOT NULL,
	[T$NOTE] [char](8) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

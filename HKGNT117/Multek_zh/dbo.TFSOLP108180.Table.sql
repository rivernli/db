USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP108180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP108180](
	[T$PITM] [char](16) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$BOAR] [char](100) NOT NULL,
	[T$CSGS] [char](30) NOT NULL,
	[T$PRDT] [char](30) NOT NULL,
	[T$YIED] [float] NOT NULL,
	[T$MRBU] [float] NOT NULL,
	[T$MRBS] [float] NOT NULL,
	[T$YDAU] [float] NOT NULL,
	[T$YDAS] [float] NOT NULL,
	[T$INDT] [datetime] NULL,
	[T$OUDT] [datetime] NULL,
	[T$WEEK] [char](5) NOT NULL,
	[T$FWEK] [char](5) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

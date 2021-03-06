USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TTIBOM010180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTIBOM010180](
	[T$MITM] [char](32) NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$SEQN] [float] NOT NULL,
	[T$SITM] [char](32) NOT NULL,
	[T$INDT] [datetime] NULL,
	[T$EXDT] [datetime] NULL,
	[T$LENG] [float] NOT NULL,
	[T$WIDT] [float] NOT NULL,
	[T$NOUN] [float] NOT NULL,
	[T$QANA] [float] NOT NULL,
	[T$SCPF] [float] NOT NULL,
	[T$CWAR] [char](3) NOT NULL,
	[T$OPNO] [float] NOT NULL,
	[T$CPHA] [float] NOT NULL,
	[T$EXIN] [char](8) NOT NULL,
	[T$NNTS] [float] NOT NULL,
	[T$LEDM] [float] NOT NULL,
	[T$TXTA] [float] NOT NULL,
	[T$LTOM] [float] NOT NULL,
	[T$LTOV] [float] NOT NULL,
	[T$REFI] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

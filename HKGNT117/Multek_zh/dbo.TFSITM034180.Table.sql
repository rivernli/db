USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSITM034180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSITM034180](
	[T$VERS] [char](20) NOT NULL,
	[T$CAID] [char](6) NOT NULL,
	[T$CATY] [char](50) NOT NULL,
	[T$VALU] [char](80) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$REMK] [char](30) NOT NULL,
	[T$VAL1] [float] NOT NULL,
	[T$VAL2] [float] NOT NULL,
	[T$VAL3] [float] NOT NULL,
	[T$VAL4] [float] NOT NULL,
	[T$CUN1] [char](6) NOT NULL,
	[T$CUN2] [char](6) NOT NULL,
	[T$CUN3] [char](6) NOT NULL,
	[T$CUN4] [char](6) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

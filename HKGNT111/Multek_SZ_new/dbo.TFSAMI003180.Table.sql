USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[TFSAMI003180]    Script Date: 11/06/2014 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSAMI003180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](16) NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$FPRO] [char](35) NOT NULL,
	[T$FCHN] [char](35) NOT NULL,
	[T$FTLN] [char](100) NOT NULL,
	[T$STAT] [float] NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$TIME] [float] NOT NULL,
	[T$USID] [char](15) NOT NULL,
	[T$RMNO] [char](8) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TTCMCS003180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TTCMCS003180](
	[T$CWAR] [char](3) NOT NULL,
	[T$DSCA] [char](30) NOT NULL,
	[T$NAMA] [char](35) NOT NULL,
	[T$NAMB] [char](30) NOT NULL,
	[T$NAMC] [char](30) NOT NULL,
	[T$NAMD] [char](30) NOT NULL,
	[T$NAME] [char](30) NOT NULL,
	[T$NAMF] [char](30) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$COMP] [float] NOT NULL,
	[T$TYPW] [float] NOT NULL,
	[T$NWRH] [float] NOT NULL,
	[T$SLOC] [float] NOT NULL,
	[T$ARLO] [char](8) NOT NULL,
	[T$APLO] [char](8) NOT NULL,
	[T$ITLO] [float] NOT NULL,
	[T$LOLO] [float] NOT NULL,
	[T$FREE] [float] NOT NULL,
	[T$CADR] [char](6) NOT NULL,
	[T$PSTC] [char](10) NOT NULL,
	[T$GEOC$L] [char](10) NOT NULL,
	[T$TYPE] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

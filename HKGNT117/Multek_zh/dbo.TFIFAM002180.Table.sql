USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFIFAM002180]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFIFAM002180](
	[T$MANU] [char](6) NOT NULL,
	[T$DESC] [char](50) NOT NULL,
	[T$NAMB] [char](50) NOT NULL,
	[T$NAMC] [char](50) NOT NULL,
	[T$NAMD] [char](50) NOT NULL,
	[T$NAME] [char](50) NOT NULL,
	[T$PSTC] [char](10) NOT NULL,
	[T$CCTY] [char](3) NOT NULL,
	[T$EADD] [char](20) NOT NULL,
	[T$OBSL] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

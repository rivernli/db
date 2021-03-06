USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[TFSOLP128180]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP128180](
	[T$PLNT] [char](2) NOT NULL,
	[T$PJNO] [char](16) NOT NULL,
	[T$LCNT] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$UCOS] [float] NOT NULL,
	[T$USQF] [float] NOT NULL,
	[T$CUST] [char](100) NOT NULL,
	[T$OEMN] [char](30) NOT NULL,
	[T$TECH] [char](30) NOT NULL,
	[T$MDSC] [char](50) NOT NULL,
	[T$SDSC] [char](50) NOT NULL,
	[T$PROC] [char](50) NOT NULL,
	[T$SURF] [char](30) NOT NULL,
	[T$CWOC] [char](4) NOT NULL,
	[T$DATE] [datetime] NULL,
	[T$QTYI] [float] NOT NULL,
	[T$QSQF] [float] NOT NULL,
	[T$MRBQ] [float] NOT NULL,
	[T$MSQF] [float] NOT NULL,
	[T$MCOS] [float] NOT NULL,
	[T$ICOS] [float] NOT NULL,
	[T$OUTE] [char](3) NOT NULL,
	[T$TYPE] [char](4) NOT NULL,
	[T$FTYI] [float] NOT NULL,
	[T$JDAT] [datetime] NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_T$OEMN] ON [dbo].[TFSOLP128180] 
(
	[T$OEMN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

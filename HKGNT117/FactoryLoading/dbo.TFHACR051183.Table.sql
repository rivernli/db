USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[TFHACR051183]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFHACR051183](
	[T$SORN] [float] NOT NULL,
	[T$SPON] [float] NOT NULL,
	[T$SRNB] [float] NOT NULL,
	[T$BQUA] [float] NOT NULL,
	[T$DQUA] [float] NOT NULL,
	[T$DDTA] [datetime] NOT NULL,
	[T$DINO] [float] NOT NULL,
	[T$LOGN] [char](16) NOT NULL,
	[T$TRDT] [datetime] NOT NULL,
	[T$TRTM] [float] NOT NULL,
	[T$TTYP] [char](3) NOT NULL,
	[T$NINV] [float] NOT NULL,
	[T$LINO] [float] NOT NULL,
	[T$ITEM] [char](32) NOT NULL,
	[T$OQUA] [float] NOT NULL,
	[T$PRIC] [float] NOT NULL,
	[T$CCUR] [char](3) NOT NULL,
	[T$LEAC] [char](12) NOT NULL,
	[T$DIM1] [char](6) NOT NULL,
	[T$DIM2] [char](6) NOT NULL,
	[T$DIM3] [char](6) NOT NULL,
	[T$DIM4] [char](6) NOT NULL,
	[T$DIM5] [char](6) NOT NULL,
	[T$CVAT] [char](9) NOT NULL,
	[T$VATA] [float] NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [sorn]    Script Date: 2014/11/12 17:06:44 ******/
CREATE NONCLUSTERED INDEX [sorn] ON [dbo].[TFHACR051183]
(
	[T$SORN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [spon]    Script Date: 2014/11/12 17:06:44 ******/
CREATE NONCLUSTERED INDEX [spon] ON [dbo].[TFHACR051183]
(
	[T$SPON] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [srnb]    Script Date: 2014/11/12 17:06:44 ******/
CREATE NONCLUSTERED INDEX [srnb] ON [dbo].[TFHACR051183]
(
	[T$SRNB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

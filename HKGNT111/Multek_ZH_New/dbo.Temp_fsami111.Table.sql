USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[Temp_fsami111]    Script Date: 11/06/2014 15:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Temp_fsami111](
	[T$CODE] [char](4) NOT NULL,
	[T$FILL] [float] NOT NULL,
	[T$FCUN] [char](3) NOT NULL,
	[T$WRAP] [float] NOT NULL,
	[T$WCUN] [char](3) NOT NULL,
	[T$CFIL] [float] NOT NULL,
	[T$CFCU] [char](3) NOT NULL,
	[T$CWRA] [float] NOT NULL,
	[T$CWCU] [char](3) NOT NULL,
	[T$PLNT] [char](2) NOT NULL,
	[T$REFCNTD] [float] NOT NULL,
	[T$REFCNTU] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

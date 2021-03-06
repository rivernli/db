USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_Delinquent]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_Delinquent](
	[T$JDAT] [datetime] NULL,
	[Plant] [char](2) NOT NULL,
	[OEM] [char](30) NOT NULL,
	[Project] [char](32) NOT NULL,
	[Amount] [float] NULL,
	[Quantity] [float] NULL,
	[Sqft] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

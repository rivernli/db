USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MSS_MPS_ByPlant]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSS_MPS_ByPlant](
	[T$JDAT] [datetime] NULL,
	[T$WODT_FiscalYear] [nvarchar](4) NULL,
	[T$WODT_FiscalPeriod] [int] NULL,
	[Plant] [char](2) NOT NULL,
	[Amount] [float] NULL,
	[Quantity] [float] NULL,
	[Sqft] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

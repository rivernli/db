USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Forecast_Weekly]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Forecast_Weekly](
	[Type] [varchar](10) NOT NULL,
	[Site] [varchar](3) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[W1] [bigint] NULL,
	[W2] [bigint] NULL,
	[W3] [bigint] NULL,
	[W4] [bigint] NULL,
	[W5] [bigint] NULL,
	[W6] [bigint] NULL,
	[W7] [bigint] NULL,
	[W8] [bigint] NULL,
	[W9] [bigint] NULL,
	[W10] [bigint] NULL,
	[W11] [bigint] NULL,
	[W12] [bigint] NULL,
	[W13] [bigint] NULL,
	[W14] [bigint] NULL,
	[W15] [bigint] NULL,
	[W16] [bigint] NULL,
	[W17] [bigint] NULL,
	[W18] [bigint] NULL,
	[W19] [bigint] NULL,
	[W20] [bigint] NULL,
	[W21] [bigint] NULL,
	[W22] [bigint] NULL,
	[W23] [bigint] NULL,
	[W24] [bigint] NULL,
	[W25] [bigint] NULL,
	[W26] [bigint] NULL,
	[W27] [bigint] NULL,
	[W28] [bigint] NULL,
	[W29] [bigint] NULL,
	[W30] [bigint] NULL,
	[W31] [bigint] NULL,
	[W32] [bigint] NULL,
	[W33] [bigint] NULL,
	[W34] [bigint] NULL,
	[W35] [bigint] NULL,
	[W36] [bigint] NULL,
	[W37] [bigint] NULL,
	[W38] [bigint] NULL,
	[W39] [bigint] NULL,
	[W40] [bigint] NULL,
	[W41] [bigint] NULL,
	[W42] [bigint] NULL,
	[W43] [bigint] NULL,
	[W44] [bigint] NULL,
	[W45] [bigint] NULL,
	[W46] [bigint] NULL,
	[W47] [bigint] NULL,
	[W48] [bigint] NULL,
	[W49] [bigint] NULL,
	[W50] [bigint] NULL,
	[W51] [bigint] NULL,
	[W52] [bigint] NULL,
	[W53] [bigint] NULL,
 CONSTRAINT [PK_Distrbution_Forecast_Weekly] PRIMARY KEY CLUSTERED 
(
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

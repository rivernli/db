USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Layer_Amount_Fiscal]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Layer_Amount_Fiscal](
	[Year] [varchar](4) NOT NULL,
	[Type] [varchar](10) NOT NULL,
	[Site] [varchar](3) NOT NULL,
	[Plant] [varchar](3) NOT NULL,
	[Column_1] [bigint] NULL,
	[Column_2] [bigint] NULL,
	[Column_3] [bigint] NULL,
	[Column_4] [bigint] NULL,
	[Column_5] [bigint] NULL,
	[Column_6] [bigint] NULL,
	[Column_7] [bigint] NULL,
	[Column_8] [bigint] NULL,
	[Column_10] [bigint] NULL,
	[Column_12] [bigint] NULL,
	[Column_14] [bigint] NULL,
	[Column_16] [bigint] NULL,
	[Column_18] [bigint] NULL,
	[Column_20] [bigint] NULL,
	[Column_22] [bigint] NULL,
	[Column_24] [bigint] NULL,
	[Column_26] [bigint] NULL,
	[Column_13] [bigint] NULL,
	[Column_32] [bigint] NULL,
	[Column_80] [bigint] NULL,
	[Column_9] [bigint] NULL,
	[Column_28] [bigint] NULL,
	[Column_11] [bigint] NULL,
	[Column_36] [bigint] NULL,
	[Column_34] [bigint] NULL,
	[Column_30] [bigint] NULL,
 CONSTRAINT [PK_DistributionReport_Layer_Amount_Fiscal] PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

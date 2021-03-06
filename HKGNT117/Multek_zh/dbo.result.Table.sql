USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[result]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[result](
	[delta] [float] NOT NULL,
	[fg_bal] [float] NOT NULL,
	[fcst] [float] NOT NULL,
	[oem] [char](30) NULL,
	[plant] [varchar](2) NULL,
	[inAmt] [float] NOT NULL,
	[outAmt] [float] NOT NULL,
	[fg_total] [float] NOT NULL,
	[fg_available] [float] NOT NULL,
	[over12weeks] [float] NOT NULL,
	[over8weeks] [float] NOT NULL,
	[over6weeks] [float] NOT NULL,
	[over4weeks] [float] NOT NULL,
	[over2weeks] [float] NOT NULL,
	[lessthen2weeks] [float] NOT NULL,
	[intransit] [float] NOT NULL,
	[total] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[tmp2]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp2](
	[oem] [char](30) NULL,
	[plant] [varchar](2) NULL,
	[totalK] [float] NULL,
	[w1amt] [float] NOT NULL,
	[w2amt] [float] NOT NULL,
	[w4amt] [float] NOT NULL,
	[w6amt] [float] NOT NULL,
	[w8amt] [float] NOT NULL,
	[w12amt] [float] NOT NULL,
	[wOV12amt] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

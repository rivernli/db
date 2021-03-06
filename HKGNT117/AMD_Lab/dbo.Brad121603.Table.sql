USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[Brad121603]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brad121603](
	[# Layers] [tinyint] NULL,
	[Coupon thickness] [decimal](5, 4) NULL,
	[MaterialL] [int] NULL,
	[P1 drill size] [decimal](6, 5) NULL,
	[S1 drill size] [decimal](6, 5) NULL,
	[S2 drill size] [decimal](6, 5) NULL,
	[P2 drill size] [decimal](6, 5) NULL,
	[ConstName] [int] NULL,
	[Precondition Name] [int] NULL,
	[Cycling Name] [int] NULL,
	[P1 ohms prescreen] [smallint] NULL,
	[P2 ohms prescreen] [smallint] NULL,
	[S1 ohms prescreen] [smallint] NULL,
	[S2 ohms prescreen] [smallint] NULL,
	[Status] [nvarchar](50) NULL,
	[Cyc com] [smallint] NULL
) ON [PRIMARY]

GO

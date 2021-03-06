USE [BOC]
GO
/****** Object:  Table [dbo].[TFSPUR034180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFSPUR034180](
	[t$sern] [int] NOT NULL,
	[t$year] [int] NULL,
	[t$prod] [int] NULL,
	[t$item] [nvarchar](32) NOT NULL,
	[t$suno] [nvarchar](6) NOT NULL,
	[t$citg] [nvarchar](6) NULL,
	[t$iqty] [float] NULL,
	[t$pric] [float] NULL,
	[t$amnt] [float] NULL,
	[t$cprc] [float] NULL,
	[t$samt] [float] NULL,
	[t$tamt] [float] NULL,
	[t$tprc] [float] NULL,
	[t$ccur] [nvarchar](3) NULL,
	[t$dprc] [float] NULL,
	[t$trtp] [nvarchar](10) NULL,
	[t$plnt] [nvarchar](2) NOT NULL,
 CONSTRAINT [PK_TFSPUR034180] PRIMARY KEY CLUSTERED 
(
	[t$sern] ASC,
	[t$item] ASC,
	[t$suno] ASC,
	[t$plnt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

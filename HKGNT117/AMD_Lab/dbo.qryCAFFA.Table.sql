USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryCAFFA]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryCAFFA](
	[CoupName] [nvarchar](50) NULL,
	[PTH_GND] [nvarchar](50) NULL,
	[TN] [nvarchar](50) NULL,
	[HrsToFail_1Dec] [smallint] NULL,
	[HrsToFail_MinRes] [smallint] NULL,
	[LowestObsRes] [real] NULL,
	[FAResults] [nvarchar](max) NULL,
	[FAAnalyst] [nvarchar](50) NULL,
	[FALocation] [nvarchar](50) NULL,
	[FAPPorCORE] [nvarchar](50) NULL,
	[FADate] [datetime] NULL,
	[FA] [bit] NOT NULL,
	[ConstName] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

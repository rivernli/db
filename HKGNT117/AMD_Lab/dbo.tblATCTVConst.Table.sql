USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblATCTVConst]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblATCTVConst](
	[TVConstID] [int] NOT NULL,
	[TVConstName] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[PPN] [nvarchar](50) NULL,
	[ToolNo] [nvarchar](50) NULL,
	[DesignFilename] [nvarchar](50) NULL,
	[location] [int] NULL,
	[#Layers] [tinyint] NULL,
	[thk] [decimal](5, 4) NULL,
	[Material] [int] NULL,
	[SurfaceFinish] [nvarchar](50) NULL,
	[SolderMask] [nvarchar](50) NULL,
	[Panel_DCorPulse] [nvarchar](50) NULL,
	[Pattern_DCorPulse] [nvarchar](50) NULL,
	[Panel_RecipeName] [nvarchar](255) NULL,
	[Pttern_RecipeName] [nvarchar](255) NULL,
	[HorV] [nvarchar](50) NULL,
	[Panel_CurDen] [smallint] NULL,
	[Panel_PlateTime] [int] NULL,
	[Pattern_CurDen] [smallint] NULL,
	[Pattern_PlateTime] [int] NULL,
	[PlatingLine] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[Stackup] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

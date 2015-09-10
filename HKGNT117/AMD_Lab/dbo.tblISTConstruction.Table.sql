USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTConstruction]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblISTConstruction](
	[Construction ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer Name] [nvarchar](50) NULL,
	[Construction Name] [nvarchar](50) NULL,
	[PPN] [nvarchar](50) NULL,
	[LotNo] [nvarchar](50) NULL,
	[ToolNo] [nvarchar](50) NULL,
	[Design File name] [nvarchar](50) NULL,
	[location] [int] NULL,
	[# Layers] [int] NULL,
	[Coupon Length] [decimal](18, 3) NULL,
	[Coupon Width] [decimal](18, 3) NULL,
	[Coupon thickness] [decimal](5, 4) NULL,
	[MaterialL] [int] NULL,
	[Tg] [nvarchar](50) NULL,
	[Material Tg] [smallint] NULL,
	[T260] [smallint] NULL,
	[T288] [smallint] NULL,
	[CTE Below Tg] [int] NULL,
	[CTE Above Tg] [int] NULL,
	[Surface Finish] [nvarchar](50) NULL,
	[Solder Mask] [nvarchar](50) NULL,
	[P1 Grid Size] [decimal](5, 4) NULL,
	[P2 Grid Size] [decimal](5, 4) NULL,
	[Number of power circuits] [int] NOT NULL,
	[Number of sense circuits] [int] NOT NULL,
	[P1 Via type] [nvarchar](50) NULL,
	[P1 # of vias] [smallint] NULL,
	[P1 drill size] [decimal](6, 5) NULL,
	[P1 pad size] [decimal](5, 4) NULL,
	[P1 Nonfunctional pads] [bit] NOT NULL,
	[P1 Nonfunctional pad dia] [decimal](5, 4) NULL,
	[S1 Via type] [nvarchar](50) NULL,
	[S1 # of vias] [smallint] NULL,
	[S1 drill size] [decimal](6, 5) NULL,
	[S1 pad size] [decimal](5, 4) NULL,
	[S1 Nonfunctional pads] [bit] NOT NULL,
	[S1 Nonfunctional pad dia] [decimal](5, 4) NULL,
	[P2 Via type] [nvarchar](50) NULL,
	[P2 # of vias] [smallint] NULL,
	[P2 drill size] [decimal](6, 5) NULL,
	[P2 pad size] [decimal](5, 4) NULL,
	[P2 Nonfunctional pads] [bit] NOT NULL,
	[P2 Nonfunctional pad dia] [decimal](5, 4) NULL,
	[S2 Via type] [nvarchar](50) NULL,
	[S2 # of vias] [smallint] NULL,
	[S2 drill size] [decimal](6, 5) NULL,
	[S2 pad size] [decimal](5, 4) NULL,
	[S2 Nonfunctional pads] [bit] NOT NULL,
	[S2 Nonfunctional pad dia] [decimal](5, 4) NULL,
	[Stackup] [image] NULL,
	[P1_DIR] [real] NULL,
	[P1_DRR] [real] NULL,
	[P1_SpinSpeed] [int] NULL,
	[P1_StkHeight] [smallint] NULL,
	[Panel_DCorPulse] [nvarchar](50) NULL,
	[Pattern_DCorPulse] [nvarchar](50) NULL,
	[Panel_RecipeName] [nvarchar](255) NULL,
	[Pttern_RecipeName] [nvarchar](255) NULL,
	[HorV] [nvarchar](50) NULL,
	[Panel_CurDen] [smallint] NULL,
	[Panel_PlateTime] [int] NULL,
	[Pattern_CurDen] [smallint] NULL,
	[Pattern_PlateTime] [int] NULL,
	[P2_DIR] [real] NULL,
	[P2_DRR] [real] NULL,
	[P2_SpinSpeed] [int] NULL,
	[P2_StkHeight] [int] NULL,
	[S1_DIR] [real] NULL,
	[S1_DRR] [real] NULL,
	[S1_SpinSpeed] [int] NULL,
	[S1_StkHeight] [int] NULL,
	[S2_DIR] [real] NULL,
	[S2_DRR] [real] NULL,
	[S2_SpinSpeed] [int] NULL,
	[S2_StkHeight] [int] NULL,
	[S1_drillbit] [nvarchar](50) NULL,
	[P1_drillbit] [nvarchar](50) NULL,
	[S2_drillbit] [nvarchar](50) NULL,
	[P2_drillbit] [nvarchar](50) NULL,
	[S1_peck] [tinyint] NULL,
	[P1_peck] [tinyint] NULL,
	[S2_peck] [tinyint] NULL,
	[P2_peck] [tinyint] NULL,
	[S1_maxhit] [smallint] NULL,
	[S2_maxhit] [smallint] NULL,
	[P1_maxhit] [smallint] NULL,
	[P2_maxhit] [smallint] NULL,
	[S1_bit] [nvarchar](50) NULL,
	[S2_bit] [nvarchar](50) NULL,
	[P1_bit] [nvarchar](50) NULL,
	[P2_bit] [nvarchar](50) NULL,
	[Notes] [ntext] NULL,
	[S1_rough] [smallint] NULL,
	[S2_rough] [smallint] NULL,
	[S1_thk] [smallint] NULL,
	[S2_thk] [smallint] NULL,
	[Sns_crazing] [smallint] NULL,
	[Pwr_crazing] [smallint] NULL,
	[FileId] [varchar](50) NULL,
 CONSTRAINT [PK_tblISTConstruction] PRIMARY KEY CLUSTERED 
(
	[Construction ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

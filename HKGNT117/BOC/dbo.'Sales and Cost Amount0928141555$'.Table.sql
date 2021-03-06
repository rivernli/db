USE [BOC]
GO
/****** Object:  Table [dbo].['Sales and Cost Amount0928141555$']    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].['Sales and Cost Amount0928141555$'](
	[id] [nvarchar](255) NULL,
	[Fyear] [nvarchar](255) NULL,
	[Period] [nvarchar](255) NULL,
	[Plant] [nvarchar](255) NULL,
	[Project] [nvarchar](255) NULL,
	[Ship Qty] [float] NULL,
	[SQFT] [float] NULL,
	[Scrap Rate] [float] NULL,
	[Cost Amount(Include Scrap)] [float] NULL,
	[Cost Without Rate] [float] NULL,
	[Up In USD] [float] NULL,
	[Sale Amount] [float] NULL,
	[Total Cost Ex Scrap] [float] NULL,
	[Total Cost in Scrap] [float] NULL,
	[Std Cost Included Scrap] [float] NULL,
	[Std Cost excluded Scrap] [float] NULL,
	[cesu] [float] NULL,
	[cisu] [float] NULL,
	[tciu] [float] NULL,
	[tcuu] [float] NULL,
	[CustPart] [nvarchar](255) NULL,
	[Product Type] [nvarchar](255) NULL,
	[Surface Finsh Code] [nvarchar](255) NULL,
	[OEM Name] [nvarchar](255) NULL,
	[Bom Cost] [nvarchar](255) NULL
) ON [PRIMARY]

GO

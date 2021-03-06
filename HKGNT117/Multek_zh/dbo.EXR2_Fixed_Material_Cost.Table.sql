USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Fixed_Material_Cost]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Fixed_Material_Cost](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [nvarchar](10) NULL,
	[FYear] [nvarchar](50) NULL,
	[Project] [nvarchar](50) NULL,
	[OEM_Name] [nvarchar](50) NULL,
	[Operation] [nvarchar](50) NULL,
	[SaleAmount] [decimal](18, 2) NULL,
	[P01] [nvarchar](50) NULL,
	[P02] [nvarchar](50) NULL,
	[P03] [nvarchar](50) NULL,
	[P04] [nvarchar](50) NULL,
	[P05] [nvarchar](50) NULL,
	[P06] [nvarchar](50) NULL,
	[P07] [nvarchar](50) NULL,
	[P08] [nvarchar](50) NULL,
	[P09] [nvarchar](50) NULL,
	[P10] [nvarchar](50) NULL,
	[P11] [nvarchar](50) NULL,
	[P12] [nvarchar](50) NULL
) ON [PRIMARY]

GO

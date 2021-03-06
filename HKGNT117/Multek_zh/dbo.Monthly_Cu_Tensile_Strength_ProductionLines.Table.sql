USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Monthly_Cu_Tensile_Strength_ProductionLines]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Monthly_Cu_Tensile_Strength_ProductionLines](
	[Lsh] [nvarchar](50) NULL,
	[PLsh] [nvarchar](50) NULL,
	[NodeName] [nvarchar](50) NULL,
	[OrderName] [int] NULL CONSTRAINT [DF_Monthly_Cu_Tensile_Strength_ProductionLines_OrderName]  DEFAULT ((0))
) ON [PRIMARY]

GO

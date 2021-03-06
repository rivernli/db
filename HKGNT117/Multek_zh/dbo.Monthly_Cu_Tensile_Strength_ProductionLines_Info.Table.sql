USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Monthly_Cu_Tensile_Strength_ProductionLines_Info]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Monthly_Cu_Tensile_Strength_ProductionLines_Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Lsh] [nvarchar](50) NULL,
	[PLsh] [nvarchar](50) NULL,
	[Tank] [nvarchar](50) NULL,
 CONSTRAINT [PK_Monthly_Cu_Tensile_Strength_ProductionLines_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

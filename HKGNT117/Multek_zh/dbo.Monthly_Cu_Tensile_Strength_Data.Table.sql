USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Monthly_Cu_Tensile_Strength_Data]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Monthly_Cu_Tensile_Strength_Data](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [varchar](5) NULL,
	[Month] [varchar](2) NULL,
	[Plant] [varchar](5) NULL,
	[ProductionLine] [varchar](50) NULL,
	[Tank] [nvarchar](50) NULL,
	[TankType] [varchar](10) NULL,
	[Type] [nvarchar](50) NULL,
	[SN] [varchar](50) NULL,
	[TestValue] [float] NULL,
	[TestValueMin] [float] NULL,
	[TestValueMax] [float] NULL,
 CONSTRAINT [PK_Monthly_Cu_Tensile_Strength_Data_test] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

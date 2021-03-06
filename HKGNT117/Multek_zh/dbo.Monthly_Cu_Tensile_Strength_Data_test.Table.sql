USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Monthly_Cu_Tensile_Strength_Data_test]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Monthly_Cu_Tensile_Strength_Data_test](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[Plant] [nchar](10) NULL,
	[ProductionLine] [nvarchar](50) NULL,
	[Tank] [varchar](50) NULL,
	[TankType] [varchar](10) NULL,
	[SN] [varchar](10) NULL,
	[TS] [float] NULL,
	[Elongation] [float] NULL,
	[Thickness] [float] NULL,
	[CreateUser] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_Monthly_Cu_Tensile_Strength_Data_CreateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Monthly_Cu_Tensile_Strength_Data] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

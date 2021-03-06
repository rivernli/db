USE [BOC]
GO
/****** Object:  Table [dbo].[tfsboc104180_analyse]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tfsboc104180_analyse](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user] [nvarchar](50) NULL,
	[Cus_Serial] [int] NULL,
	[Serial] [int] NULL,
	[Fiscal_Year] [int] NULL,
	[Fiscal_Period] [int] NULL,
	[Plant] [nvarchar](10) NULL,
	[Product_Type] [nvarchar](50) NULL,
	[No_of_Project] [float] NULL,
	[Avg_Layer_Count] [float] NULL,
	[ASP$] [float] NULL,
	[ASP_Layer] [float] NULL,
	[Output_SQFT] [float] NULL,
	[Output_Percent] [float] NULL,
	[Output_Amount] [float] NULL,
	[Amount_Percent] [float] NULL,
	[Margin$] [float] NULL,
	[Total_Margin_percent] [float] NULL,
	[Margin_Percent] [float] NULL,
	[Consumpton_Percent1] [float] NULL,
	[Consumpton_Percent2] [float] NULL,
	[Consumpton_Percent3] [float] NULL,
	[Consumpton_Percent4] [float] NULL,
	[Consumpton_Percent5] [float] NULL,
	[Consumpton_Percent6] [float] NULL,
	[Consumpton_Percent7] [float] NULL,
	[Consumpton_Percent8] [float] NULL,
	[Consumpton_Percent9] [float] NULL,
	[Consumpton_Percent10] [float] NULL,
	[Consumpton_Percent11] [float] NULL,
	[Consumpton_Percent12] [float] NULL,
	[Consumpton_Percent13] [float] NULL,
	[Consumpton_Percent14] [float] NULL,
	[Consumpton_Percent15] [float] NULL,
	[BOC_Item1] [nvarchar](50) NULL,
	[BOC_Item2] [nvarchar](50) NULL,
	[BOC_Item3] [nvarchar](50) NULL,
	[BOC_Item4] [nvarchar](50) NULL,
	[BOC_Item5] [nvarchar](50) NULL,
	[BOC_Item6] [nvarchar](50) NULL,
	[BOC_Item7] [nvarchar](50) NULL,
	[BOC_Item8] [nvarchar](50) NULL,
	[BOC_Item9] [nvarchar](50) NULL,
	[BOC_Item10] [nvarchar](50) NULL,
	[BOC_Item11] [nvarchar](50) NULL,
	[BOC_Item12] [nvarchar](50) NULL,
	[BOC_Item13] [nvarchar](50) NULL,
	[BOC_Item14] [nvarchar](50) NULL,
	[BOC_Item15] [nvarchar](50) NULL,
 CONSTRAINT [PK_tfsboc104180_analyse_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

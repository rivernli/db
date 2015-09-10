USE [BOC]
GO
/****** Object:  Table [dbo].[tfsboc100180_analyse]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tfsboc100180_analyse](
	[Analysis_User] [nvarchar](50) NOT NULL,
	[Fiscal_Year] [int] NOT NULL,
	[Fiscal_Period] [int] NOT NULL,
	[Plant] [nvarchar](10) NOT NULL,
	[Projects(8)] [nvarchar](10) NOT NULL,
	[Projects(10)] [nvarchar](50) NULL,
	[Project(4)] [nvarchar](50) NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[End_Customer] [nvarchar](50) NULL,
	[Product_Name] [nvarchar](50) NULL,
	[Part_number] [nvarchar](50) NULL,
	[Configuration] [nvarchar](50) NULL,
	[Material-Core] [nvarchar](50) NULL,
	[Material-RCC] [nvarchar](50) NULL,
	[Array Size(mm)] [nvarchar](50) NULL,
	[Unit_per_Panel] [int] NULL,
	[Panel Size(sqft)] [float] NULL,
	[Material_Utilization_per_Panel] [float] NULL,
	[Min_Line_Width & Spacing (mil)] [real] NULL,
	[Mechanical)_Through_Hole] [float] NULL,
	[Mechanical Blind_Buried Hole] [float] NULL,
	[Total Mechanical Hole Count] [float] NULL,
	[Laser Via - External Layer] [float] NULL,
	[Laser Via - Internal Layer] [float] NULL,
	[Total Laser Via Hole Count] [float] NULL,
	[Number of Plating] [float] NULL,
	[Number of Pressing] [float] NULL,
	[Number of Image Transfer] [float] NULL,
	[Surface Finish(EAU)] [nvarchar](50) NULL,
	[Surface Finish(ENTEK)] [nvarchar](50) NULL,
	[Surface Finish(HASL)] [nvarchar](50) NULL,
	[Surface Finish(GOLD PLATE)] [nvarchar](50) NULL,
	[Surface Finish(EAG)] [nvarchar](50) NULL,
	[Surface Finish(ETN)] [nvarchar](50) NULL,
	[X-out] [nvarchar](50) NULL,
	[Boc Item Type1] [nvarchar](50) NULL,
	[Boc Item Type2] [nvarchar](50) NULL,
	[Boc Item Type3] [nvarchar](50) NULL,
	[Boc Item Type4] [nvarchar](50) NULL,
	[Boc Item Type5] [nvarchar](50) NULL,
	[Boc Item Type6] [nvarchar](50) NULL,
	[Boc Item Type7] [nvarchar](50) NULL,
	[Boc Item Type8] [nvarchar](50) NULL,
	[Boc Item Type9] [nvarchar](50) NULL,
	[Boc Item Type10] [nvarchar](50) NULL,
	[Boc Item Type11] [nvarchar](50) NULL,
	[Boc Item Type12] [nvarchar](50) NULL,
	[Boc Item Type13] [nvarchar](50) NULL,
	[Boc Item Type14] [nvarchar](50) NULL,
	[Boc Item Type15] [nvarchar](50) NULL,
	[Boc Consumed1] [float] NULL,
	[Boc Consumed2] [float] NULL,
	[Boc Consumed3] [float] NULL,
	[Boc Consumed4] [float] NULL,
	[Boc Consumed5] [float] NULL,
	[Boc Consumed6] [float] NULL,
	[Boc Consumed7] [float] NULL,
	[Boc Consumed8] [float] NULL,
	[Boc Consumed9] [float] NULL,
	[Boc Consumed10] [float] NULL,
	[Boc Consumed11] [float] NULL,
	[Boc Consumed12] [float] NULL,
	[Boc Consumed13] [float] NULL,
	[Boc Consumed14] [float] NULL,
	[Boc Consumed15] [float] NULL,
	[Percent of Boc Consumed1] [float] NULL,
	[Percent of Boc Consumed2] [float] NULL,
	[Percent of Boc Consumed3] [float] NULL,
	[Percent of Boc Consumed4] [float] NULL,
	[Percent of Boc Consumed5] [float] NULL,
	[Percent of Boc Consumed6] [float] NULL,
	[Percent of Boc Consumed7] [float] NULL,
	[Percent of Boc Consumed8] [float] NULL,
	[Percent of Boc Consumed9] [float] NULL,
	[Percent of Boc Consumed10] [float] NULL,
	[Percent of Boc Consumed11] [float] NULL,
	[Percent of Boc Consumed12] [float] NULL,
	[Percent of Boc Consumed13] [float] NULL,
	[Percent of Boc Consumed14] [float] NULL,
	[Percent of Boc Consumed15] [float] NULL,
	[Cycle time1] [float] NULL,
	[Cycle time2] [float] NULL,
	[Cycle time3] [float] NULL,
	[Cycle time4] [float] NULL,
	[Cycle time5] [float] NULL,
	[Cycle time6] [float] NULL,
	[Cycle time7] [float] NULL,
	[Cycle time8] [float] NULL,
	[Cycle time9] [float] NULL,
	[Cycle time10] [float] NULL,
	[Cycle time11] [float] NULL,
	[Cycle time12] [float] NULL,
	[Cycle time13] [float] NULL,
	[Cycle time14] [float] NULL,
	[Cycle time15] [float] NULL,
	[Selling Price Per Unit (US$)] [float] NULL,
	[ASP US$] [float] NULL,
	[Yield (Current)%] [float] NULL,
	[Material cost (Scrap included)] [float] NULL,
	[Material Cost _Sale(Current)] [float] NULL,
	[Total Cost per unit(US$)] [float] NULL,
	[%Margin] [float] NULL,
	[Profit per PCS] [float] NULL,
	[Production Volume Booking (Units)] [float] NULL,
	[Production Volume Booking (Square F] [float] NULL,
	[% of Production Volume (Square Foot] [float] NULL,
	[Total Sales (USD)] [float] NULL,
	[% of Total Sales] [float] NULL,
	[Batch No] [float] NULL,
	[Data Source] [float] NULL,
	[% of Margin (total)] [float] NULL,
	[Margin$ (total)] [float] NULL,
	[Dis-Selling Price Per Unit (US$)] [float] NULL,
	[Dis-Material Cost / Sale(Current)] [float] NULL,
	[%Dis-Margin] [float] NULL,
	[Dis-Total Sales (USD)] [float] NULL,
	[Dis-Margin$ (total)] [float] NULL,
	[Dis-Profit per PCS] [float] NULL,
	[Dis-ASP US$] [float] NULL,
	[Dis-of Total Sales] [float] NULL,
	[Dis-of Margin (total)] [float] NULL,
	[Direct.Labor] [float] NULL,
	[Indirect.Labor] [float] NULL,
	[Material.Cost] [float] NULL,
	[Process.Cost] [float] NULL,
	[Dos.Cost] [float] NULL,
	[Oh.Depreciation] [float] NULL,
	[Oh.Maintenance] [float] NULL,
	[Las.Depreciation] [float] NULL,
	[Las.Maintenance] [float] NULL,
	[Oh.Eletricity] [float] NULL,
	[Oh.Fresh.Water] [float] NULL,
	[Oh.Waste.Water] [float] NULL,
	[Oh.Land] [float] NULL,
	[T$GSRS] [float] NULL,
	[T$TCUS] [float] NULL,
	[Column 136] [nvarchar](50) NULL,
 CONSTRAINT [PK_tfsboc100180_analysis] PRIMARY KEY CLUSTERED 
(
	[Analysis_User] ASC,
	[Fiscal_Year] ASC,
	[Fiscal_Period] ASC,
	[Plant] ASC,
	[Projects(8)] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

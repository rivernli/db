USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sgp_cost]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sgp_cost](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sgp_id] [int] NOT NULL,
	[Plant] [nvarchar](2) NULL,
	[Project] [nvarchar](10) NULL,
	[MOH_Version] [nvarchar](8) NULL,
	[Cost_Version] [int] NULL,
	[BOM_version] [int] NULL,
	[Creation_Date] [datetime] NULL,
	[Creation_User] [nvarchar](10) NULL,
	[Last_Calculate_Date] [datetime] NULL,
	[Cost_Sheet_Status] [nvarchar](15) NULL,
	[Unit_Set] [decimal](18, 4) NULL,
	[Set_PNL] [decimal](18, 4) NULL,
	[PNL_area] [decimal](18, 4) NULL,
	[Scrap_Rate_Being_Used] [decimal](18, 4) NULL,
	[Laminate] [decimal](18, 4) NULL,
	[Prepreg] [decimal](18, 4) NULL,
	[Copper_Foil] [decimal](18, 4) NULL,
	[RCC_Foil] [decimal](18, 4) NULL,
	[Coin] [decimal](18, 4) NULL,
	[Dry_Film] [decimal](18, 4) NULL,
	[SMCM] [decimal](18, 4) NULL,
	[FCCL] [decimal](18, 4) NULL,
	[Coverlay] [decimal](18, 4) NULL,
	[Adhesive] [decimal](18, 4) NULL,
	[Stiffener] [decimal](18, 4) NULL,
	[Sheildling_Film] [decimal](18, 4) NULL,
	[Gold] [decimal](18, 4) NULL,
	[Drill_Bit] [decimal](18, 4) NULL,
	[Bevelling_Tool] [decimal](18, 4) NULL,
	[Countersink] [decimal](18, 4) NULL,
	[Miling_Tool] [decimal](18, 4) NULL,
	[Router] [decimal](18, 4) NULL,
	[Other_EDM_Mat] [decimal](18, 4) NULL,
	[Total_Material_Cost] [decimal](18, 4) NULL,
	[Direct_Labor] [decimal](18, 4) NULL,
	[Indirect_Salaries_Benefit] [decimal](18, 4) NULL,
	[Depreciation_Amortization] [decimal](18, 4) NULL,
	[Equipment_Expenses] [decimal](18, 4) NULL,
	[Facilities_Utilities] [decimal](18, 4) NULL,
	[Computer_Related] [decimal](18, 4) NULL,
	[Supplies] [decimal](18, 4) NULL,
	[Travel_Entertainment] [decimal](18, 4) NULL,
	[Other_Expenses] [decimal](18, 4) NULL,
	[SGA_Cost] [decimal](18, 4) NULL,
	[Calculate_Unit] [nvarchar](10) NULL
) ON [PRIMARY]
GO

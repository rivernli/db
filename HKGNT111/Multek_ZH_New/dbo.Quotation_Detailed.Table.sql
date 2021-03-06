USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[Quotation_Detailed]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Quotation_Detailed](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Lsh] [varchar](50) NULL,
	[Plant] [nchar](10) NULL,
	[ProjectNo] [nvarchar](50) NULL,
	[NewCostModelVers] [varchar](50) NULL,
	[FromSern] [varchar](10) NULL,
	[FromBOM] [varchar](10) NULL,
	[UploadDate] [varchar](10) NULL,
	[UploadUser] [nvarchar](50) NULL,
	[CalculateDate] [varchar](10) NULL,
	[UnitSet] [int] NULL,
	[SetPNL] [int] NULL,
	[PNLArea] [float] NULL,
	[ScrapRateBeingUsed] [float] NULL,
	[Laminate] [float] NULL,
	[Prepreg] [float] NULL,
	[CopperFoil] [float] NULL,
	[RCCFoil] [float] NULL,
	[Coin] [float] NULL,
	[DryFilm] [float] NULL,
	[SMCM] [float] NULL,
	[FCCL] [float] NULL,
	[Coverlay] [float] NULL,
	[Adhesive] [float] NULL,
	[Stiffener] [float] NULL,
	[SheildlingFilm] [float] NULL,
	[Gold] [float] NULL,
	[DrillBit] [float] NULL,
	[BevellingTool] [float] NULL,
	[Countersink] [float] NULL,
	[MilingTool] [float] NULL,
	[Router] [float] NULL,
	[OtherEDMMat] [float] NULL,
	[TotalMaterialCost] [float] NULL,
	[DirectLabor] [float] NULL,
	[IndirectSalariesBenefit] [float] NULL,
	[DepreciationAmortization] [float] NULL,
	[EquipmentExpenses] [float] NULL,
	[FacilitiesUtilities] [float] NULL,
	[ComputerRelated] [float] NULL,
	[Supplies] [float] NULL,
	[TravelEntertainment] [float] NULL,
	[OtherExpenses] [float] NULL,
	[SGACost] [float] NULL,
	[CalculateUnit] [varchar](50) NULL,
	[ErrorRemark] [nvarchar](50) NULL,
	[EAU] [nvarchar](50) NULL,
	[Difficulty] [float] NULL,
	[DifficultyRemark] [nvarchar](50) NULL,
 CONSTRAINT [PK_QuotationList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

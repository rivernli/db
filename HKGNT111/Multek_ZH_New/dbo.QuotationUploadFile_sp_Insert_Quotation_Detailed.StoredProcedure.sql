USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_Insert_Quotation_Detailed]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuotationUploadFile_sp_Insert_Quotation_Detailed] 	
		   @Lsh varchar(50),
           @Plant nchar(10),
           @ProjectNo nvarchar(50),
           @NewCostModelVers varchar(50),
           @FromSern varchar(10),
           @FromBOM varchar(10),
           @UploadDate varchar(10),
           @UploadUser nvarchar(50),
           @CalculateDate varchar(10),
           @UnitSet int=NULL,
           @SetPNL int=NULL,
           @PNLArea float=NULL,
           @ScrapRateBeingUsed float=NULL,
           @Laminate float=NULL,
           @Prepreg float=NULL,
           @CopperFoil float=NULL,
           @RCCFoil float=NULL,
           @Coin float=NULL,
           @DryFilm float=NULL,
           @SMCM float=NULL,
           @FCCL float=NULL,
           @Coverlay float=NULL,
           @Adhesive float=NULL,
           @Stiffener float=NULL,
           @SheildlingFilm float=NULL,
           @Gold float=NULL,
           @DrillBit float=NULL,
           @BevellingTool float=NULL,
           @Countersink float=NULL,
           @MilingTool float=NULL,
           @Router float=NULL,
           @OtherEDMMat float=NULL,
           @TotalMaterialCost float=NULL,
           @DirectLabor float=NULL,
           @IndirectSalariesBenefit float=NULL,
           @DepreciationAmortization float=NULL,
           @EquipmentExpenses float=NULL,
           @FacilitiesUtilities float=NULL,
           @ComputerRelated float=NULL,
           @Supplies float=NULL,
           @TravelEntertainment float=NULL,
           @OtherExpenses float=NULL,
           @SGACost float=NULL,
           @CalculateUnit varchar(50),
           @ErrorRemark NVARCHAR(50),
           @EAU NVARCHAR(50),
           @Difficulty float=NULL,
           @DifficultyRemark NVARCHAR(50) 
AS

INSERT INTO [Quotation_Detailed]
           ([Lsh]
           ,[Plant]
           ,[ProjectNo]
           ,[NewCostModelVers]
           ,[FromSern]
           ,[FromBOM]
           ,[UploadDate]
           ,[UploadUser]
           ,[CalculateDate]
           ,[UnitSet]
           ,[SetPNL]
           ,[PNLArea]
           ,[ScrapRateBeingUsed]
           ,[Laminate]
           ,[Prepreg]
           ,[CopperFoil]
           ,[RCCFoil]
           ,[Coin]
           ,[DryFilm]
           ,[SMCM]
           ,[FCCL]
           ,[Coverlay]
           ,[Adhesive]
           ,[Stiffener]
           ,[SheildlingFilm]
           ,[Gold]
           ,[DrillBit]
           ,[BevellingTool]
           ,[Countersink]
           ,[MilingTool]
           ,[Router]
           ,[OtherEDMMat]
           ,[TotalMaterialCost]
           ,[DirectLabor]
           ,[IndirectSalariesBenefit]
           ,[DepreciationAmortization]
           ,[EquipmentExpenses]
           ,[FacilitiesUtilities]
           ,[ComputerRelated]
           ,[Supplies]
           ,[TravelEntertainment]
           ,[OtherExpenses]
           ,[SGACost]
           ,[CalculateUnit]
           ,[ErrorRemark]
           ,[EAU]
           ,[Difficulty]
           ,[DifficultyRemark]
           )
     VALUES
           (
           @Lsh,
           @Plant, 
           @ProjectNo, 
           @NewCostModelVers, 
           @FromSern, 
           @FromBOM, 
           @UploadDate,
           @UploadUser, 
           @CalculateDate,
           @UnitSet,
           @SetPNL, 
           @PNLArea, 
           @ScrapRateBeingUsed, 
           @Laminate, 
           @Prepreg, 
           @CopperFoil, 
           @RCCFoil, 
           @Coin, 
           @DryFilm, 
           @SMCM, 
           @FCCL, 
           @Coverlay, 
           @Adhesive, 
           @Stiffener, 
           @SheildlingFilm, 
           @Gold, 
           @DrillBit, 
           @BevellingTool, 
           @Countersink, 
           @MilingTool, 
           @Router, 
           @OtherEDMMat, 
           @TotalMaterialCost, 
           @DirectLabor, 
           @IndirectSalariesBenefit, 
           @DepreciationAmortization, 
           @EquipmentExpenses, 
           @FacilitiesUtilities, 
           @ComputerRelated, 
           @Supplies, 
           @TravelEntertainment, 
           @OtherExpenses, 
           @SGACost, 
           @CalculateUnit,
           @ErrorRemark,
           @EAU,
           @Difficulty,
           @DifficultyRemark
           )
GO

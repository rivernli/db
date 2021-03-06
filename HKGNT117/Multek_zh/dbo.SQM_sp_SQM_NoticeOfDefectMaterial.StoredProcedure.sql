USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_SQM_NoticeOfDefectMaterial]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SQM_sp_SQM_NoticeOfDefectMaterial] 	
	@ID INT=NULL,
	@Functional_defects bit,
	@Non_functional_defects bit,
	@scrap_Qty NVARCHAR(50),
	@CARPM_No NVARCHAR(50),
	@InvestigationResultandVerification NVARCHAR(max),
	@Usdisposition bit,
	@UsdispositionValue NVARCHAR(200),
	@RTV bit,
	@claimonvendor bit,
	@Otherdisposition bit,
	@OtherdispositionValue NVARCHAR(200),
	@QA_Manager NVARCHAR(50),
	@QA_Manager_Date VARCHAR(25),
	@PE_Manager NVARCHAR(50),
	@PE_Manager_Date VARCHAR(25),
	@PPC_Manager NVARCHAR(50),
	@PPC_Manager_Date VARCHAR(25),
	@SQMVerifier_Userid NVARCHAR(50) ,
	@SQMVerifier NVARCHAR(50) ,
	@SQMVerifier_Date VARCHAR(25), 
	@PUR_Quality INT=NULL 
AS

	BEGIN
		UPDATE SQM_NoticeOfDefectMaterial
		SET Functional_defects=@Functional_defects, Non_functional_defects=@Non_functional_defects, scrap_Qty=@scrap_Qty, CARPM_No=@CARPM_No, 
		InvestigationResultandVerification=@InvestigationResultandVerification, Usdisposition=@Usdisposition, UsdispositionValue=@UsdispositionValue, RTV=@RTV, 
		claimonvendor=@claimonvendor, Otherdisposition=@Otherdisposition, OtherdispositionValue=@OtherdispositionValue, QA_Manager=@QA_Manager, QA_Manager_Date=@QA_Manager_Date, PE_Manager=@PE_Manager, PE_Manager_Date=@PE_Manager_Date, 
		PPC_Manager=@PPC_Manager, PPC_Manager_Date=@PPC_Manager_Date, SQMVerifier_Userid=@SQMVerifier_Userid, SQMVerifier=@SQMVerifier, SQMVerifier_Date=@SQMVerifier_Date, PUR_Quality=@PUR_Quality 
		WHERE ID=@ID 
	END








GO

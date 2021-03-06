USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_IncomingMaterialCheckForm_SQM_B2F]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[SQM_sp_IncomingMaterialCheckForm_SQM_B2F] 	
	@ID INT=NULL,	
	@CARPM_No NVARCHAR(50),
	@InvestigationResultandVerification NVARCHAR(max),
	@Usdisposition bit,
	@UsdispositionValue NVARCHAR(200),
	@RTV bit,
	@claimonvendor bit,
	@Otherdisposition bit,
	@OtherdispositionValue NVARCHAR(200),
	@SQMVerifier_Userid NVARCHAR(50) ,
	@SQMVerifier NVARCHAR(50) ,
	@SQMVerifier_Date VARCHAR(25) 
AS

	BEGIN
		UPDATE SQM_IncomingMaterialCheck_B2F
		SET CARPM_No=@CARPM_No, InvestigationResultandVerification=@InvestigationResultandVerification, Usdisposition=@Usdisposition, 
			UsdispositionValue=@UsdispositionValue, RTV=@RTV, claimonvendor=@claimonvendor, Otherdisposition=@Otherdisposition, 
			OtherdispositionValue=@OtherdispositionValue, SQMVerifier_Userid=@SQMVerifier_Userid, SQMVerifier=@SQMVerifier, SQMVerifier_Date=@SQMVerifier_Date 
		WHERE ID=@ID 
	END








GO

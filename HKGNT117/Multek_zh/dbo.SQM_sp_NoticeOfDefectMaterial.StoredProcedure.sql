USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_NoticeOfDefectMaterial]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[SQM_sp_NoticeOfDefectMaterial] 	
	 @ID INT=NULL,
	 @Plant NVarChar(50),
	 @Notice_No NVarChar(50),
	 @Prod Bit,
	 @Other Bit,
	 @OtherValue NVarChar(50),
	 @PE Bit,
	 @IQC Bit,
	 @PPC Bit,
	 @SQM Bit,
	 @PUR Bit,	
	 @QAManager Bit,
	 @PEManager Bit,
	 @PPCManager Bit,
	 @PDManager Bit,
	 @ProcurementManager Bit,
	 @SQMManager Bit,	 
	 @PN NVarChar(50),
	 @Vendor NVarChar(50),
	 @Manufacturer NVarChar(50),
	 @location NVarChar(50),
	 @Material NVarChar(50),
	 @Description NVarChar(50),
	 @RoHS NVarChar(50),
	 @HF NVarChar(50),
	 @Related_PN NVarChar(50),
	 @Size NVarChar(50),
	 @Receiving_Date NVarChar(50),
	 @Manufacturer_Date NVarChar(20),
	 @lot_No NVarChar(200),
	 @Consumed_Qty NVarChar(50),
	 @Defective_Qty NVarChar(50),
	 @Prblem_Description NVarChar(max),
	 @Defect_Rate NVarChar(50),
	 @Affected_Qty NVarChar(50),
	 @Problem_Found NVarChar(50),
	 @Attachment NVarChar(50),
	 @SQMAttachment NVarChar(50),
	 @Process_Affected NVarChar(max),
	 @FG_Store NVarChar(50),
	 @Etching NVarChar(50),
	 @AOI NVarChar(50),
	 @Drilling NVarChar(50),
	 @ENIG NVarChar(5),
	 @Routing NVarChar(50),
	 @Pressing NVarChar(50),
	 @Immersion_tin NVarChar(50),
	 @E_test NVarChar(50),
	 @PTH NVarChar(50),
	 @ImmersionAg NVarChar(50),
	 @FQC NVarChar(50),
	 @DFM NVarChar(50),
	 @GF NVarChar(50),
	 @SMT NVarChar(50),
	 @Entek NVarChar(50),
	 @HAL NVarChar(50),
	 @Others NVarChar(50),
	 @Initiator_Userid NVarChar(50),
	 @Initiator NVarChar(50),
	 @Initiator_Date NVarChar(20),	
	 @PE_Verification_Userid NVarChar(50),
	 @PE_Verification NVarChar(50),
	 @PE_Verification_Date NVarChar(20),
	 @IQC_Verification_Userid NVarChar(50),
	 @IQC_Verification NVarChar(50),
	 @IQC_Verification_Date NVarChar(20),	
	 @TaskId NVARCHAR(50),	
     @PNType NVARCHAR(50),
	 @w0 NVARCHAR(50),
	 @w1 NVARCHAR(50),
	 @w2 NVARCHAR(50),
	 @w3 NVARCHAR(50),
	 @w4 NVARCHAR(50),
	 @IsSTS VARCHAR(50),
	 @PEVerification Bit,
	 @Operation VARCHAR(10)
AS
IF @Operation='Insert' 
	BEGIN
		INSERT INTO SQM_NoticeOfDefectMaterial (Plant, Notice_No, Prod, Other, OtherValue, PE, IQC, PPC, SQM, PUR, QAManager, PEManager, PPCManager, 
		PDManager, ProcurementManager, SQMManager, PN, Vendor,	Manufacturer, location, Material, Description, RoHS,HF, Related_PN, [Size], Receiving_Date, Manufacturer_Date, lot_No, Consumed_Qty, 
		Defective_Qty, Prblem_Description, Defect_Rate, Affected_Qty, Problem_Found, Attachment, SQMAttachment, Process_Affected, FG_Store, Etching, AOI, Drilling, ENIG, 
		Routing, Pressing, Immersion_tin, E_test, PTH, ImmersionAg, FQC, DFM, GF, SMT, Entek, HAL, Others, Initiator_Userid, Initiator, Initiator_Date, 
		PE_Verification_Userid, PE_Verification, PE_Verification_Date, IQC_Verification_Userid, IQC_Verification, IQC_Verification_Date, TaskId, PNType,w0,w1,w2,w3,w4,IsSTS,PEVerification)
			VALUES (@Plant,@Notice_No,@Prod,@Other,@OtherValue,@PE,@IQC,@PPC,@SQM,@PUR,@QAManager, @PEManager, @PPCManager, 
		@PDManager, @ProcurementManager, @SQMManager,@PN,@Vendor,@Manufacturer,@location,
		@Material,@Description,@RoHS,@HF,@Related_PN,@Size,@Receiving_Date,@Manufacturer_Date,@lot_No,@Consumed_Qty,@Defective_Qty,@Prblem_Description,
		@Defect_Rate,@Affected_Qty,@Problem_Found,@Attachment, @SQMAttachment, @Process_Affected,@FG_Store,@Etching,@AOI,@Drilling,@ENIG,@Routing,@Pressing,@Immersion_tin,
		@E_test,@PTH,@ImmersionAg,@FQC,@DFM,@GF,@SMT,@Entek,@HAL,@Others,@Initiator_Userid,@Initiator,@Initiator_Date,
		@PE_Verification_Userid, @PE_Verification, @PE_Verification_Date, @IQC_Verification_Userid, @IQC_Verification, @IQC_Verification_Date, @TaskId, @PNType,@w0,@w1,@w2,@w3,@w4,@IsSTS,@PEVerification) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE SQM_NoticeOfDefectMaterial 
		SET Plant=@Plant, Notice_No=@Notice_No, Prod=@Prod, Other=@Other, OtherValue=@OtherValue, PE=@PE, IQC=@IQC, PPC=@PPC, SQM=@SQM, PUR=@PUR, 
		QAManager=@QAManager, PEManager=@PEManager, PPCManager=@PPCManager, PDManager=@PDManager, ProcurementManager=@ProcurementManager, SQMManager=@SQMManager, PN=@PN, Vendor=@Vendor,
		Manufacturer=@Manufacturer, location=@location, Material=@Material, Description=@Description, RoHS=@RoHS, HF=@HF, Related_PN=@Related_PN, [Size]=@Size, Receiving_Date=@Receiving_Date, 
		Manufacturer_Date=@Manufacturer_Date, lot_No=@lot_No, Consumed_Qty=@Consumed_Qty, Defective_Qty=@Defective_Qty,Prblem_Description=@Prblem_Description, 
		Defect_Rate=@Defect_Rate, Affected_Qty=@Affected_Qty, Problem_Found=@Problem_Found, Attachment=@Attachment, SQMAttachment=@SQMAttachment, Process_Affected=@Process_Affected, FG_Store=@FG_Store, Etching=@Etching, AOI=@AOI, Drilling=@Drilling, ENIG=@ENIG, 
		Routing=@Routing, Pressing=@Pressing, Immersion_tin=@Immersion_tin, E_test=@E_test, PTH=@PTH, ImmersionAg=@ImmersionAg, FQC=@FQC, DFM=@DFM, GF=@GF, SMT=@SMT, Entek=@Entek, HAL=@HAL, Others=@Others, 
		Initiator_Userid=@Initiator_Userid, Initiator=@Initiator, Initiator_Date=@Initiator_Date, PE_Verification_Userid=@PE_Verification_Userid, PE_Verification=@PE_Verification, PE_Verification_Date=@PE_Verification_Date, 
		IQC_Verification_Userid=@IQC_Verification_Userid, IQC_Verification=@IQC_Verification, IQC_Verification_Date=@IQC_Verification_Date, PNType=@PNType, 
		w0=@w0,w1=@w1,w2=@w2,w3=@w3,w4=@w4,IsSTS=@IsSTS, PEVerification=@PEVerification 
		WHERE ID=@ID 
	return @ID 
	END
























GO

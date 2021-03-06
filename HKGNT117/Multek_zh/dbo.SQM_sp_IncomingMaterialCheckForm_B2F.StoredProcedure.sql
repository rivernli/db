USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_IncomingMaterialCheckForm_B2F]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SQM_sp_IncomingMaterialCheckForm_B2F] 	
		@ID INT=NULL,
		@Material NVarChar(50),
		@Plant NVarChar(50),
		@Date VarChar(20),
		@F_N NVarChar(20),
		@PN NVarChar(50),
		@Vendor NVarChar(50),				
		@Location NVarChar(50),
		@Vendor_PN NVarChar(50),
		@Type_Diameter NVarChar(50),
		@Rc_Ply_Up NVarChar(50),
		@Core_thickness NVarChar(50),
		@Construction NVarChar(50),
		@Copper_thickness NVarChar(50),
		@Copper_Treatment NVarChar(50),
		@Size NVarChar(50),
		@HF NVarChar(50),
		@RoHs NVarChar(50),
		@Description NVarChar(200),
		@Receiving_Date VarChar(20),
		@Manufacturer nvarchar(200),
		@Manafacture_Date VarChar(20),
		@Po_Number NVarChar(50),
		@Qty NVarChar(50),
		@PackageNo NVarChar(50),
        @DeliveryTime NVarChar(50),
        @Box NVarChar(50),
        @LotSize NVarChar(50),
        @CartonNo NVarChar(50),
		@Package INT,
		@CoA Bit,
		@CoAAttachment NVarChar(50),
		@shipment Bit,
		@Inspct_Bill Bit,
		@Conclusion INT,				
		@UAI_REJ INT,
		@UAIOther NVARCHAR(200),
		@RejOther NVARCHAR(200),
		@Checked_Userid NVarChar(50),
		@Checked_By NVarChar(50),
		@Checked_Date VarChar(20),
		@Approved_Userid NVarChar(50),
		@Approved_By NVarChar(50),
		@Approved_Date VarChar(20),
		@TaskId NVARCHAR(50),
		@Attachment NVARCHAR(50),
		@SQMAttachment NVARCHAR(50),
		@IsSTS NVARCHAR(50),
		@Operation VARCHAR(10)='Update'
AS
IF @Operation='Insert' 
	BEGIN
		INSERT INTO SQM_IncomingMaterialCheck_B2F (Material, Plant, Date, F_N, PN, Vendor, Location, Vendor_PN, Type_Diameter, Rc_Ply_Up, Core_thickness, Construction, 
		Copper_thickness, Copper_Treatment, [Size], HF, RoHs, Description, Receiving_Date, Manufacturer, Manafacture_Date, Po_Number, Qty, PackageNo, DeliveryTime, Box, LotSize, CartonNo, Package, CoA, CoAAttachment, shipment, 
		Inspct_Bill, Conclusion, UAI_REJ, UAIOther, RejOther, Checked_Userid,Checked_By, Checked_Date, Approved_Userid, Approved_By, Approved_Date, TaskId, Attachment, SQMAttachment, IsSTS
		)
					VALUES(@Material, @Plant, @Date, @F_N, @PN, @Vendor, @Location, @Vendor_PN, @Type_Diameter, @Rc_Ply_Up, @Core_thickness, @Construction, 
@Copper_thickness, @Copper_Treatment, @Size, @HF, @RoHs, @Description, @Receiving_Date, @Manufacturer, @Manafacture_Date, @Po_Number, @Qty, @PackageNo, @DeliveryTime, @Box, @LotSize, @CartonNo, @Package, @CoA, @CoAAttachment, @shipment, 
		@Inspct_Bill, @Conclusion, @UAI_REJ, @UAIOther, @RejOther, @Checked_Userid, @Checked_By, @Checked_Date, @Approved_Userid, @Approved_By, @Approved_Date, @TaskId, @Attachment, @SQMAttachment, @IsSTS
		) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE SQM_IncomingMaterialCheck_B2F
		SET Material=@Material, Plant=@Plant, Date=@Date, F_N=@F_N, PN=@PN, Vendor=@Vendor, Location=@Location, Vendor_PN=@Vendor_PN, Type_Diameter=@Type_Diameter, 
		Rc_Ply_Up=Rc_Ply_Up, Core_thickness=@Core_thickness, Construction=@Construction, Copper_thickness=@Copper_thickness, Copper_Treatment=@Copper_Treatment, [Size]=@Size,
        HF=@HF, RoHs=@RoHs, Description=@Description, Receiving_Date=@Receiving_Date, Manufacturer=@Manufacturer, Manafacture_Date=@Manafacture_Date, Po_Number=@Po_Number, Qty=@Qty, PackageNo=@PackageNo, DeliveryTime=@DeliveryTime, Box=@Box, LotSize=@LotSize, CartonNo=@CartonNo, Package=@Package, CoA=@CoA, CoAAttachment=@CoAAttachment,
		shipment=@shipment, Inspct_Bill=@Inspct_Bill, Conclusion=@Conclusion, UAI_REJ=@UAI_REJ, UAIOther=@UAIOther, RejOther=@RejOther, Checked_Userid=@Checked_Userid, Checked_By=@Checked_By, Checked_Date=@Checked_Date, 
		Approved_Userid=@Approved_Userid, Approved_By=@Approved_By, Approved_Date=@Approved_Date, Attachment=@Attachment, SQMAttachment=@SQMAttachment, IsSTS=@IsSTS 
		WHERE ID=@ID 	
	return @ID 
	END
















GO

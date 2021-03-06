USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B2F_Forecast_detail_sp_Insert_Update]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[B2F_Forecast_detail_sp_Insert_Update]
	@MID INT=NULL,
	@Month VARCHAR(50),
	@Qtr VARCHAR(50),
	@OEM NVARCHAR(50),
	@PartNumber NVARCHAR(50),
	@Internalprojectno VARCHAR(50),
	@ForecastQty VARCHAR(20),
	@SQFT_PNL VARCHAR(20),
	@FPCUnitPrice VARCHAR(20),
	@BOMPrice VARCHAR(20),
	@SMTPrice VARCHAR(50),
	@Lsh VARCHAR(20),
	@Operation VARCHAR(10) 
AS

IF @Operation='Insert' 
	BEGIN		 
			INSERT INTO B2F_Forecast_detail (MID,[Month],Qtr,[OEM],PartNumber,Internalprojectno,ForecastQty,SQFT_PNL,FPCUnitPrice,BOMPrice,SMTPrice,Lsh)
			VALUES(@MID,@Month,@Qtr,@OEM,@PartNumber,@Internalprojectno,@ForecastQty,@SQFT_PNL,@FPCUnitPrice,@BOMPrice,@SMTPrice,@Lsh) 
	END 

IF @Operation='Update' 
	BEGIN
			UPDATE B2F_Forecast_detail SET [Month]=@Month,Qtr=@Qtr,[OEM]=@OEM,PartNumber=@PartNumber,Internalprojectno=@Internalprojectno,
										 ForecastQty=@ForecastQty,SQFT_PNL=@SQFT_PNL,FPCUnitPrice=@FPCUnitPrice,BOMPrice=@BOMPrice,SMTPrice=@SMTPrice 
			WHERE Lsh=@Lsh 	
	END


















GO

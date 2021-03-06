USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B2F_Forecast_detail_New_sp_Insert_Update]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE PROCEDURE [dbo].[B2F_Forecast_detail_New_sp_Insert_Update]
	@Month VARCHAR(50),
	@Qtr VARCHAR(50),
	@OEM NVARCHAR(50),
	@PartNumber NVARCHAR(50),
	@Internalprojectno VARCHAR(50),
	@ForecastQty VARCHAR(20),
	@Array VARCHAR(20),
	@SQFT_PNL VARCHAR(20),
	@FPCUnitPrice VARCHAR(20),
	@BOMPrice VARCHAR(20),
	@SMTPrice VARCHAR(50),
	@UserName NVARCHAR(50),
	@InitiatorAccount VARCHAR(50),
	@InitiatorDate DATETIME=NULL,
	@Lsh VARCHAR(20),
	@Operation VARCHAR(10) 
AS

IF @Operation='Insert' 
	BEGIN		 
			INSERT INTO B2F_Forecast_detail_New ([Month],Qtr,[OEM],PartNumber,Internalprojectno,ForecastQty,Array,SQFT_PNL,FPCUnitPrice,BOMPrice,SMTPrice,UserName,InitiatorAccount,InitiatorDate,Lsh)
			VALUES(@Month,@Qtr,@OEM,@PartNumber,@Internalprojectno,@ForecastQty,@Array,@SQFT_PNL,@FPCUnitPrice,@BOMPrice,@SMTPrice,@UserName,@InitiatorAccount,@InitiatorDate,@Lsh) 
	END 

IF @Operation='Update' 
	BEGIN
			UPDATE B2F_Forecast_detail_New SET [Month]=@Month,Qtr=@Qtr,[OEM]=@OEM,PartNumber=@PartNumber,Internalprojectno=@Internalprojectno,
										 ForecastQty=@ForecastQty,Array=@Array,SQFT_PNL=@SQFT_PNL,FPCUnitPrice=@FPCUnitPrice,BOMPrice=@BOMPrice,SMTPrice=@SMTPrice 
			WHERE Lsh=@Lsh 	
	END



















GO

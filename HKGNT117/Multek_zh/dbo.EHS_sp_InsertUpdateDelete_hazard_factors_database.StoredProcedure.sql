USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_InsertUpdateDelete_hazard_factors_database]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE PROCEDURE [dbo].[EHS_sp_InsertUpdateDelete_hazard_factors_database] 	
		@ID INT=NULL,
		@Post_operation_content NVARCHAR(100),
		@adverse_factor_1 NVARCHAR(50),		
		@adverse_factor_2 NVARCHAR(50),		
		@adverse_factor_3 NVARCHAR(50),		
		@adverse_factor_4 NVARCHAR(50),		
		@adverse_factor_5 NVARCHAR(50),		
		@adverse_factor_6 NVARCHAR(50),		
		@adverse_factor_7 NVARCHAR(50),		
		@adverse_factor_8 NVARCHAR(50),		
		@adverse_factor_9 NVARCHAR(50),		
		@adverse_factor_10 NVARCHAR(50),
		@adverse_factor_11 NVARCHAR(50),
		@adverse_factor_12 NVARCHAR(50),
		@adverse_factor_13 NVARCHAR(50),
		@adverse_factor_14 NVARCHAR(50),
		@adverse_factor_15 NVARCHAR(50),
		@Post_medical_package_Id NVARCHAR(50), 
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO EHS_Postandhazardfactorsmatching 
			(Post_operation_content, adverse_factor_1, adverse_factor_2, adverse_factor_3, adverse_factor_4, adverse_factor_5, adverse_factor_6, adverse_factor_7, adverse_factor_8, adverse_factor_9, adverse_factor_10, adverse_factor_11, adverse_factor_12, adverse_factor_13, adverse_factor_14, adverse_factor_15, Post_medical_package_Id)
		VALUES
			(@Post_operation_content, @adverse_factor_1, @adverse_factor_2, @adverse_factor_3, @adverse_factor_4, @adverse_factor_5, @adverse_factor_6, @adverse_factor_7, @adverse_factor_8, @adverse_factor_9, @adverse_factor_10, @adverse_factor_11, @adverse_factor_12, @adverse_factor_13, @adverse_factor_14, @adverse_factor_15, @Post_medical_package_Id) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE EHS_Postandhazardfactorsmatching
		SET Post_operation_content=@Post_operation_content, adverse_factor_1=@adverse_factor_1, adverse_factor_2=@adverse_factor_2, adverse_factor_3=@adverse_factor_3, adverse_factor_4=@adverse_factor_4, adverse_factor_5=@adverse_factor_5, adverse_factor_6=@adverse_factor_6, 
			adverse_factor_7=@adverse_factor_7, adverse_factor_8=@adverse_factor_8, adverse_factor_9=@adverse_factor_9, adverse_factor_10=@adverse_factor_10,
			adverse_factor_11=@adverse_factor_11, adverse_factor_12=@adverse_factor_12, adverse_factor_13=@adverse_factor_13, adverse_factor_14=@adverse_factor_14, adverse_factor_15=@adverse_factor_15, Post_medical_package_Id=@Post_medical_package_Id 
		WHERE ID=@ID 	
	return @ID 
	END




GO

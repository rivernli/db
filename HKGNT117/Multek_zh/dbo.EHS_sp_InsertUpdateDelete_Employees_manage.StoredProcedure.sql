USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_InsertUpdateDelete_Employees_manage]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[EHS_sp_InsertUpdateDelete_Employees_manage] 	
		@ID INT=NULL,
		@departmentId INT=NULL,
		@PostId INT=NULL,
		@Staff_ID NVARCHAR(50),
		@UserName NVARCHAR(50),
		@Arrive_date datetime,
		@ID_card_number NVARCHAR(50),
		@Post_medical_package_Id NVARCHAR(50),
		@corporation NVARCHAR(50),
		@Medical_type VARCHAR(50),
		@dimission_Medical VARCHAR(1),
		@Departure_medical_package NVARCHAR(50),
		@Departure_Date datetime,
		@Remark NVARCHAR(MAX),
		@OperateUser NVARCHAR(50),
		@OperateDate datetime,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO EHS_Employees_manage (departmentId,PostId,Staff_ID,UserName,Arrive_date,ID_card_number,Post_medical_package_Id,corporation,Medical_type,dimission_Medical,Departure_medical_package,Departure_Date,Remark,OperateUser,OperateDate) 
		VALUES (@departmentId,@PostId,@Staff_ID,@UserName,@Arrive_date,@ID_card_number,@Post_medical_package_Id,@corporation,@Medical_type,@dimission_Medical,@Departure_medical_package,@Departure_Date,@Remark,@OperateUser,@OperateDate) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE EHS_Employees_manage SET departmentId=@departmentId,PostId=@PostId,Staff_ID=@Staff_ID,UserName=@UserName,Arrive_date=@Arrive_date,ID_card_number=@ID_card_number,Post_medical_package_Id=@Post_medical_package_Id
			   ,corporation=@corporation,Medical_type=@Medical_type,Departure_medical_package=@Departure_medical_package,dimission_Medical=@dimission_Medical,Departure_Date=@Departure_Date,Remark=@Remark,
				OperateUser=@OperateUser,OperateDate=@OperateDate WHERE ID=@ID 	
	return @ID 
	END





























GO

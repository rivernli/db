USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Update_physical_examination_date]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[EHS_sp_Update_physical_examination_date] 	
		@Employees_Id INT=NULL,
		@department NVARCHAR(100),
		@Post NVARCHAR(100),
		@Staff_ID NVARCHAR(50),
		@UserName NVARCHAR(50),
		@Arrive_date datetime,
		@ID_card_number NVARCHAR(50),
		@Post_medical_package NVARCHAR(50),
		@Post_medical_package_Id NVARCHAR(50),
		@corporation NVARCHAR(50),
		@User_Sex varchar(10),
		@Date_of_birth datetime,
		@User_age varchar(50),
		@Working_years varchar(50),		
		@Medical_type varchar(50),
		@Departure_Date datetime
AS

	BEGIN
		UPDATE EHS_physical_examination_Total_table SET Staff_ID=@Staff_ID,UserName=@UserName, 
		Arrive_date=@Arrive_date, ID_card_number=@ID_card_number, corporation=@corporation, User_Sex=@User_Sex, Date_of_birth=@Date_of_birth,
		 User_age=@User_age, Working_years=@Working_years, Medical_type=@Medical_type, Departure_Date=@Departure_Date 
		where Employees_Id=@Employees_Id AND medical_state='0' AND department=@department AND Post=@Post AND Post_medical_package_Id=@Post_medical_package_Id
		
	END











GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Insert_physical_examination_Total_table]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [dbo].[EHS_sp_Insert_physical_examination_Total_table] 	
		@Employees_Id INT=NULL,
		@mLsh NVARCHAR(50),
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
		@Physical_No nvarchar(50),
		@Physical_Date datetime,
		@result nvarchar(500),
		@conclusion nvarchar(500),
		@Disposal_conclusion nvarchar(500),
		@Physical_money numeric=NULL,
		@medical_state INT=NULL,
		@Medical_type varchar(50),
		@Departure_Date datetime 
AS

	BEGIN
		INSERT INTO EHS_physical_examination_Total_table (Employees_Id,mLsh,department,Post,Staff_ID,UserName,Arrive_date,ID_card_number,Post_medical_package,Post_medical_package_Id,corporation,User_Sex,Date_of_birth,User_age,Working_years,Physical_No,Physical_Date,result,conclusion,Disposal_conclusion,Physical_money,medical_state,Medical_type,Departure_Date) 
		VALUES (@Employees_Id,@mLsh,@department,@Post,@Staff_ID,@UserName,@Arrive_date,@ID_card_number,@Post_medical_package,@Post_medical_package_Id,@corporation,@User_Sex,@Date_of_birth,@User_age,@Working_years,@Physical_No,@Physical_Date,@result,@conclusion,@Disposal_conclusion,@Physical_money,@medical_state,@Medical_type,@Departure_Date) 	
		
	END









GO

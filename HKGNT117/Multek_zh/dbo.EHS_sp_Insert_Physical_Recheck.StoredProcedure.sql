USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Insert_Physical_Recheck]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EHS_sp_Insert_Physical_Recheck] 	
		@Physical_No NVARCHAR(50),
		@Post_medical_package NVARCHAR(50),
		@RecheckRemark NVARCHAR(500), 
		@mLsh NVARCHAR(50)
AS

	BEGIN
		INSERT INTO EHS_physical_examination_Total_table (Employees_Id,mLsh,department,Post,Staff_ID,UserName,Arrive_date,ID_card_number,Post_medical_package,Post_medical_package_Id,corporation,User_Sex,Date_of_birth,User_age,Working_years,Physical_No,Physical_Date,result,conclusion,Disposal_conclusion,Physical_money,medical_state,Medical_type,RecheckRemark,LastPhysicalDate,Medical_institutions) 
		select Employees_Id,@mLsh,department,Post,Staff_ID,UserName,Arrive_date,ID_card_number,Post_medical_package,Post_medical_package_Id,corporation,User_Sex,Date_of_birth,User_age,Working_years,null,null,null,null,null,null,'0',Medical_type,@RecheckRemark,Physical_Date,Medical_institutions from EHS_physical_examination_Total_table b
		where medical_state='2' AND b.Physical_No=@Physical_No AND b.Post_medical_package=@Post_medical_package

		update EHS_physical_examination_Total_table set medical_state='-1' where medical_state='2' AND Physical_No=@Physical_No AND Post_medical_package=@Post_medical_package
	END 




GO

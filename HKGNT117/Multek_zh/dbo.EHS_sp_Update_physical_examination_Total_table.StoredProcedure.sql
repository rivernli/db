USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Update_physical_examination_Total_table]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[EHS_sp_Update_physical_examination_Total_table] 	
		@Staff_ID NVARCHAR(50),		
		@Physical_No nvarchar(50),
		@Physical_Date datetime,
		@adverse_factor NVARCHAR(50),
		@result nvarchar(500),
		@conclusion nvarchar(500),
		@Disposal_conclusion nvarchar(500),
		@Physical_money numeric=NULL,
		@medical_state INT=NULL,
		@ImportUser NVARCHAR(50),
		@ImportDate datetime
AS

	BEGIN
		IF @adverse_factor='ÔëÉù'
		BEGIN
			UPDATE EHS_physical_examination_Total_table SET Physical_No=@Physical_No, Physical_Date=@Physical_Date, result=@result, 
			conclusion=@conclusion, Disposal_conclusion=@Disposal_conclusion, Physical_money=@Physical_money, medical_state=@medical_state, 
			ImportUser=@ImportUser, ImportDate=@ImportDate  
			WHERE medical_state='0' AND Staff_ID=@Staff_ID AND (Post_medical_package_id='8' OR Post_medical_package_id='15') 
		END
		ELSE
		BEGIN
			UPDATE EHS_physical_examination_Total_table SET Physical_No=@Physical_No, Physical_Date=@Physical_Date, result=@result, 
			conclusion=@conclusion, Disposal_conclusion=@Disposal_conclusion, Physical_money=@Physical_money, medical_state=@medical_state, 
			ImportUser=@ImportUser, ImportDate=@ImportDate  
			WHERE medical_state='0' AND Staff_ID=@Staff_ID AND Post_medical_package=@adverse_factor 
		END
	END

 



GO

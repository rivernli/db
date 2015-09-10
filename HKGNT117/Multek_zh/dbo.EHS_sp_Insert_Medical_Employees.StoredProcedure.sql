USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Insert_Medical_Employees]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[EHS_sp_Insert_Medical_Employees]
AS
BEGIN	
			DECLARE @MedicalId NVARCHAR(MAX)

			DECLARE Employees_C CURSOR FOR
			select Post_medical_package_Id from EHS_Employees_manage 
			OPEN Employees_C
			FETCH NEXT FROM Employees_C INTO @MedicalId 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @MedicalId=@MedicalId 
					print(@MedicalId)
				
					FETCH NEXT FROM Employees_C INTO @MedicalId 
				END
			CLOSE Employees_C
			DEALLOCATE Employees_C		
END


GO

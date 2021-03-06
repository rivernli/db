USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_IQCInspection]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SQM_sp_IQCInspection] 	
	@ID INT=NULL,
	@PN NVARCHAR(50),
	@IQA_HSF bit,
	@IQA_HS bit,
	@IQA_OtherCk bit,
	@IQA_Other NVARCHAR(50),
	@IQA_CoA_requirement NVARCHAR(50),
	@IQA_Conclusion NVARCHAR(50),
	@IQA_Reject_Remark NVARCHAR(500),
	@IQA_Checked_Userid NVARCHAR(50),
	@IQA_Checked_by NVARCHAR(50),
	@IQA_Checked_Date NVARCHAR(20),
	@IQA_Approved_Userid NVARCHAR(50),
	@IQA_Approved_by NVARCHAR(50),
	@IQA_Approved_Date NVARCHAR(20),
	@Receiving_Date NVARCHAR(20)
AS

	BEGIN
		UPDATE SQM_IncomingMaterialCheck
		SET IQA_HSF=@IQA_HSF,IQA_HS=@IQA_HS,IQA_OtherCk=@IQA_OtherCk,IQA_Other=@IQA_Other,IQA_CoA_requirement=@IQA_CoA_requirement,IQA_Conclusion=@IQA_Conclusion,
			IQA_Reject_Remark=@IQA_Reject_Remark, IQA_Checked_Userid=@IQA_Checked_Userid,IQA_Checked_by=@IQA_Checked_by,IQA_Checked_Date=@IQA_Checked_Date,
			IQA_Approved_Userid=@IQA_Approved_Userid, IQA_Approved_by=@IQA_Approved_by,IQA_Approved_Date=@IQA_Approved_Date 
		WHERE ID=@ID 
	

IF @IQA_Conclusion='1' 
	BEGIN
		 --Check 
		IF NOT EXISTS(SELECT * FROM SQM_tblCheckPN WHERE PID=@ID)
			BEGIN				 
				INSERT INTO SQM_tblCheckPN (PN,PID,Start_date)
				VALUES(@PN,@ID,@Receiving_Date) 
			END
	END 

IF @IQA_Conclusion='2' 
	BEGIN
		DELETE FROM SQM_tblCheckPN WHERE PN=@PN  
	END 




END



GO

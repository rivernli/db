USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Auto_TimeOutEmail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SQM_sp_Auto_TimeOutEmail]
AS
BEGIN	
	SET NOCOUNT ON;

	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	--Send Mail	
		BEGIN
			--SQM 环节
			--设定任务完成期限为3个工作日，超时未完成，记录显示黄色，发送Email本人.
			--超过5个工作日，记录显示红色，发送Email本人及主管.
			DECLARE @Accepter NVARCHAR(MAX),@PN NVARCHAR(200),@mID NVARCHAR(200),@EmailId NVARCHAR(MAX),@ManagerEmail NVARCHAR(MAX),@Notice_No NVARCHAR(MAX),@Vendor NVARCHAR(MAX),@Material NVARCHAR(MAX),@state NVARCHAR(MAX),@TimeOut NVARCHAR(MAX),@Plant NVARCHAR(10)  

			DECLARE DefectMaterial_C CURSOR FOR
			select a.ID,a.Accepter,a.PN,b.Notice_No,b.Vendor,b.Material,a.State,SubString(a.EmailId,1,len(a.EmailId)-1) as EmailId ,dbo.SQM_fun__WorkDay(a.SendTime+isnull(TimeOutDays,0),GetDate()) as TimeOut,b.Plant from SQM_Inbox_Info a
			Inner Join SQM_NoticeOfDefectMaterial b ON TaskId=SendId 
			where (a.State='0' OR a.State='1') AND Del='0' AND send_state='3' AND (EmailId<>'' OR EmailId Is not null)

			OPEN DefectMaterial_C
			FETCH NEXT FROM DefectMaterial_C INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@state,@EmailId,@TimeOut,@Plant 
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @mID=@mID 
					SET @Accepter=@Accepter 
					SET @PN=@PN 
					SET @Notice_No=@Notice_No
					SET @Vendor=@Vendor 
					SET @Material=@Material
					SET @state=@state 
					SET @EmailId=@EmailId	
					SET @TimeOut=@TimeOut 
					SET @Plant=@Plant 
										
					IF @TimeOut>=7
						BEGIN
							IF @EmailId<>''
							BEGIN
									SET @To='' 			
									DECLARE ManagerEmail_C CURSOR FOR										
									SELECT distinct Manager_Email from SQM_Email_Settings_Info where Plant=@Plant AND charindex(convert(varchar(Max),ID),','+@EmailId+',')>0 									
									OPEN ManagerEmail_C
									FETCH NEXT FROM ManagerEmail_C INTO @ManagerEmail 
									WHILE @@FETCH_STATUS=0
										BEGIN
											SET @To=@To+@ManagerEmail+';'																																
											FETCH NEXT FROM ManagerEmail_C INTO @ManagerEmail 
										END
									CLOSE ManagerEmail_C
									DEALLOCATE ManagerEmail_C
								--Send
								EXEC [dbo].[SQM_sp_Send_TimeOutTask_Mail] '2', @mID, @Accepter, @PN,  @Notice_No, @Vendor, @Material, @To
							END
						END	
					 IF @state='0'
						BEGIN
							IF @TimeOut>=5
							BEGIN
								EXEC [dbo].[SQM_sp_Send_TimeOutTask_Mail] '1', @mID, @Accepter, @PN, @Notice_No, @Vendor, @Material, ''
							END
						END
					
					FETCH NEXT FROM DefectMaterial_C INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@state,@EmailId,@TimeOut,@Plant 
				END
			CLOSE DefectMaterial_C
			DEALLOCATE DefectMaterial_C			

			--PE,IQC 环节
			--设定任务完成期限为1个工作日，超时未完成，记录显示黄色，发送Email本人.
			--超过2个工作日，记录显示红色，发送Email本人及主管.
			DECLARE DefectMaterial_PE_IQC CURSOR FOR
			select a.ID,a.Accepter,a.PN,b.Notice_No,b.Vendor,b.Material,a.State,SubString(a.EmailId,1,len(a.EmailId)-1) as EmailId ,dbo.SQM_fun__WorkDay(a.SendTime+isnull(TimeOutDays,0),GetDate()) as TimeOut,b.Plant from SQM_Inbox_Info a
			Inner Join SQM_NoticeOfDefectMaterial b ON TaskId=SendId  
             where (a.State='0' OR a.State='1') AND Del='0' AND (send_state = '1' OR send_state='2') AND (EmailId<>'' OR EmailId Is not null)		

			OPEN DefectMaterial_PE_IQC
			FETCH NEXT FROM DefectMaterial_PE_IQC INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@state,@EmailId,@TimeOut,@Plant  
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @mID=@mID 
					SET @Accepter=@Accepter 
					SET @PN=@PN 
					SET @Notice_No=@Notice_No
					SET @Vendor=@Vendor 
					SET @Material=@Material
					SET @state=@state 
					SET @EmailId=@EmailId	
					SET @TimeOut=@TimeOut 
					SET @Plant=@Plant 
										
					IF @TimeOut>=4
						BEGIN
							IF @EmailId<>''
							BEGIN
									SET @To='' 			
									DECLARE ManagerEmail_PE_IQC CURSOR FOR										
									SELECT distinct Manager_Email from SQM_Email_Settings_Info where Plant=@Plant AND Manager_Email<>'' AND charindex(convert(varchar(Max),ID),','+@EmailId+',')>0 								
									OPEN ManagerEmail_PE_IQC
									FETCH NEXT FROM ManagerEmail_PE_IQC INTO @ManagerEmail 
									WHILE @@FETCH_STATUS=0
										BEGIN
											SET @To=@To+@ManagerEmail+';'																																
											FETCH NEXT FROM ManagerEmail_PE_IQC INTO @ManagerEmail 
										END
									CLOSE ManagerEmail_PE_IQC
									DEALLOCATE ManagerEmail_PE_IQC
								--Send
								EXEC [dbo].[SQM_sp_Send_TimeOutTask_Mail] '2', @mID, @Accepter, @PN,  @Notice_No, @Vendor, @Material, @To
							END
						END	
					 IF @state='0'
						BEGIN
							IF @TimeOut>=3
							BEGIN
								 EXEC [dbo].[SQM_sp_Send_TimeOutTask_Mail] '1', @mID, @Accepter, @PN, @Notice_No, @Vendor, @Material, ''
							END
						END
					
					FETCH NEXT FROM DefectMaterial_PE_IQC INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@state,@EmailId,@TimeOut,@Plant  
				END
			CLOSE DefectMaterial_PE_IQC
			DEALLOCATE DefectMaterial_PE_IQC	

		--PE环节超时10日后系统自动发出提醒邮件通知及时处理，如在1天内没有处理，系统将自动职消该单
			DECLARE DefectMaterial_PE CURSOR FOR			
			select distinct a.ID,a.Accepter,a.PN,b.Notice_No,b.Vendor,b.Material,a.EmailId,b.Plant from SQM_Inbox_Info a
			Inner Join SQM_NoticeOfDefectMaterial b ON TaskId=SendId 
			where a.State='2' AND Del='0' AND send_state='1' 
			AND convert(varchar(10),DATEADD(day,10,a.SendTime),120) <= convert(varchar(10),getdate(),120)
			AND (EmailId<>'' OR EmailId Is not null)

			OPEN DefectMaterial_PE
			FETCH NEXT FROM DefectMaterial_PE INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@EmailId,@Plant  
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @mID=@mID 
					SET @Accepter=@Accepter 
					SET @PN=@PN 
					SET @Notice_No=@Notice_No
					SET @Vendor=@Vendor 
					SET @Material=@Material
					SET @EmailId=@EmailId 
					SET @Plant=@Plant  
					
					--Send
					EXEC [dbo].[SQM_sp_Send_TimeOutTask_Mail] '4', @mID, @Accepter, @PN,  @Notice_No, @Vendor, @Material, @To
					
					FETCH NEXT FROM DefectMaterial_PE INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@EmailId,@Plant  
				END
			CLOSE DefectMaterial_PE
			DEALLOCATE DefectMaterial_PE

		 --PE环节超时,系统自动职消该单
			DECLARE DefectMaterial_PE_Cancel CURSOR FOR			
			select distinct a.ID,a.Accepter,a.PN,b.Notice_No,b.Vendor,b.Material,a.EmailId,dbo.SQM_fun__WorkDay(TimeOutDate,GetDate()) as TimeOut,b.Plant from SQM_Inbox_Info a
			Inner Join SQM_NoticeOfDefectMaterial b ON TaskId=SendId 
			where a.State='4' AND Del='0' AND send_state='1' AND (EmailId<>'' OR EmailId Is not null)

			OPEN DefectMaterial_PE_Cancel
			FETCH NEXT FROM DefectMaterial_PE_Cancel INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@EmailId,@TimeOut,@Plant  
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @mID=@mID 
					SET @Accepter=@Accepter 
					SET @PN=@PN 
					SET @Notice_No=@Notice_No
					SET @Vendor=@Vendor 
					SET @Material=@Material
					SET @EmailId=@EmailId 
					SET @TimeOut=@TimeOut 
					SET @Plant=@Plant  

					IF @TimeOut>=2
					BEGIN
						--Send
						EXEC [dbo].[SQM_sp_Send_TimeOutTask_Mail] '5', @mID, @Accepter, @PN,  @Notice_No, @Vendor, @Material, @To
					END

					FETCH NEXT FROM DefectMaterial_PE_Cancel INTO @mID,@Accepter,@PN,@Notice_No,@Vendor,@Material,@EmailId,@TimeOut,@Plant 
				END
			CLOSE DefectMaterial_PE_Cancel
			DEALLOCATE DefectMaterial_PE_Cancel	

		END	
END









GO

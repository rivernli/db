USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_STS_Send_Mail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SQM_sp_STS_Send_Mail] 
	--Add the parameters for the stored procedure here
	@Option VARCHAR(50),
	@SendId NVARCHAR(50),
	@SendTitle NVARCHAR(200),
	@SendUrl NVARCHAR(200),
	@Sender NVARCHAR(50),
	@Remark NVARCHAR(MAX),
	@SenderName NVARCHAR(50),
	@SenderTel NVARCHAR(50),
	@SenderEmail NVARCHAR(100),
	@ReturnPeople NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here 
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)
	DECLARE @PN NVARCHAR(50),@Vendor NVARCHAR(50),@Material NVARCHAR(50),@Plant NVARCHAR(50),@Vendor_PN NVARCHAR(50),@Core_thickness NVARCHAR(50) 
    DECLARE @Construction NVARCHAR(50),@Copper_thickness NVARCHAR(50),@Conclusion NVARCHAR(50),@UAI_REJ NVARCHAR(300),@ReportNo NVARCHAR(50)
	DECLARE @Type_Diameter NVARCHAR(50),@Rc_Ply_Up NVARCHAR(50),@IQA_Conclusion NVARCHAR(50),@IQA_Reject_Remark NVARCHAR(500) 

    SET @PN=''
    IF @SendUrl Like '%B2F%'
	BEGIN
		DECLARE STS CURSOR FOR
		select PN,Vendor,Material,Plant,Vendor_PN,Core_thickness,Construction,Copper_thickness,
		(case Conclusion when '1' then 'Accept' when '2' then 'Nonconforming' end) as Conclusion_tag,
		(case IQA_Conclusion when '1' then 'Accept' when '2' then 'Reject' else 'Accept' end) as IQA_Conclusion,
		isnull((case UAI_REJ when '1' then 'UAI'+'   '+UAIOther when '2' then 'REJ'+'   '+REJOther end),'') as UAI_REJ_tag,Type_Diameter,Rc_Ply_Up,F_N,IQA_Reject_Remark from SQM_IncomingMaterialCheck_B2F where TaskId=@SendId
		OPEN STS
		FETCH NEXT FROM STS INTO @PN,@Vendor,@Material,@Plant,@Vendor_PN,@Core_thickness,@Construction,@Copper_thickness,@Conclusion,@IQA_Conclusion,@UAI_REJ,@Type_Diameter,@Rc_Ply_Up,@ReportNo,@IQA_Reject_Remark 
		WHILE @@FETCH_STATUS=0 
			BEGIN 
				SET @PN=@PN
				SET @Vendor=@Vendor 
				SET @Material=@Material 
				SET @Plant=@Plant 
				SET @Vendor_PN=@Vendor_PN 
				SET @Core_thickness=@Core_thickness 
				SET @Construction=@Construction 
				SET @Copper_thickness=@Copper_thickness 
				SET @Conclusion=@Conclusion 
				SET @IQA_Conclusion=@IQA_Conclusion 
				SET @UAI_REJ=@UAI_REJ 
				SET @Type_Diameter=@Type_Diameter 
				SET @Rc_Ply_Up=@Rc_Ply_Up 
				SET @ReportNo=@ReportNo 
				SET @IQA_Reject_Remark=@IQA_Reject_Remark
				FETCH NEXT FROM STS INTO @PN,@Vendor,@Material,@Plant,@Vendor_PN,@Core_thickness,@Construction,@Copper_thickness,@Conclusion,@IQA_Conclusion,@UAI_REJ,@Type_Diameter,@Rc_Ply_Up,@ReportNo,@IQA_Reject_Remark 
			END
		CLOSE STS 
		DEALLOCATE STS 
	
	END
	ELSE
    BEGIN
		DECLARE STS CURSOR FOR
		select PN,Vendor,Material,Plant,Vendor_PN,Core_thickness,Construction,Copper_thickness,
		(case Conclusion when '1' then 'Accept' when '2' then 'Nonconforming' end) as Conclusion_tag,
		(case IQA_Conclusion when '1' then 'Accept' when '2' then 'Reject' else 'Accept' end) as IQA_Conclusion,
		isnull((case UAI_REJ when '1' then 'UAI'+'   '+UAIOther when '2' then 'REJ'+'   '+REJOther end),'') as UAI_REJ_tag,Type_Diameter,Rc_Ply_Up,F_N,IQA_Reject_Remark from SQM_IncomingMaterialCheck where TaskId=@SendId
		OPEN STS
		FETCH NEXT FROM STS INTO @PN,@Vendor,@Material,@Plant,@Vendor_PN,@Core_thickness,@Construction,@Copper_thickness,@Conclusion,@IQA_Conclusion,@UAI_REJ,@Type_Diameter,@Rc_Ply_Up,@ReportNo,@IQA_Reject_Remark 
		WHILE @@FETCH_STATUS=0 
			BEGIN 
				SET @PN=@PN
				SET @Vendor=@Vendor 
				SET @Material=@Material 
				SET @Plant=@Plant 
				SET @Vendor_PN=@Vendor_PN 
				SET @Core_thickness=@Core_thickness 
				SET @Construction=@Construction 
				SET @Copper_thickness=@Copper_thickness 
				SET @Conclusion=@Conclusion 
				SET @IQA_Conclusion=@IQA_Conclusion 
				SET @UAI_REJ=@UAI_REJ 
				SET @Type_Diameter=@Type_Diameter 
				SET @Rc_Ply_Up=@Rc_Ply_Up 
				SET @ReportNo=@ReportNo 
				SET @IQA_Reject_Remark=@IQA_Reject_Remark
				FETCH NEXT FROM STS INTO @PN,@Vendor,@Material,@Plant,@Vendor_PN,@Core_thickness,@Construction,@Copper_thickness,@Conclusion,@IQA_Conclusion,@UAI_REJ,@Type_Diameter,@Rc_Ply_Up,@ReportNo,@IQA_Reject_Remark 
			END
		CLOSE STS 
		DEALLOCATE STS 
	END

	--Send Mail
	IF @Option='PPCSendSupervisor'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460002' AND Plant=@Plant  
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					FETCH NEXT FROM User_C INTO @Email
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Incoming Material Check Form task - PPC Supervisor Step: <br>' 
			
			SET @Body=@Body+'<table width="98%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor P/N</td>' 
			IF @Material='Laminate'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>' 
			END 
			IF @Material='PP'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>' 
			END 
			IF @Material='RCC'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>' 
			END 
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>' 
			END
			SET @Body=@Body+'	<td widht="20%" align="center">Conclusion</td>' 			
			SET @Body=@Body+'	<td widht="20%" align="center">Comment on Nonconforming Material</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Vendor_PN+'</td>'
			IF @Material='Laminate'	
			BEGIN 			
			SET @Body=@Body+'	<td>'+@Core_thickness+'</td>'
			SET @Body=@Body+'	<td>'+@Construction+'</td>'
			SET @Body=@Body+'	<td>'+@Copper_thickness+'</td>'
			END	
			IF @Material='PP'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END		
			IF @Material='RCC'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END	
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'			
			END
			SET @Body=@Body+'	<td>'+@Conclusion+'</td>' 
			SET @Body=@Body+'	<td>'+@UAI_REJ+'</td>' 
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Incoming Material Check Form task - PPC Supervisor Step'
		END

		IF @Option='SendIQC'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460003' AND Plant=@Plant  
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					FETCH NEXT FROM User_C INTO @Email
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc='' 
			SET @Body='' 
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Incoming Material Check Form task - IQC Step: <br>' 
			
			SET @Body=@Body+'<table width="98%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor P/N</td>' 
			IF @Material='Laminate'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>' 
			END 
			IF @Material='PP'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>' 
			END 
			IF @Material='RCC'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>' 
			END 
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>' 
			END
			SET @Body=@Body+'	<td widht="20%" align="center">Conclusion</td>' 			
			SET @Body=@Body+'	<td widht="20%" align="center">Comment on Nonconforming Material</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Vendor_PN+'</td>'
			IF @Material='Laminate'	
			BEGIN 			
			SET @Body=@Body+'	<td>'+@Core_thickness+'</td>'
			SET @Body=@Body+'	<td>'+@Construction+'</td>'
			SET @Body=@Body+'	<td>'+@Copper_thickness+'</td>'
			END	
			IF @Material='PP'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END		
			IF @Material='RCC'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END	
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'			
			END
			SET @Body=@Body+'	<td>'+@Conclusion+'</td>' 
			SET @Body=@Body+'	<td>'+@UAI_REJ+'</td>' 
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Incoming Material Check Form task - IQC Step'
		END

		IF @Option='IQCSendSupervisor'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460004'  AND Plant=@Plant 
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					FETCH NEXT FROM User_C INTO @Email
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Incoming Material Check Form task - IQC Supervisor Step: <br>' 
			
			SET @Body=@Body+'<table width="98%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor P/N</td>' 
			IF @Material='Laminate'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>' 
			END 
			IF @Material='PP'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>' 
			END 
			IF @Material='RCC'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>' 
			END 
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>' 
			END
			SET @Body=@Body+'	<td widht="20%" align="center">Conclusion</td>' 			
			SET @Body=@Body+'	<td widht="20%" align="center">Comment on Nonconforming Material</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Vendor_PN+'</td>'
			IF @Material='Laminate'	
			BEGIN 			
			SET @Body=@Body+'	<td>'+@Core_thickness+'</td>'
			SET @Body=@Body+'	<td>'+@Construction+'</td>'
			SET @Body=@Body+'	<td>'+@Copper_thickness+'</td>'
			END	
			IF @Material='PP'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END		
			IF @Material='RCC'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END	
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'			
			END
			SET @Body=@Body+'	<td>'+@IQA_Conclusion+'</td>' 
			SET @Body=@Body+'	<td>'+@UAI_REJ+'</td>' 
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Incoming Material Check Form task - IQC Supervisor Step'
		END

	--choose [Reject] Send SQM
	IF @Option='SendSQM' 
		BEGIN
			SET @To=''
			IF @Plant ='B2F'
			BEGIN
				DECLARE User_C CURSOR FOR
				select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
	 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460017'  AND Plant=@Plant 
				OPEN User_C
				FETCH NEXT FROM User_C INTO @Email
				WHILE @@FETCH_STATUS=0
					BEGIN
						SET @To=@To+@Email+';'
						FETCH NEXT FROM User_C INTO @Email
					END
				CLOSE User_C
				DEALLOCATE User_C
			END
			ELSE
			BEGIN
				DECLARE User_C CURSOR FOR
				select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
	 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where PLsh='201106071024460017' 
				OPEN User_C
				FETCH NEXT FROM User_C INTO @Email
				WHILE @@FETCH_STATUS=0
					BEGIN
						SET @To=@To+@Email+';'
						FETCH NEXT FROM User_C INTO @Email
					END
				CLOSE User_C
				DEALLOCATE User_C
			END

			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Incoming Material Check Form task - SQM Step: <br>' 
			
			SET @Body=@Body+'<table width="98%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor P/N</td>' 
			IF @Material='Laminate'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>' 
			END 
			IF @Material='PP'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>' 
			END 
			IF @Material='RCC'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>' 
			END 
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>' 
			END
			SET @Body=@Body+'	<td widht="20%" align="center">Conclusion</td>' 			
			SET @Body=@Body+'	<td widht="20%" align="center">Comment on Nonconforming Material</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Vendor_PN+'</td>'
			IF @Material='Laminate'	
			BEGIN 			
			SET @Body=@Body+'	<td>'+@Core_thickness+'</td>'
			SET @Body=@Body+'	<td>'+@Construction+'</td>'
			SET @Body=@Body+'	<td>'+@Copper_thickness+'</td>'
			END	
			IF @Material='PP'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END		
			IF @Material='RCC'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END	
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'			
			END
			SET @Body=@Body+'	<td>'+@IQA_Conclusion+'</td>' 
			SET @Body=@Body+'	<td>'+@UAI_REJ+@IQA_Reject_Remark+'</td>' 
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Incoming Material Check Form task - SQM Step'
		END

		IF @Option='SendIQA'  --这里是Send给IQC 
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where (PLsh='201106071024460003' or PLsh='201106071024460004') AND Plant=@Plant  
			OPEN User_C
			FETCH NEXT FROM User_C INTO @Email
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @To=@To+@Email+';'
					FETCH NEXT FROM User_C INTO @Email
				END
			CLOSE User_C
			DEALLOCATE User_C

			SET @Cc=''
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Incoming Material Check Form task - IQA Print Step: <br>' 
			
			SET @Body=@Body+'<table width="98%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor P/N</td>' 
			IF @Material='Laminate'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>' 
			END 
			IF @Material='PP'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>' 
			END 
			IF @Material='RCC'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>' 
			END 
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>' 
			END
			SET @Body=@Body+'	<td widht="20%" align="center">Conclusion</td>' 			
			SET @Body=@Body+'	<td widht="20%" align="center">Comment on Nonconforming Material</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Vendor_PN+'</td>'
			IF @Material='Laminate'	
			BEGIN 			
			SET @Body=@Body+'	<td>'+@Core_thickness+'</td>'
			SET @Body=@Body+'	<td>'+@Construction+'</td>'
			SET @Body=@Body+'	<td>'+@Copper_thickness+'</td>'
			END	
			IF @Material='PP'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END		
			IF @Material='RCC'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END	
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'			
			END
			SET @Body=@Body+'	<td>'+@IQA_Conclusion+'</td>' 
			SET @Body=@Body+'	<td>'+@UAI_REJ+'</td>' 
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Link to print: <br>' 
			SET @Body=@Body+'<a href='+@SendUrl+'>http://hkgnt117/SQM/Form/STS/PrintPage.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Incoming Material Check Form task - IQA Print Step'
		END

	--Return To PPC
	IF @Option='ReturnPPC'
		BEGIN
			SET @To=@ReturnPeople 
--			DECLARE User_C CURSOR FOR
--			select (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
-- ELSE Email end) as Email from SQM_System_Users left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_System_Users.UserID where BDM=(SELECT TOP 1 Checked_by from SQM_IncomingMaterialCheck where TaskId=@SendId)
--			OPEN User_C
--			FETCH NEXT FROM User_C INTO @Email
--			WHILE @@FETCH_STATUS=0
--				BEGIN
--					SET @To=@To+@Email+';'
--					FETCH NEXT FROM User_C INTO @Email
--				END
--			CLOSE User_C
--			DEALLOCATE User_C

			SET @Cc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear Team,<br><br>'
			SET @Body=@Body+'You have a Incoming Material Check Form task - Returned to task<br>' 
			
			SET @Body=@Body+'<table width="98%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 
			SET @Body=@Body+'<tr>'	
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Material</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Plant</td>'		
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor P/N</td>' 
			IF @Material='Laminate'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'	
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>' 
			END 
			IF @Material='PP'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>' 
			END 
			IF @Material='RCC'	
			BEGIN 
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>' 
			END 
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>' 
			END
			SET @Body=@Body+'	<td widht="20%" align="center">Comment on Nonconforming Material</td>' 
			SET @Body=@Body+'	<td widht="20%" align="center">Report No.</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td>'+@PN+'</td>'
			SET @Body=@Body+'	<td>'+@Vendor+'</td>'
			SET @Body=@Body+'	<td>'+@Material+'</td>'
			SET @Body=@Body+'	<td>'+@Plant+'</td>'	
			SET @Body=@Body+'	<td>'+@Vendor_PN+'</td>'
			IF @Material='Laminate'	
			BEGIN 			
			SET @Body=@Body+'	<td>'+@Core_thickness+'</td>'
			SET @Body=@Body+'	<td>'+@Construction+'</td>'
			SET @Body=@Body+'	<td>'+@Copper_thickness+'</td>'
			END	
			IF @Material='PP'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END		
			IF @Material='RCC'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'
			SET @Body=@Body+'	<td>'+@Rc_Ply_Up+'</td>'
			END	
			IF @Material='Tools'
			BEGIN
			SET @Body=@Body+'	<td>'+@Type_Diameter+'</td>'			
			END
			SET @Body=@Body+'	<td>'+@UAI_REJ+'</td>' 
			SET @Body=@Body+'	<td>'+@ReportNo+'</td>' 
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+ @Remark +'<br><br><br>'
			SET @Body=@Body+'Please click on the link below to access SQM system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/SQM/Login.aspx>http://hkgnt117/SQM/Login.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'			
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='You have a Incoming Material Check Form task - Returned to task'
		END	

	EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body
	
	--Insert to Inbox_Info
	IF @Option<>'SendIQA' 	
	BEGIN
	 INSERT INTO SQM_Inbox_Info (SendId, SendTitle, Reportno, PN, SendUrl, Sender, Accepter,Remark,Material)VALUES(@SendId, @SendTitle, @ReportNo, @PN, @SendUrl, @Sender, @TO, @Remark, @Material)
	END
END 












GO

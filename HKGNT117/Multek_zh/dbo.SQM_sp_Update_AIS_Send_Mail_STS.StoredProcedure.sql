USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Update_AIS_Send_Mail_STS]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SQM_sp_Update_AIS_Send_Mail_STS] 
	-- Add the parameters for the stored procedure here
	@Plant NVARCHAR(50),
	@where1 NVARCHAR(50),	
	@where2 NVARCHAR(50),
	@where3 NVARCHAR(50),
	@where4 NVARCHAR(50),
	@where5 NVARCHAR(50),
	@where6 NVARCHAR(50),
	@where7 NVARCHAR(50),
	@where8 NVARCHAR(50),
	@StartDate NVARCHAR(25),
	@ReceivingDate NVARCHAR(25),
	@Qty NVARCHAR(50),
	@Option VARCHAR(50),
	@SenderName NVARCHAR(50),
	@SenderTel NVARCHAR(50),
	@SenderEmail NVARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @item NVARCHAR(100)
    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	--Send Mail
	IF @Option='Laminate'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where (PLsh='201106071024460005' OR PLsh='201403030920131942')  -- Send IE AND SQM
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
			SET @Body=@Body+'Below materials from '+@StartDate+' to '+@ReceivingDate+', batch quantity: '+@Qty+' no quality issue and meet the STS qualification.<br>' 
			SET @Body=@Body+'Please Update AIS Information. <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Location</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor PN</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Core thickness</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Construction</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Copper thickness</td>'
			SET @Body=@Body+'</tr>'			
			
			DECLARE M_Laminate CURSOR FOR
			select item FROM  MCNNT801.MULTEK_BI.dbo.tAttr_laminate where vdor=@where1 AND loca=@where2 AND vdpn=@where3 AND dctk=@where4 AND cons=@where5 AND cutk=@where6 AND  substring(item,0,5)<>'temp' AND csig<>'OBS' AND stsa='N' 
			AND item not in 
				(
					select PN from SQM_IncomingMaterialCheck where IQA_Approved_Date between @StartDate and @ReceivingDate 
					AND IQA_Conclusion='2' AND Vendor=@where1 AND Location=@where2 AND Vendor_PN=@where3 AND Core_thickness=@where4 AND Construction=@where5 AND Copper_thickness=@where6 
				)
			OPEN M_Laminate
			FETCH NEXT FROM M_Laminate INTO @item
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @Body=@Body+'<tr>'			
					SET @Body=@Body+'	<td>'+@item+'</td>'
					SET @Body=@Body+'	<td>'+@where1+'</td>'
					SET @Body=@Body+'	<td>'+@where2+'</td>'
					SET @Body=@Body+'	<td>'+@where3+'</td>'
					SET @Body=@Body+'	<td>'+@where4+'</td>'
					SET @Body=@Body+'	<td>'+@where5+'</td>'
					SET @Body=@Body+'	<td>'+@where6+'</td>'
					SET @Body=@Body+'</tr>'
					FETCH NEXT FROM M_Laminate INTO @item
				END
			CLOSE M_Laminate
			DEALLOCATE M_Laminate
			

			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access AIS system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/AIS/laminate.aspx>http://hkgnt117/AIS/laminate.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='STS Materials Qualification for '+@Option+', Please Update AIS Information.'
		END

	IF @Option='Prepreg'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where (PLsh='201106071024460005' OR PLsh='201403030920131942')  -- Send IE AND SQM
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
			SET @Body=@Body+'Below materials from '+@StartDate+' to '+@ReceivingDate+', batch quantity: '+@Qty+' no quality issue and meet the STS qualification.<br>' 
			SET @Body=@Body+'Please Update AIS Information. <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Location</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor PN</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Type</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">RC</td>'
			SET @Body=@Body+'</tr>'
			
			DECLARE M_PP CURSOR FOR
			select item FROM  MCNNT801.MULTEK_BI.dbo.tAttr_prepreg where vdor=@where1 AND loca=@where2 AND vdpn=@where3 AND atyp=@where4 AND rcpc=@where5 AND  substring(item,0,5)<>'temp' AND csig<>'OBS' AND stsa='N' 
			AND item not in 
				(
					select PN from SQM_IncomingMaterialCheck where IQA_Approved_Date between @StartDate and @ReceivingDate 
					AND IQA_Conclusion='2' AND Vendor=@where1 AND Location=@where2 AND Vendor_PN=@where3 AND Type_Diameter=@where4 AND Rc_Ply_Up=@where5  
				)
			OPEN M_PP
			FETCH NEXT FROM M_PP INTO @item
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @Body=@Body+'<tr>'			
					SET @Body=@Body+'	<td>'+@item+'</td>'
					SET @Body=@Body+'	<td>'+@where1+'</td>'
					SET @Body=@Body+'	<td>'+@where2+'</td>'
					SET @Body=@Body+'	<td>'+@where3+'</td>'
					SET @Body=@Body+'	<td>'+@where4+'</td>'
					SET @Body=@Body+'	<td>'+@where5+'</td>'
					SET @Body=@Body+'</tr>'
					FETCH NEXT FROM M_PP INTO @item
				END
			CLOSE M_PP
			DEALLOCATE M_PP
			

			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access AIS system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/AIS/Prepreg.aspx>http://hkgnt117/AIS/Prepreg.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='STS Materials Qualification for '+@Option+', Please Update AIS Information.'
		END
	IF @Option='RCC'		
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where (PLsh='201106071024460005' OR PLsh='201403030920131942')
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
			SET @Body=@Body+'Below materials from '+@StartDate+' to '+@ReceivingDate+', batch quantity: '+@Qty+' no quality issue and meet the STS qualification.<br>' 
			SET @Body=@Body+'Please Update AIS Information. <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Location</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor PN</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Ply-Up</td>'
			SET @Body=@Body+'</tr>'
			
			DECLARE M_RCC CURSOR FOR
			select item FROM  MCNNT801.MULTEK_BI.dbo.tAttr_rcc where vdor=@where1 AND loca=@where2 AND vdpn=@where3 AND Plyu=@where4 AND  substring(item,0,5)<>'temp' AND csig<>'OBS' AND stsa='N' 
			AND item not in 
					(
						select PN from SQM_IncomingMaterialCheck where IQA_Approved_Date between @StartDate and @ReceivingDate 
						AND IQA_Conclusion='2' AND Vendor=@where1 AND Location=@where2 AND Vendor_PN=@where3 AND Rc_Ply_Up=@where4 
					)
			OPEN M_RCC
			FETCH NEXT FROM M_RCC INTO @item
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @Body=@Body+'<tr>'			
					SET @Body=@Body+'	<td>'+@item+'</td>'
					SET @Body=@Body+'	<td>'+@where1+'</td>'
					SET @Body=@Body+'	<td>'+@where2+'</td>'
					SET @Body=@Body+'	<td>'+@where3+'</td>'
					SET @Body=@Body+'	<td>'+@where4+'</td>'			
					SET @Body=@Body+'</tr>'
					FETCH NEXT FROM M_RCC INTO @item
				END
			CLOSE M_RCC
			DEALLOCATE M_RCC		

			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access AIS system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/AIS/RCC.aspx>http://hkgnt117/AIS/RCC.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='STS Materials Qualification for '+@Option+', Please Update AIS Information.'
		END

	IF @Option='Tools' 
		BEGIN
			SET @To=''
			DECLARE User_C CURSOR FOR
			select distinct (case when (AssignEmail is not null OR AssignEmail <>'') AND convert(varchar(10),convert(datetime,AssignUntilDate),120)>=convert(varchar(10),GetDate(),120) then AssignEmail 
 ELSE Email end) as Email from SQM_Email_Settings_Info left join SQM_Assign_Task ON SQM_Assign_Task.UserID=SQM_Email_Settings_Info.UserID where (PLsh='201106071024460005' OR PLsh='201403030920131942')    -- Send IE AND SQM
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
			SET @Body=@Body+'Below materials from '+@StartDate+' to '+@ReceivingDate+', batch quantity: '+@Qty+' no quality issue and meet the STS qualification.<br>' 
			SET @Body=@Body+'Please Update AIS Information. <br>' 
			
			SET @Body=@Body+'<table width="90%" style="border-collapse: collapse;" border="1" bordercolor="#000000" align="center">' 			
			SET @Body=@Body+'<tr>'			
			SET @Body=@Body+'	<td widht="20%" align="center">P/N</td>'			
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Location</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Vendor PN</td>'
			SET @Body=@Body+'	<td widht="20%" align="center">Diameter</td>'
			SET @Body=@Body+'</tr>'
			
			DECLARE M_RCC CURSOR FOR
			select item FROM  MCNNT801.MULTEK_BI.dbo.tAttr_tools where vdor=@where1 AND loca=@where2 AND vdpn=@where3 AND ddia+diun=@where4 AND  substring(item,0,5)<>'temp' AND csig<>'OBS' AND stsa='N' 
			AND item not in 
					(
						select PN from SQM_IncomingMaterialCheck where IQA_Approved_Date between @StartDate and @ReceivingDate 
						AND IQA_Conclusion='2' AND Vendor=@where1 AND Location=@where2 AND Vendor_PN=@where3 AND Type_Diameter=@where4 
					) 
			OPEN M_RCC
			FETCH NEXT FROM M_RCC INTO @item
			WHILE @@FETCH_STATUS=0
				BEGIN
					SET @Body=@Body+'<tr>'			
					SET @Body=@Body+'	<td>'+@item+'</td>'
					SET @Body=@Body+'	<td>'+@where1+'</td>'
					SET @Body=@Body+'	<td>'+@where2+'</td>'
					SET @Body=@Body+'	<td>'+@where3+'</td>'
					SET @Body=@Body+'	<td>'+@where4+'</td>'				
					SET @Body=@Body+'</tr>'
					FETCH NEXT FROM M_RCC INTO @item
				END
			CLOSE M_RCC
			DEALLOCATE M_RCC		

			SET @Body=@Body+'</table><br>'
			SET @Body=@Body+'Please click on the link below to access AIS system: <br>' 
			SET @Body=@Body+'<a href=http://hkgnt117/AIS/Tools.aspx>http://hkgnt117/AIS/Tools.aspx</a>'
			SET @Body=@Body+'<br><br><br><br>'
			SET @Body=@Body+'<font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Best Regards!</span></font>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">Multek / '+@SenderName+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">TEL: '+@SenderTel+'</span></font></td>'
			SET @Body=@Body+'<br><font color="#6262ff" size="3"><span lang=EN-US style="color:#6262FF;font-style:italic">E-Mail: '+@SenderEmail+'</span></font></td>'
			SET @Body=@Body+'<br><br>'
			SET @Body=@Body+'</body></html>'

			SET @Subject='STS Materials Qualification for '+@Option+', Please Update AIS Information.'
		END
	if @item<>''
	EXECUTE SQM_sp_Send_Mail @TO=@To,@Cc=@Cc,@Subject=@Subject,@Body=@Body
	
END




GO

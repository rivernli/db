USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[CCN_SP_DueAlert]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[CCN_SP_DueAlert] 
AS
BEGIN

	SET NOCOUNT ON;
	
		DECLARE @CCNNo VARCHAR(50),@Plant VARCHAR(10),@CCNReceived VARCHAR(10),@HandlingQA VARCHAR(50)
		DECLARE @HandlingEngineering VARCHAR(50),@CEM NVARCHAR(100),@OEM NVARCHAR(100)
		DECLARE @CustomerPN VARCHAR(50),@MultekPN VARCHAR(50),@DateCode VARCHAR(50)
		DECLARE @DetailedType VARCHAR(50),@AffectedPCBQty VARCHAR(50),@AffectedPCBAQty VARCHAR(50)
		DECLARE @DefectDesc NVARCHAR(4000),@DefectiveRate VARCHAR(50),@PotentialUP VARCHAR(50)
		DECLARE @TotalClaim VARCHAR(50),@Creator VARCHAR(50)
		DECLARE @To VARCHAR(1000),@CCList VARCHAR(1000),@Subject NVARCHAR(500),@Body NVARCHAR(MAX)
		DECLARE @EDDate DATETIME,@TCDate DATETIME
		
		DECLARE mid_cursor CURSOR FOR 
			SELECT CCNNo,Plant,HandlingQA,HandlingEngineering,Creator 
				FROM CCN_Table WHERE DATEDIFF(day,MidAlert,getdate()) = 0 AND APPClose = 0

		OPEN mid_cursor
		FETCH NEXT FROM mid_cursor INTO @CCNNo,@Plant,@HandlingQA,@HandlingEngineering,@Creator
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @To=''
				SELECT @To=@To+ISNULL(EmailAddress,'')+';' FROM CCN_User 
					WHERE (((IsQAM = 1 OR IsPEM = 1) AND CHARINDEX(@Plant,Plant)>0)) OR LoginName=@Creator
					ORDER BY IsQAM DESC, IsPEM DESC
				
				IF ISNULL(@To,'') <> ''	
					BEGIN
						SET @Subject='You have an open CCN('+@CCNNo+') past 10 working days'
						SET @Body='<font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Dear Team,<br><br>You have a CCN which past 10 working days and still in open status in CCN system, please finish your working task within the deadline and close it in CCN system otherwise the system will escalate the past due CCN to Plant GM, QA/Engineering Director. Thanks!  </font><br><br><font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Please click on the link below to access CCN system for details: <br /><a href="http://hkgnt117/CCN/Notification.aspx?Num='+@CCNNo+'" target="_blank">http://hkgnt117/CCN</a></font><br><br><font style="FONT-SIZE: 11pt; COLOR: red;">This is an automatically e-mail, please do not reply it! </font>'
						EXEC [CCN_SP_Send_Mail] @To=@To,@Body=@Body,@Subject=@Subject
					END
				
				FETCH NEXT FROM mid_cursor INTO @CCNNo,@Plant,@HandlingQA,@HandlingEngineering,@Creator
			END
		
		CLOSE mid_cursor
		DEALLOCATE mid_cursor
		
		DECLARE last_cursor CURSOR FOR 
			SELECT CCNNo,Plant,HandlingQA,HandlingEngineering,Creator 
				FROM CCN_Table
				WHERE DATEDIFF(day,LastAlert,getdate()) = 0 AND APPClose = 0

		OPEN last_cursor
		FETCH NEXT FROM last_cursor INTO @CCNNo,@Plant,@HandlingQA,@HandlingEngineering,@Creator
		WHILE @@FETCH_STATUS = 0
			BEGIN
				
				SET @To=''
				SELECT @To=@To+ISNULL(EmailAddress,'')+';' FROM CCN_User 
					WHERE ((IsQAM = 1 OR IsPEM = 1) AND CHARINDEX(@Plant,Plant)>0) OR LoginName=@Creator
					ORDER BY IsQAM DESC, IsPEM DESC
				
				IF ISNULL(@To,'') <> ''	
					BEGIN
						SET @Subject='You have a CCN('+@CCNNo+') will pass due in one day.'
						SET @Body='<font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Dear Managers,<br><br>Your team have a CCN will pass due in one day, please finish your working task and close it in CCN system otherwise the system will escalate the past due CCN to Plant GM, QA/Engineering Director. Thanks!  </font><br><br><font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Please click on the link below to access CCN system for details: <br /><a href="http://hkgnt117/CCN/Notification.aspx?Num='+@CCNNo+'" target="_blank">http://hkgnt117/CCN</a></font><br><br><font style="FONT-SIZE: 11pt; COLOR: red;">This is an automatically e-mail, please do not reply it! </font>'
						EXEC [CCN_SP_Send_Mail] @To=@To,@Body=@Body,@Subject=@Subject
					END
				
				FETCH NEXT FROM last_cursor INTO @CCNNo,@Plant,@HandlingQA,@HandlingEngineering,@Creator
			END
		
		CLOSE last_cursor
		DEALLOCATE last_cursor
		
		
		DECLARE over_cursor CURSOR FOR 
			SELECT CCNNo,Plant,HandlingQA,HandlingEngineering,Creator,
			CONVERT(VARCHAR(10),CCNReceived,120) AS CCNReceived,CEM,[OEM],CustomerPN,
			MultekPN,DateCode,DetailedType,AffectedPCBQty,AffectedPCBAQty,DefectDesc,
			DefectiveRate,PotentialUP,TotalClaim,EDDate,TCDate
				FROM CCN_Table
				WHERE DATEDIFF(day,ISNULL(EDDate,TCDate),getdate()) > 0 AND APPClose = 0

		OPEN over_cursor
		FETCH NEXT FROM over_cursor INTO @CCNNo,@Plant,@HandlingQA,@HandlingEngineering,@Creator,
										@CCNReceived,@CEM,@OEM,@CustomerPN,@MultekPN,@DateCode,
										@DetailedType,@AffectedPCBQty,@AffectedPCBAQty,@DefectDesc,
										@DefectiveRate,@PotentialUP,@TotalClaim,@EDDate,@TCDate
		WHILE @@FETCH_STATUS = 0
			BEGIN
				
				SET @To=''
				SELECT @To=@To+ISNULL(EmailAddress,'')+';' FROM CCN_User 
					WHERE ((IsQAM = 1 OR IsPEM = 1) AND CHARINDEX(@Plant,Plant)>0) OR LoginName = @Creator
					ORDER BY IsQAM DESC, IsPEM DESC
				
				
				IF DATEDIFF(day,ISNULL(@EDDate,@TCDate),getdate()) = 1
					BEGIN
						SET @CCList=''
						SELECT @CCList=@CCList+ISNULL(EmailAddress,'')+';' FROM CCN_User 
							WHERE (IsQAD = 1 OR (IsGM = 1 AND CHARINDEX(@Plant,Plant)>0))
							ORDER BY IsQAD DESC,IsGM DESC
					END
				ELSE
					SET @CCList = NULL
				
				IF ISNULL(@To,'') <> ''	
					BEGIN
						SET @Subject='You have a pass due CCN('+@CCNNo+')'
						SET @Body='<font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Dear all,<br><br>This email is highlight the open CCN past 15 working days in CCN system, the details please refer to below information. Please click here to send your command to the relative QA/Engineering team. Thanks! </font><br><table style="FONT-SIZE: 11pt;" border="1" cellpadding="1" cellspacing="1"><tr align="center" style="font-weight: bold; color: black; background-color: #CDFFCC;"><td rowspan="2">CCN No.</td><td rowspan="2">Plant</td><td rowspan="2">CCN<br>Received<br>Date</td><td colspan="2">Handling by</td><td rowspan="2">CEM</td><td rowspan="2">OEM</td><td colspan="7">Detailed Information</td><td colspan="3">Potential Impact US$</td></tr><tr align="center"style="font-weight: bold; color: black; background-color: #CDFFCC;"><td>QA</td><td>Engineering</td><td>Customer<br />P/N</td><td>Multek<br />P/N</td><td>Date Code</td><td>Type</td><td>Affected PCB<br />Qty</td><td>Affected PCBA<br />Qty</td><td>Defect<br />Description</td><td>Defective<br />rate (%)</td><td>U/P<br />(US$)</td><td>Total claim<br />(US$)</td></tr><tr align="center"style="color: black; background-color: #ffffff;"><td>'+@CCNNo+'</td><td>'+ISNULL(@Plant,'')+'</td><td>'+ISNULL(@CCNReceived,'')+'</td><td>'+ISNULL(@HandlingQA,'')+'</td><td>'+ISNULL(@HandlingEngineering,'')+'</td><td>'+ISNULL(@CEM,'')+'</td><td>'+ISNULL(@OEM,'')+'</td><td>'+ISNULL(@CustomerPN,'')+'</td><td>'+ISNULL(@MultekPN,'')+'</td><td>'+ISNULL(@DateCode,'')+'</td><td>'+ISNULL(@DetailedType,'')+'</td><td>'+ISNULL(@AffectedPCBQty,'')+'</td><td>'+ISNULL(@AffectedPCBAQty,'')+'</td><td>'+ISNULL(@DefectDesc,'')+'</td><td>'+ISNULL(@DefectiveRate,'')+'</td><td>'+ISNULL(@PotentialUP,'')+'</td><td>'+ISNULL(@TotalClaim,'')+'</td></tr></table><br><font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Please click on the link below to access CCN system for details: <br /><a href="http://hkgnt117/CCN/Notification.aspx?Num='+@CCNNo+'" target="_blank">http://hkgnt117/CCN</a></font><br><br><font style="FONT-SIZE: 11pt; COLOR: red;">This is an automatically e-mail, please do not reply it! </font>'
						EXEC [CCN_SP_Send_Mail] @To=@To,@CC=@CCList,@Body=@Body,@Subject=@Subject
					END
				
				FETCH NEXT FROM over_cursor INTO @CCNNo,@Plant,@HandlingQA,@HandlingEngineering,@Creator,
										@CCNReceived,@CEM,@OEM,@CustomerPN,@MultekPN,@DateCode,
										@DetailedType,@AffectedPCBQty,@AffectedPCBAQty,@DefectDesc,
										@DefectiveRate,@PotentialUP,@TotalClaim,@EDDate,@TCDate
			END
		
		CLOSE over_cursor
		DEALLOCATE over_cursor
END








GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[CCN_SP_Create]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [dbo].[CCN_SP_Create] 
	@CCNNo VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @Plant VARCHAR(10),@CCNReceived VARCHAR(10),@HandlingQA VARCHAR(50)
    DECLARE @HandlingEngineering VARCHAR(50),@CEM NVARCHAR(100),@OEM NVARCHAR(100)
	DECLARE @CustomerPN VARCHAR(50),@MultekPN VARCHAR(50),@DateCode VARCHAR(50)
	DECLARE @DetailedType VARCHAR(50),@AffectedPCBQty VARCHAR(50),@AffectedPCBAQty VARCHAR(50)
	DECLARE @DefectDesc NVARCHAR(4000),@DefectiveRate VARCHAR(50),@PotentialUP VARCHAR(50)
	DECLARE @TotalClaim VARCHAR(50),@Creator VARCHAR(50),@QAMList VARCHAR(500),@QAMMailList VARCHAR(1000)
	DECLARE @Subject NVARCHAR(MAX),@Body NVARCHAR(MAX), @CCList VARCHAR(2000)
		
	IF EXISTS(SELECT * FROM CCN_Table WHERE CCNNo=@CCNNo)
		BEGIN
		
		SELECT @Plant=Plant,@CCNReceived=ISNULL(CONVERT(VARCHAR(10),CCNReceived,120),''),
		@HandlingQA=HandlingQA,@HandlingEngineering=HandlingEngineering,@CEM=CEM,@OEM=[OEM],
		@CustomerPN=CustomerPN,@MultekPN=MultekPN,@DateCode=DateCode,@DetailedType=DetailedType,
		@AffectedPCBQty=AffectedPCBQty,@AffectedPCBAQty=AffectedPCBAQty,@DefectDesc=DefectDesc,
		@DefectiveRate=DefectiveRate,@PotentialUP=PotentialUP,@TotalClaim=TotalClaim,@Creator=Creator
		FROM CCN_Table WHERE CCNNo=@CCNNo
		
		SET @QAMList='';
		SET @QAMMailList=''
		SELECT @QAMList=@QAMList+ISNULL(FullName,'')+',',
			   @QAMMailList=@QAMMailList+ISNULL(EmailAddress,'')+';' FROM CCN_User 
			WHERE Enabled = 1 AND IsQAM = 1 AND CHARINDEX(@Plant,Plant)>0
		
		SET @CCList = ''
		SELECT @CCList=@CCList+ISNULL(EmailAddress,'')+';' FROM CCN_User 
			WHERE Enabled = 1 AND
			(((IsQAM=1 OR IsPEM=1) AND CHARINDEX(@Plant,Plant)>0) OR IsQAD=1 OR LoginName = @Creator)
			ORDER BY IsQAD DESC,IsQAM DESC,IsPEM DESC

		SET @Subject = 'New Received CCN on ' + @CCNReceived
		SET @Body = '<font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Dear all,<br><br>There is a customer complaint from '+ISNULL(@CEM,'')+'/'+ISNULL(@OEM,'')+' on '+ISNULL(@Plant,'')+' Multek P/N:'+ISNULL(@MultekPN,'')+' product received on '+@CCNReceived+'.<br> The details information as below, QA Manager: '+ISNULL(@QAMList,'')+' please login the CCN system to judge if it is critical CCN or not, thanks!  </font><br><table style="FONT-SIZE: 11pt;" border="1" cellpadding="1" cellspacing="1"><tr align="center" style="font-weight: bold; color: black; background-color: #CDFFCC;"><td rowspan="2">CCN No.</td><td rowspan="2">Plant</td><td rowspan="2">CCN<br>Received<br>Date</td><td colspan="2">Handling by</td><td rowspan="2">CEM</td><td rowspan="2">OEM</td><td colspan="7">Detailed Information</td><td colspan="3">Potential Impact US$</td></tr><tr align="center"style="font-weight: bold; color: black; background-color: #CDFFCC;"><td>QA</td><td>Engineering</td><td>Customer<br />P/N</td><td>Multek<br />P/N</td><td>Date Code</td><td>Type</td><td>Affected PCB<br />Qty</td><td>Affected PCBA<br />Qty</td><td>Defect<br />Description</td><td>Defective<br />rate (%)</td><td>U/P<br />(US$)</td><td>Total claim<br />(US$)</td></tr><tr align="center"style="color: black; background-color: #ffffff;"><td>'+@CCNNo+'</td><td>'+ISNULL(@Plant,'')+'</td><td>'+ISNULL(@CCNReceived,'')+'</td><td>'+ISNULL(@HandlingQA,'')+'</td><td>'+ISNULL(@HandlingEngineering,'')+'</td><td>'+ISNULL(@CEM,'')+'</td><td>'+ISNULL(@OEM,'')+'</td><td>'+ISNULL(@CustomerPN,'')+'</td><td>'+ISNULL(@MultekPN,'')+'</td><td>'+ISNULL(@DateCode,'')+'</td><td>'+ISNULL(@DetailedType,'')+'</td><td>'+ISNULL(@AffectedPCBQty,'')+'</td><td>'+ISNULL(@AffectedPCBAQty,'')+'</td><td>'+ISNULL(@DefectDesc,'')+'</td><td>'+ISNULL(@DefectiveRate,'')+'</td><td>'+ISNULL(@PotentialUP,'')+'</td><td>'+ISNULL(@TotalClaim,'')+'</td></tr></table><br><font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Please click on the link below to access CCN system for details: <br /><a href="http://hkgnt117/CCN/Notification.aspx?Num='+@CCNNo+'" target="_blank">http://hkgnt117/CCN</a></font><br><br><font style="FONT-SIZE: 11pt; COLOR: red;">This is an automatically e-mail, please do not reply it! </font>'

		EXEC [CCN_SP_Send_Mail] @To=@QAMMailList,@CC=@CCList,@Body=@Body,@Subject=@Subject
		
		END

END











GO

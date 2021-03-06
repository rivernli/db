USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SendEmail_Invoice_Sale_Amount]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rivern Li
-- Create date: 2011-05-11
-- Description:	SendEmail_Invoice_Sale
-- =============================================
CREATE PROCEDURE [dbo].[SendEmail_Invoice_Sale_Amount]
	-- Add the parameters for the stored procedure here
	@EmailType	nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Date_Diff		INT
	DECLARE	@Amount			MONEY--DECIMAL(18,2)
	DECLARE	@Amount_format	NVARCHAR(20)
	DECLARE	@Last_amount	MONEY
	DECLARE	@Quantity		MONEY
	DECLARE	@SQFT			MONEY
	DECLARE	@IFOK			NVARCHAR(5)
	DECLARE	@Curr_Fyer		NVARCHAR(10)
	DECLARE	@Curr_Period	NVARCHAR(5)
	DECLARE	@CutOff_Time	NVARCHAR(10)


    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)
	
	SET @To      = ''
	SET	@Cc      = ''
	SET @Bcc     = ''
	SET @Subject = ''
	SET @Body    = ''
	SET	@Email   = ''
	SET	@IFOK    = ''
	SET @Date_Diff = 0
	SET	@Last_amount = 0

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_Current_Calender') AND TYPE = 'U')
		DROP TABLE #GET_Current_Calender

	--------------------------------------------------------------------------------------
	;WITH	GET_Current_Calender(StartDate,EndDate,Today,DateDif,FYear,FPeriod)
	 AS
		(
			SELECT CONVERT(VARCHAR(100),MIN(calenderDate),23),
					CONVERT(VARCHAR(100),MAX(calenderDate),23),
					CONVERT(VARCHAR(100),GETDATE(),23),
					DATEDIFF(DD,getdate(),MAX(calenderDate)),
					FiscalYearDesc,FiscalPeriodDesc
			FROM	DataWarehouse.dbo.DW_DIM_Calender AS Cal
			WHERE	LTRIM(RTRIM(FiscalYearDesc))+LTRIM(RTRIM(FiscalPeriodDesc)) IN
				(
					SELECT LTRIM(RTRIM(FiscalYearDesc))+LTRIM(RTRIM(FiscalPeriodDesc))
					FROM	DataWarehouse.dbo.DW_DIM_Calender
					WHERE	calenderDate = CONVERT(VARCHAR(100),GETDATE(),23)
				)
			GROUP BY FiscalYearDesc,FiscalPeriodDesc 
		)

	SELECT * INTO #GET_Current_Calender FROM GET_Current_Calender

	SELECT @Date_Diff = DateDif FROM #GET_Current_Calender

	--------------------------------------------------------------------------------------
	SELECT @CutOff_Time = CAST(DATEPART(HH,GETDATE())-1 AS NVARCHAR(5))+':'+
	CASE WHEN LEN(CAST(DATEPART(MI,GETDATE()) AS NVARCHAR(5)))< 2 THEN '0'+CAST(DATEPART(MI,GETDATE()) AS NVARCHAR(5))
	ELSE	CAST(DATEPART(MI,GETDATE()) AS NVARCHAR(5)) END

	SET @CutOff_Time = ISNULL(@CutOff_Time,'')
	--------------------------------------------------------------------------------------

	IF @Date_Diff < 5
		BEGIN
			IF @EmailType = 'Shipment'
				BEGIN
					SELECT @To = @To + Email + ';' FROM dbo.SendEmail_Invoice_Sale_Users WHERE [Enable] = 1 AND [EmailType] = 'Shipment'
					SET @To = ISNULL(@To,'')

					SELECT @Curr_Fyer = FYear,@Curr_Period = FPeriod FROM #GET_Current_Calender WHERE Today = CONVERT(VARCHAR(100),GETDATE(),23)
					SET	@Curr_Fyer	 = ISNULL(@Curr_Fyer,  '')
					SET @Curr_Period = ISNULL(@Curr_Period,'')

--					-- GET LAST TIME SALES AMOUNT
--					SELECT TOP 1 @Last_amount = AMOUNT FROM dbo.SendEmail_Invoice_Sale_History 
--					WHERE	FYear = @Curr_Fyer	AND	FPeriod = @Curr_Period
--					ORDER BY ID DESC
--					SET	@Last_amount = ISNULL(@Last_amount,0)

					-- GET CURRENT SALES AMOUNT
					SELECT @Amount = SUM(T$AMNT),@Quantity = SUM(T$DQUA),@SQFT = SUM(T$AREA)
					FROM	multekchi_realtime.dbo.TFSOLP101180 
					WHERE T$INVD BETWEEN (SELECT StartDate FROM #GET_Current_Calender) AND (SELECT EndDate FROM #GET_Current_Calender)

					SET	@Amount   = ISNULL(@Amount,  '')
					SET @Quantity = ISNULL(@Quantity,'')
					SET @SQFT     = ISNULL(@SQFT,    '')

--					IF CAST(@Last_amount AS INT) <> CAST(@Amount AS INT)
						BEGIN  -- style="border-collapse: collapse"
							SET @IFOK = 'OK'
							SET @Body=''
								SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
								SET @Body=@Body+'<HTML>'
								SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
								SET @Body=@Body+'Dear All,<br><br>'
								SET @Body=@Body+''
								SET @Body=@Body+'Cut Off Time : '+@CutOff_Time+'<br><br>'
								SET @Body=@Body+'The current period PTD sales invoice as:  <br><br>'
								SET @Body=@Body+'Admin  :<a href = ''mailto:Peter.xu@hk.multek.com''>Peter Xu </a><br>'
								SET @Body=@Body+'Support:<a href = ''mailto:Rivern.li@hk.multek.com''>Rivern Li</a> <br><br>'
								SET @Body=@Body+'<table cellpadding=''1'' border=''1''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse''>'
								SET @Body=@Body+'<tr align=Left style=''font-weight:bold;color:white;background-color:blue;''>'
								SET @Body=@Body+'	<td><b>FYear         </b></td>'
								SET @Body=@Body+'	<td><b>FPeriod       </b></td>'
								SET @Body=@Body+'	<td><b>Date From</b> </td>'
								SET @Body=@Body+'	<td><b>Date To       </b></td>'
								SET @Body=@Body+'	<td><b>Sales Amount  </b></td>'
								SET @Body=@Body+'	<td><b>Total Quantity</b></td>'
								SET @Body=@Body+'	<td><b>Total SQFT</b></td>'
								SET @Body=@Body+'</tr>'
								SET @Body=@Body+'<tr>'
								SET @Body=@Body+'	<td>'+(SELECT FYear FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td>'+(SELECT FPeriod FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td>'+(SELECT StartDate FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td>'+(SELECT EndDate FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td>$'+CONVERT(varchar,@Amount,1)+'</td>'
								SET @Body=@Body+'	<td>'+CONVERT(varchar,@Quantity ,1)+'</td>'
								SET @Body=@Body+'	<td>'+CONVERT(varchar,@SQFT,1)+'</td>'
								SET @Body=@Body+'</tr>'
								SET @Body=@Body+'</table>'
								SET @Body=@Body+'<br>Best Regards'
		--						SET @Body=@Body+'<br>You can click <a href=http://10.201.54.25/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
								SET @Body=@Body+'</BODY></HTML>'

								SET @Amount_format = CONVERT(VARCHAR,CAST(ROUND(@Amount/1000,0) AS MONEY ),1)
								SET @Amount_format = REPLACE(@Amount_format,'.00','K')

								SET @Subject=(SELECT LTRIM(RTRIM(FYear))+' / '+LTRIM(RTRIM(FPeriod)) FROM #GET_Current_Calender)+' PTD at '+@CutOff_Time+' Sales Invoiced Amount is: $'+@Amount_format

--								SET @Subject=(SELECT LTRIM(RTRIM(FYear))+' / '+LTRIM(RTRIM(FPeriod)) FROM #GET_Current_Calender)+' PTD Sales Invoice Amount is: $'+CAST(CAST(ROUND(@Amount/1000,0) AS INT) AS NVARCHAR(30))+'K'
--								INSERT INTO SendEmail_Invoice_Sale_History(TODAY,FYear,FPeriod,Amount) 
--								SELECT GETDATE(),FYear,FPeriod,@Amount FROM #GET_Current_Calender
						END
				END
		END

	--	IF @EmailType = 'Backlog'
	--		BEGIN
	--
	--		END	

	-------------------------------------------------------------------------------------------------
	-- SEND EMAIL
	SET @BCC='Rivern.Li@HK.MULTEK.COM;Peter.xu@hk.multek.com'
	SET @Cc = 'jim.poon@hk.multek.com;Robert.Ho@hk.multek.com'
	IF @IFOK = 'OK'
		BEGIN
			EXEC	msdb.dbo.sp_send_dbmail
					@profile_name          ='CN-HKGMultekApplications&Business@cn.flextronics.com',
					@recipients            =@To,
					@copy_recipients       =@CC,
					@blind_copy_recipients =@BCC,
					@body                  =@Body, 
					@subject               =@Subject,
					--@file_attachments =@Attachment,
					@body_format		   ='HTML'  
		END
END






GO

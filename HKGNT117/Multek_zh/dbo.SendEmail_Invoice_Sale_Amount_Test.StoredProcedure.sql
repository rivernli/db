USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SendEmail_Invoice_Sale_Amount_Test]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rivern Li
-- Create date: 2011-05-11
-- Description:	SendEmail_Invoice_Sale
-- =============================================
CREATE PROCEDURE [dbo].[SendEmail_Invoice_Sale_Amount_Test]
	-- Add the parameters for the stored procedure here
	@EmailType	nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Date_Diff		INT
	DECLARE	@Amount			MONEY--DECIMAL(18,2)
	DECLARE	@Rigid_Amount	NVARCHAR(20)
	DECLARE	@Amount_format	NVARCHAR(20)
	DECLARE	@Last_amount	MONEY
	DECLARE	@Quantity		MONEY
	DECLARE	@SQFT			MONEY
	DECLARE	@IFOK			NVARCHAR(5)
	DECLARE	@Curr_Fyer		NVARCHAR(10)
	DECLARE	@Curr_Period	NVARCHAR(5)
	DECLARE	@CutOff_Time	NVARCHAR(10)

    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@ID INT,@LOOP INT,@Plant NVARCHAR(4),@Sign NVARCHAR(30)
	
	SET @To			= ''
	SET	@Cc			= ''
	SET @Bcc		= ''
	SET @Subject	= ''
	SET @Body		= ''
	SET	@Email		= ''
	SET	@IFOK		= ''
	SET @Date_Diff	= 0
	SET	@Last_amount = 0
	SET @CutOff_Time = ''

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_Current_Calender') AND TYPE = 'U')
		DROP TABLE #GET_Current_Calender

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_Current_Revenue') AND TYPE = 'U')
		DROP TABLE #GET_Current_Revenue

	--------------------------------------------------------------------------------------
	;WITH	GET_Current_Calender(StartDate,EndDate,Today,calenderWeek,DateDif,FYear,FPeriod)
	 AS
		(
			SELECT CONVERT(VARCHAR(100),MIN(calenderDate),23),
					CONVERT(VARCHAR(100),MAX(calenderDate),23),
					CONVERT(VARCHAR(100),GETDATE(),23),
					MIN(calenderWeek),
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

	IF @Date_Diff < 100	--判断从那天开始发邮件
		BEGIN
			IF @EmailType = 'Shipment'
				BEGIN
					SELECT @To = @To + Email + ';' FROM dbo.SendEmail_Invoice_Sale_Users WHERE [Enable] = 1 AND [EmailType] = 'Shipment'

					SELECT @Curr_Fyer = FYear,@Curr_Period = FPeriod FROM #GET_Current_Calender WHERE Today = CONVERT(VARCHAR(100),GETDATE(),23)

					-- GET CURRENT SALES AMOUNT
					SELECT 
						CASE PLANT	
							WHEN ''	  THEN 0
							WHEN '2F' THEN 1
							WHEN 'P2' THEN 2
							WHEN 'B3' THEN 3
							WHEN 'B4' THEN 4
							WHEN 'B5' THEN 5
							WHEN 'HK' THEN 6
							END AS ID,
						CASE PLANT WHEN 'P2' THEN 'B1' WHEN '' THEN 'NA' WHEN 'HK' THEN 'VVI' ELSE PLANT END AS Plant, 
						SUM(SHDOLS) AS SHDOLS,SUM(SHBRDS) AS QUANTITY ,SUM(AREAA) AS AREA
					INTO #GET_Current_Revenue
					FROM MULTEKCHI_REALTIME.DBO.VCR_SHIPPED_ALL_CHINA
					WHERE SHDATE BETWEEN (SELECT StartDate FROM #GET_Current_Calender) AND (SELECT EndDate FROM #GET_Current_Calender)
					GROUP BY PLANT

					SELECT @ID = MAX(ID) FROM #GET_Current_Revenue

					SET @LOOP = 0

--					IF CAST(@Last_amount AS INT) <> CAST(@Amount AS INT)
						BEGIN
							SET @IFOK = 'OK'
							SET @Body=''
								SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
								SET @Body=@Body+'<HTML>'
								SET @Body=@Body+'<body style=''font-size: 10pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
								SET @Body=@Body+'Dear All,<br><br>'
								SET @Body=@Body+''
								SET @Body=@Body+'Cut Off Time : '+@CutOff_Time+'<br><br>'
								SET @Body=@Body+'The current period PTD sales invoice as:  <br><br>'
								SET @Body=@Body+'<table cellpadding=''5'' border=''1''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
								-- Header
								SET @Body=@Body+'<tr align=Left style=''font-weight:bold;color:white;background-color:blue;''>'
								SET @Body=@Body+'	<th><b>FYear			</b></td>'
								SET @Body=@Body+'	<th><b>FPeriod			</b></td>'
								SET @Body=@Body+'	<th><b>Date From        </b></td>'
								SET @Body=@Body+'	<th><b>Date To			</b></td>'
								SET @Body=@Body+'	<th><b>Plant			</b></td>'
								SET @Body=@Body+'	<th><b>Sales Amount     </b></td>'
								--SET @Body=@Body+'	<th><b>Total Quantity   </b></td>'
								--SET @Body=@Body+'	<th><b>Total SQFT       </b></td>'
								SET @Body=@Body+'</tr>'
								-- Content
								SET @Body=@Body+'<tr>'
								SET @Body=@Body+'	<td ROWSPAN = ''9'' align = ''center'' >'+(SELECT FYear FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td ROWSPAN = ''9'' align = ''center'' >'+(SELECT FPeriod FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td ROWSPAN = ''9'' align = ''center'' >'+(SELECT StartDate FROM #GET_Current_Calender)+'</td>'
								SET @Body=@Body+'	<td ROWSPAN = ''9'' align = ''center'' >'+(SELECT EndDate FROM #GET_Current_Calender)+'</td>'

								SET @LOOP = @LOOP + 1
								SELECT	@Plant = PLANT,@Amount = SHDOLS,@Quantity = QUANTITY,@SQFT = AREA FROM #GET_Current_Revenue WHERE ID = @LOOP
								IF @Amount < 0 
									BEGIN SET @Sign = '-$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','') END
								ELSE 
									BEGIN SET @Sign = '$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','') END
								SET @Body=@Body+'	<td align = ''center''>'+CONVERT(varchar,@Plant,1)+'</td>'
								SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Sign,1) +'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Quantity ,1)+'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@SQFT,1)+'</td>'
								SET @Body=@Body+'</tr>'
								
								WHILE @LOOP < @ID
									BEGIN
										IF @LOOP%2 = 0
											SET @Body=@Body+'<tr>'
										ELSE
											SET @Body=@Body+'<tr style='+''''+'color: BLUE; background-color: #F0F0F0;'+''''+'>'
										SET @LOOP = @LOOP + 1
										SELECT	@Plant = PLANT,@Amount = SHDOLS,@Quantity = QUANTITY,@SQFT = AREA FROM #GET_Current_Revenue WHERE ID = @LOOP

										IF @Amount < 0 
											BEGIN SET @Sign = '-$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','') END
										ELSE 
											BEGIN SET @Sign = '$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','') END

										SET @Body=@Body+'	<td align = ''center''>'+CONVERT(varchar,@Plant,1)+'</td>'
										SET @Body=@Body+'	<td align = ''right''>'+@Sign+'</td>'
										--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Quantity ,1)+'</td>'
										--SET @Body=@Body+'	<td align = ''right'' background-color: navy;>'+CONVERT(varchar,@SQFT,1)+'</td>'
										SET @Body=@Body+'</tr>'
									END
								-- Total Exclude B2F
								SET @Body=@Body+'<tr><b>'
								SET @LOOP = @LOOP + 1
								SELECT	@Amount = SUM(SHDOLS),@Quantity = SUM(QUANTITY),@SQFT = SUM(AREA) FROM #GET_Current_Revenue WHERE PLANT <> '2F'
								
								SET	@Rigid_Amount = CONVERT(VARCHAR,CAST(ROUND(@Amount/1000,0) AS MONEY ),1)
								SET @Rigid_Amount = REPLACE(@Rigid_Amount,'.00','K')
								
								SET @Body=@Body+'	<td align = ''center''>Rigid</td>'
								SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','')  +'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Quantity ,1)+'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@SQFT,1)     +'</td>'
								SET @Body=@Body+'</b></tr>'
								-- Total
								SET @Body=@Body+'<tr><b>'
								SET @LOOP = @LOOP + 1
								SELECT	@Amount = SUM(SHDOLS),@Quantity = SUM(QUANTITY),@SQFT = SUM(AREA) FROM #GET_Current_Revenue
								SET @Body=@Body+'	<td align = ''center''>Total</td>'
								SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','')  +'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Quantity ,1)+'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@SQFT,1)     +'</td>'
								SET @Body=@Body+'</b></tr>'
								-- Foolter
								SET @Body=@Body+'</table><br><br>'
								SET @Body=@Body+'Admin  :<a href = ''mailto:Peter.xu@hk.multek.com''>Peter Xu </a><br>'
								SET @Body=@Body+'Support:<a href = ''mailto:Rivern.li@hk.multek.com''>Rivern Li</a> <br>'
								SET @Body=@Body+'<br>Best Regards'
		--						SET @Body=@Body+'<br>You can click <a href=http://10.201.54.25/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
								SET @Body=@Body+'</BODY></HTML>'

								SET @Amount_format = CONVERT(VARCHAR,CAST(ROUND(@Amount/1000,0) AS MONEY ),1)
								SET @Amount_format = REPLACE(@Amount_format,'.00','K')

								SET @Subject=(SELECT LTRIM(RTRIM(FYear))+' / '+LTRIM(RTRIM(FPeriod)) FROM #GET_Current_Calender)+' PTD at '+@CutOff_Time+'  Sales Invoiced Amount is: $'+@Amount_format + ' (Rigid is: $'+@Rigid_Amount+')'
						END
				END
		END

	--	IF @EmailType = 'Backlog'
	--		BEGIN
	--
	--		END	

	-------------------------------------------------------------------------------------------------
	-- SEND EMAIL
	SET @To = 'Rivern.li@hk.multek.com'
--	SET @BCC='Rivern.Li@HK.MULTEK.COM;Peter.xu@hk.multek.com'

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

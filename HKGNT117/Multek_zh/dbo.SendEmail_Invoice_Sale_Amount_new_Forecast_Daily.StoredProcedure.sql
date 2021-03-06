USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SendEmail_Invoice_Sale_Amount_new_Forecast_Daily]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Rivern Li
-- Create date: 2011-05-11
-- Description:	SendEmail_Invoice_Sale
-- 2013-02-20 William Choi request add forecast
-- 2013-08-06 William Choi request add dayly send.
/*
	2013-03-29 OP Chery tell the order type "SNE" should be can't 
	count in sales, it sales from B2F to B4
*/
-- =============================================
CREATE PROCEDURE [dbo].[SendEmail_Invoice_Sale_Amount_new_Forecast_Daily]
	-- Add the parameters for the stored procedure here
	@EmailType	nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Date_Diff		INT
	DECLARE	@Date_Total		INT
	DECLARE	@loop_tu		INT
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
	DECLARE	@Forecast		MONEY
	DECLARE	@Delta			MONEY
	DECLARE	@sqlstring		NVARCHAR(MAX)
	

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

--判断今天是否是每月的最后一周，如果不是则发送邮件
	IF EXISTS
	(
		SELECT CONVERT(VARCHAR(10),GETDATE(),120) WHERE CONVERT(VARCHAR(10),GETDATE(),120) IN
		(
			SELECT CONVERT(VARCHAR(10),CALENDERDATE,120)
			FROM DataWarehouse.DBO.DW_DIM_CALENDER
			WHERE FISCALYEARDESC+FISCALPERIODDESC+CAST(CALENDERYEARWEEK AS NVARCHAR(2)) IN
			(
				SELECT	FISCALYEARDESC+FISCALPERIODDESC+CAST(MAX(CALENDERYEARWEEK) AS NVARCHAR(2))
				FROM	DataWarehouse.DBO.DW_DIM_CALENDER 
				WHERE	CALENDERWEEK = 1 AND CALENDERDATE > GETDATE()-30
				GROUP BY FISCALYEARDESC,FISCALPERIODDESC
			)
		)
	)
		BEGIN
			RETURN
		END

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_Current_Calender') AND TYPE = 'U')
		DROP TABLE #GET_Current_Calender

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_Current_Revenue') AND TYPE = 'U')
		DROP TABLE #GET_Current_Revenue

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_Current_Forecast') AND TYPE = 'U')
		DROP TABLE #GET_Current_Forecast
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

	SELECT @Date_Diff = DateDif,@Date_Total = (DATEDIFF(DD,StartDate,EndDate))+1 FROM #GET_Current_Calender

	--------------------------------------------------------------------------------------

	SELECT @CutOff_Time = CAST(DATEPART(HH,GETDATE())-1 AS NVARCHAR(5))+':'+
	CASE WHEN LEN(CAST(DATEPART(MI,GETDATE()) AS NVARCHAR(5)))< 2 THEN '0'+CAST(DATEPART(MI,GETDATE()) AS NVARCHAR(5))
	ELSE	CAST(DATEPART(MI,GETDATE()) AS NVARCHAR(5)) END

	SET @CutOff_Time = ISNULL(@CutOff_Time,'')
	--------------------------------------------------------------------------------------

--select * from #GET_Current_Calender
--select @Date_Diff
--select @Date_Total

--select cast(cast(cast(@Date_Diff as float)/@Date_Total*100 as int) as varchar)
--select cast(cast(100-cast(@Date_Diff as float)/@Date_Total*100 as int) as varchar)

--	IF @Date_Diff < 6	--判断从那天开始发邮件
	if 1= 1
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
						--WHERE SHDATE BETWEEN (SELECT StartDate FROM #GET_Current_Calender) AND (SELECT EndDate FROM #GET_Current_Calender)
						WHERE invoice_date BETWEEN (SELECT StartDate FROM #GET_Current_Calender) AND (SELECT EndDate FROM #GET_Current_Calender)
						GROUP BY PLANT

					-- Get Forecast data
						set @sqlstring = '
						SELECT CASE PLANT WHEN '+''''+'P2'+''''+' THEN '+''''+'B1'+''''+' WHEN '+''''+'HK'+''''+' THEN '+''''+'VVI'+''''+' ELSE PLANT END AS Plant,
						'+CASE RIGHT(LEFT(@Curr_Period,2),1) WHEN 0 THEN REPLACE(@Curr_Period,'P0','M') WHEN 1 THEN REPLACE(@Curr_Period,'P','M') END +' AS Forecast  
						FROM [hkgnt111].[Multek_SZ_New].[dbo].[DistributionReport_Forecast]
						WHERE	[TYpe] = '+''''+'outbound'+''''+'
						AND		[YEAR] = 
						(
							SELECT	right(rtrim(FISCALYEARDESC),4)
							FROM	DataWarehouse.DBO.DW_DIM_CALENDER 
							WHERE	CALENDERDATE = convert(nvarchar(10),GETDATE(),120)
						)
						AND		Plant <> '+''''+'sub'+''''+'
						and		site = '+''''+'Chi'+''''

						SELECT PLANT,M1 AS Forecast INTO #GET_Current_Forecast FROM [hkgnt111].[Multek_SZ_New].[dbo].[DistributionReport_Forecast] WHERE 1<> 1
						INSERT INTO #GET_Current_Forecast EXEC (@sqlstring)

					SELECT @ID = MAX(ID) FROM #GET_Current_Revenue

					SET @LOOP = 0

--					IF CAST(@Last_amount AS INT) <> CAST(@Amount AS INT)
						BEGIN
							SET @IFOK = 'OK'
							SET @Body=''
								SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
								SET @Body=@Body+'<HTML>'
								SET @Body=@Body+'<body style=''font-size: 10pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
								SET @Body=@Body+'Dear All:'
								SET @Body=@Body+''
							-- Lead time
								SET @Body=@Body+'<table cellpadding=''5'' border=''0''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
								SET @Body=@Body+'	<tr>'
								SET @Body=@Body+'		<td bgcolor=''White'' align = ''center''>'+cast(@Date_Diff as varchar)+' Days to build in '+(SELECT FPeriod FROM #GET_Current_Calender)+'/'+(SELECT FYear FROM #GET_Current_Calender)+'('+(select enMonth FROM	DataWarehouse.dbo.DW_DIM_Calender where calenderdate = convert(varchar(10),getdate(),120))+')'
								SET @Body=@Body+'		</td>'
								SET @Body=@Body+'	</tr>'
								SET @Body=@Body+'</table>'
							--图例
								SET @Body=@Body+'<table cellpadding=''5'' border=''0''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
								SET @Body=@Body+'	<tr>'
								SET @Body=@Body+'		<td width=''4%''><hr color=''green'' style=''width: 10px'' align=''right''/>'
								SET @Body=@Body+'		</td>'
								SET @Body=@Body+'		<td width=''6%'' align=''left''>Past'
								SET @Body=@Body+'		</td>'
								SET @Body=@Body+'		<td width = ''4%''><hr color=''red'' style=''width: 10px'' align=''right''/>'
								SET @Body=@Body+'		</td>'
								SET @Body=@Body+'		<td width=''10%''>Avaiable'
								SET @Body=@Body+'		</td>'
								SET @Body=@Body+'		<td width=''76%''>'
								SET @Body=@Body+'		</td>'
								SET @Body=@Body+'	</tr>'
								SET @Body=@Body+'</table>'

							--图-上面的线
								SET @loop_tu = 1
								SET @Body=@Body+'<table cellpadding=''5'' border=''0''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
								--SET @Body=@Body+'	<tr>'
								--	WHILE @loop_tu <= @Date_Total
								--		BEGIN
								--			SET @Body=@Body+'<td style='';border-left:#cccccc; solid 1px;''>1</td>'
								--			SET @loop_tu = @loop_tu + 1
								--		END
								--SET @Body=@Body+'	</tr>'
							
							--中间的红绿图
								SET @loop_tu = 1
								SET @Body=@Body+'	<tr>'
								WHILE @loop_tu <= @Date_Total
									BEGIN
										IF @loop_tu <= @Date_Total - @Date_Diff
											SET @Body=@Body+'<td bgcolor=''green''></td>'
										ELSE
											SET @Body=@Body+'<td bgcolor=''red''></td>'
										SET @loop_tu = @loop_tu + 1
									END
								SET @Body=@Body+'	</tr>'

							--图-下面的线
								SET @loop_tu = 1
								SET @Body=@Body+'	<tr>'
									WHILE @loop_tu <= @Date_Total
										BEGIN
											SET @Body=@Body+'<td style='';border-left:#cccccc; solid 1px;'' align=''center''>'+CAST(@loop_tu AS VARCHAR)+'</td>'
											SET @loop_tu = @loop_tu + 1
										END
								SET @Body=@Body+'	</tr>'

								SET @Body=@Body+'</table><br/><br/>'
							-- Header
								--SET @Body=@Body+'Cut Off Time : '+@CutOff_Time+'<br><br>'
								--SET @Body=@Body+'The current period PTD sales invoice as:  <br><br>'
								SET @Body=@Body+'<table cellpadding=''5'' border=''1''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
								SET @Body=@Body+'<tr>'
								SET @Body=@Body+'<td colspan=''8'' align=''center''>The current period PTD sales invoice as:'
								SET @Body=@Body+'</td>'
								SET @Body=@Body+'</tr>'
								SET @Body=@Body+'<tr align=Left style=''font-weight:bold;color:white;background-color:blue;''>'
								SET @Body=@Body+'	<th><b>FY				</b></td>'
								SET @Body=@Body+'	<th><b>Period			</b></td>'
								SET @Body=@Body+'	<th><b>Date From        </b></td>'
								SET @Body=@Body+'	<th><b>Date To			</b></td>'
								SET @Body=@Body+'	<th><b>Plant			</b></td>'
								SET @Body=@Body+'	<th><b>Fin Fct     </b></td>'
								SET @Body=@Body+'	<th><b>Sales Amount     </b></td>'
								SET @Body=@Body+'	<th><b>Delta     </b></td>'
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
								SELECT @Forecast = Forecast FROM #GET_Current_Forecast WHERE PLANT = @Plant
								IF @Amount < 0 
									BEGIN 
										SET @Sign = '-$'+REPLACE(CONVERT(varchar,ROUND(ABS(@Amount),0),1),'.00','') 
										SET @Delta = ROUND(@Forecast + @Amount,0)
									END
								ELSE 
									BEGIN 
										SET @Sign = '$'+REPLACE(CONVERT(varchar,ROUND(ABS(@Amount),0),1),'.00','') 
										SET @Delta = ROUND(@Amount - @Forecast,0)
									END
	
								SET @Body=@Body+'	<td align = ''center''>'+CONVERT(varchar,@Plant,1)+'</td>'
								SET @Body=@Body+'	<td align = ''right''>'+'$'+REPLACE(CONVERT(varchar,@Forecast,1),'.00','') +'</td>'
								SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Sign,1) +'</td>'
								IF @Delta > 0
									SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,@Delta,1),'.00','') +'</td>'
								ELSE
									SET @Body=@Body+'	<font color=''red''><td align = ''right''>-$'+REPLACE(CONVERT(varchar,ABS(@Delta),1),'.00','') +'</td></font>'
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
										SELECT @Forecast = Forecast FROM #GET_Current_Forecast WHERE PLANT = @Plant
										
										IF @Amount < 0 
											BEGIN
												SET @Sign = '-$'+REPLACE(CONVERT(varchar,ROUND(ABS(@Amount),0),1),'.00','')
												SET @Delta = ROUND(@Forecast + @Amount,0)
											END
										ELSE
											BEGIN
												SET @Sign = '$'+REPLACE(CONVERT(varchar,ROUND(ABS(@Amount),0),1),'.00','')
												SET @Delta = ROUND(@Amount - @Forecast ,0)
											END

										SET @Body=@Body+'	<td align = ''center''>'+CONVERT(varchar,@Plant,1)+'</td>'
										SET @Body=@Body+'	<td align = ''right''>'+'$'+REPLACE(CONVERT(varchar,@Forecast,1),'.00','')+'</td>'
										SET @Body=@Body+'	<td align = ''right''>'+@Sign+'</td>'
										IF @Delta < 0
											SET @Body=@Body+'	<font color=''red''><td align = ''right''>-$'+REPLACE(CONVERT(varchar,ABS(@Delta),1),'.00','')+'</td></font>'
										ELSE
											SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,@Delta,1),'.00','')+'</td>'
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
								SELECT @Forecast = Forecast FROM #GET_Current_Forecast WHERE PLANT = 'ZhuHaiEXB2F'
								SET @Delta = @Amount - @Forecast

								SET @Body=@Body+'	<td align = ''center''>Rigid</td>'
								SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Forecast,0),1),'.00','')  +'</td>'
								SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','')  +'</td>'
								IF @Delta <0
									SET @Body=@Body+'	<font color=''red''><td align = ''right''>-$'+REPLACE(CONVERT(varchar,ROUND(ABS(@Delta),0),1),'.00','')  +'</td></font>'
								ELSE
									SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Delta,0),1),'.00','')  +'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Quantity ,1)+'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@SQFT,1)     +'</td>'
								SET @Body=@Body+'</b></tr>'

							-- Total
								SET @Body=@Body+'<tr><b>'
								SET @LOOP = @LOOP + 1
								SELECT	@Amount = SUM(SHDOLS),@Quantity = SUM(QUANTITY),@SQFT = SUM(AREA) FROM #GET_Current_Revenue
								SELECT @Forecast = Forecast FROM #GET_Current_Forecast WHERE PLANT = ''
								SET @Delta = @Amount - @Forecast
								SET @Body=@Body+'	<td align = ''center''>Total</td>'
								SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Forecast,0),1),'.00','')  +'</td>'
								SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Amount,0),1),'.00','')  +'</td>'
								if @Delta < 0
									SET @Body=@Body+'	<font color=''red''><td align = ''right''>-$'+REPLACE(CONVERT(varchar,ROUND(ABS(@Delta),0),1),'.00','')  +'</td></font>'
								ELSE
									SET @Body=@Body+'	<td align = ''right''>$'+REPLACE(CONVERT(varchar,ROUND(@Delta,0),1),'.00','')  +'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@Quantity ,1)+'</td>'
								--SET @Body=@Body+'	<td align = ''right''>'+CONVERT(varchar,@SQFT,1)     +'</td>'
								SET @Body=@Body+'</b></tr>'
							-- Foolter
								SET @Body=@Body+'</table><br>'
								SET @Body=@Body+'<span><font color=''red''>Final sales revenue from orders is subject to the actual hub bill of FTM & FLHK entities<br>'
								SET @Body=@Body+'which may have variance with the Baan invoice sales as above numbers which are billed as firmed PO<br><br>'
								SET @Body=@Body+'Finance will report the actual final result later on when all Fin numbers cleared in transaction.<br>'
								SET @Body=@Body+'</font></span><br>'
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
	SET @To = 'Rivern.li@multek.com'
	SET @BCC= 'Rivern.li@multek.com'
	SET @CC = ''

--	SET @BCC='Rivern.Li@HK.MULTEK.COM;Peter.xu@hk.multek.com'
----	SET @Cc = 'jim.poon@hk.multek.com;Robert.Ho@hk.multek.com'		-- OP Cherry request remove jim email address
--	SET @Cc = 'Robert.Ho@hk.multek.com'

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

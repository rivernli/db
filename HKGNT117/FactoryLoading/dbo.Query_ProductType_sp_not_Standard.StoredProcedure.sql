USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[Query_ProductType_sp_not_Standard]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Query_ProductType_sp_not_Standard]
@TYPE NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SET @TYPE = ISNULL(@TYPE,'')
    IF @TYPE = ''
		BEGIN
			RAISERROR('Please select query or email to exec',16,1)
			RETURN
		END
    
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#FSCPP711') AND TYPE = 'U')
		DROP TABLE #FSCPP711

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#FSOLP108') AND TYPE = 'U')  -- Yield
		DROP TABLE #FSOLP108

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#RESULT_NOT_STANDARD') AND TYPE = 'U')
		DROP TABLE #RESULT_NOT_STANDARD

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#RESULT_NOT_SET') AND TYPE = 'U')
		DROP TABLE #RESULT_NOT_SET

	-- INSERT DATA TO TEMP TABLE 
		SELECT T$ITEM,T$PLNT INTO #FSCPP711 FROM DBO.TFSCPP711180
		WHERE T$TRDT > '2011-04-01' AND T$PLNT <> '2F'
		GROUP BY T$ITEM,T$PLNT
		ORDER BY T$ITEM,T$PLNT

		UPDATE	#FSCPP711 SET T$PLNT = 'B1' WHERE T$PLNT = 'P2' OR T$PLNT = 'P1'

		SELECT T$VALU INTO #FSAMI028 FROM dbo.TFSAMI028180 WHERE T$ITEM = 'TYPE'

	-- NOT STANDARD PRODUCT TYPE
	
		SELECT 'SHIPMENT' AS LOC ,B.T$ASTR,B.T$ITEM,A.T$PLNT INTO	#RESULT_NOT_STANDARD
		FROM #FSCPP711 AS A,TFIATT006180 AS B
		WHERE	A.T$ITEM = B.T$ITEM 
		AND		B.T$ATTR = 'TYPE'
		AND		B.T$ASTR NOT IN(SELECT T$VALU FROM #FSAMI028)
		--AND		A.T$PLNT <> 'HK'

		INSERT INTO #RESULT_NOT_STANDARD
		SELECT 'Booking' AS LOC ,B.T$ASTR,B.T$ITEM,A.T$PLNT
		FROM Multek_zh.dbo.TFSOLP122180 AS A,FactoryLoading.dbo.TFIATT006180 AS B
		WHERE	A.T$ITEM = B.T$ITEM 
		AND		B.T$ATTR = 'TYPE'
		AND		B.T$ASTR NOT IN(SELECT T$VALU FROM #FSAMI028)
		and		a.t$plnt not in ('2F')
		group by B.T$ASTR,B.T$ITEM,A.T$PLNT
		order by t$item

		INSERT INTO #RESULT_NOT_STANDARD
		SELECT 'ASP/ALC' AS LOC ,T$PRDT,T$ITEM,T$PLNT FROM MULTEK_ZH.DBO.TFSOLP112180 WHERE T$DATE > '2011-04-01' AND T$PLNT <> '2F'
		AND T$PRDT NOT IN(SELECT T$VALU FROM [FACTORYLOADING].[DBO].[TFSAMI028180] WHERE T$ITEM = 'TYPE')
		GROUP BY T$PRDT,T$ITEM,T$PLNT
		UNION 
		SELECT 'YIELD' AS LOC ,T$PRDT,LEFT(LTRIM(T$PITM),8),T$PLNT FROM MULTEK_ZH.DBO.TFSOLP108180 WHERE T$INDT > '2011-04-01' AND T$PLNT <> '2F' 
		AND T$PRDT NOT IN(SELECT T$VALU FROM [FACTORYLOADING].[DBO].[TFSAMI028180] WHERE T$ITEM = 'TYPE')
		GROUP BY T$PRDT,LEFT(LTRIM(T$PITM),8),T$PLNT

		ALTER TABLE #RESULT_NOT_STANDARD ADD ID INT IDENTITY

	-- PRODUCT TYPE NOT SET
		SELECT	A.T$ITEM INTO	#RESULT_NOT_SET FROM #FSCPP711 AS A
		WHERE	A.T$ITEM NOT IN(SELECT B.T$ITEM FROM TFIATT006180 AS B)
		AND		LEN(LTRIM(RTRIM(A.T$ITEM))) = 8

	-- SHOW RESULT
		IF @TYPE = 'query'
			BEGIN
				SELECT * FROM #RESULT_NOT_SET
				SELECT * FROM #RESULT_NOT_STANDARD
			END

		IF @TYPE = 'email'
			BEGIN
				DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@id int
				DECLARE	@ITEM	NVARCHAR(13),@ATTR	NVARCHAR(50),@PLANT	NVARCHAR(5),@IFOK NVARCHAR(5),@LOOP INT,@LOC NVARCHAR(20)
				SET @To			 = ''
				SET	@Cc			 = ''
				SET @Bcc		 = ''
				SET @Subject	 = ''
				SET @Body		 = ''
				SET	@Email		 = ''

				SET @IFOK = ''
				SET	@LOOP = 0
				SET @Body=''
					SELECT @id = MAX(ID) FROM #RESULT_NOT_STANDARD
					IF	@ID > 0 
						BEGIN
							SET @IFOK = 'OK'
							SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
							SET @Body=@Body+'<HTML>'
							SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
							SET @Body=@Body+'Dear All,<br><br>'
							SET @Body=@Body+''
							SET @Body=@Body+'	The following project product type not standard(not include B2F),please check!'
							SET @Body=@Body+'<br>'
							SET @Body=@Body+'<br>'
							SET @Body=@Body+'Admin  :<a href = ''mailto:Peter.xu@hk.multek.com''>Peter Xu </a><br>'
							SET @Body=@Body+'Support:<a href = ''mailto:Rivern.li@hk.multek.com''>Rivern Li</a> <br><br>'
							SET @Body=@Body+'<table cellpadding=''1'' border=''1''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
							SET @Body=@Body+'<tr align=Left style=''font-weight:bold;color:white;background-color:blue;''>'
							SET @Body=@Body+'	<th><b>loc         </b></td>'
							SET @Body=@Body+'	<th><b>Project         </b></td>'
							SET @Body=@Body+'	<th><b>Product Type         </b></td>'
							SET @Body=@Body+'	<th><b>Plant         </b></td>'
							SET @Body=@Body+'</tr>'
							WHILE @LOOP < @ID
								BEGIN
									SET @LOOP = @LOOP + 1
									SELECT	@LOC = LOC,@ITEM = T$ITEM,@ATTR = T$ASTR,@PLANT = T$PLNT FROM #RESULT_NOT_STANDARD WHERE ID = @LOOP
									SET @Body=@Body+'<tr>'
									SET @Body=@Body+'	<td>' + (@LOC) + '</td>'
									SET @Body=@Body+'	<td>' + (@ITEM) + '</td>'
									SET @Body=@Body+'	<td>' + (@ATTR) + '</td>'
									SET @Body=@Body+'	<td>' + (@PLANT) + '</td>'
									SET @Body=@Body+'</tr>'
								END
								SET @Body=@Body+'</table>'
								SET @Body=@Body+'<br>Best Regards'
					
							SET @Subject= 'Please check project product type not standard!'
					
							SET	@To = 'Kanphy.Lu@hk.multek.com;yuxia.Tan@hk.multek.com'
						END
					ELSE
						BEGIN
							SET @IFOK = 'NO'
						END

				IF @IFOK = 'OK'
					BEGIN
						SET @BCC='Rivern.Li@HK.MULTEK.COM;Peter.xu@hk.multek.com;charlie.niu@hk.multek.com'
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
	-- END DROP TEMP TABLE
		DROP TABLE #FSCPP711	
		DROP TABLE #FSAMI028
		DROP TABLE #RESULT_NOT_STANDARD
		DROP TABLE #RESULT_NOT_SET
END

GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_So_Info]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_So_Info]
@So			NVARCHAR(10),
@User		NVARCHAR(50),
@Operation	NVARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@PLANT	NVARCHAR(5),@To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)
	DECLARE	@Name	nvarchar(50)
    -- Insert statements for procedure here
    SET @So		= ISNULL(@So,'')
	SET @User	= ISNULL(@User,'')    
	
	IF @Operation = 'INSERT'
		BEGIN
			--INTSERT HEADER 
			
			IF NOT EXISTS(SELECT * FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO  and STATUS <> 'Complete' )
				BEGIN
					-- search user name
					SET @Name = ''
					SELECT @Name = BDM FROM dbo.Cancellation_Charge_Users WHERE UserID = LTRIM(RTRIM(@User))
					SET @Name = ISNULL(@Name,'')

					-- Insert so header
					INSERT INTO dbo.Cancellation_Charge_Order_Header(SO,Plant,OEM,OrderQuantity,BacklogQuantity,Date,[User],STATUS)
					
					SELECT A.T$ORNO,B.T$PLNT,A.T$ECDT,sum(A.T$OQUA),SUM(A.T$BQUA),CONVERT(NVARCHAR,GETDATE(),111) AS DDTA,@Name,'Waiting PPC'
					FROM	multekchi_realtime.dbo.TFSOLP100180 as a,FactoryLoading.dbo.TFSCPP201 as b
					WHERE A.T$CWAR = B.T$CWAR	AND A.T$ORNO = @SO
					GROUP BY A.T$ORNO,B.T$PLNT,A.T$ECDT

					-- INSERT DETAILS
					INSERT INTO Cancellation_Charge_Order_Details(ID,T$ORNO,T$PONO,T$ITEM,T$DDTA,T$PLNT,T$OQUA,T$BQUA,T$CCUR,T$PRIC,T$ECDT)
					SELECT SCOPE_IDENTITY(),A.T$ORNO,A.T$PONO,A.T$ITEM,CONVERT(NVARCHAR,A.T$DDTA,111) AS T$DDTA,B.T$PLNT,A.T$OQUA,A.T$BQUA,A.T$CCUR,A.T$PRIC,A.T$ECDT
					FROM	multekchi_realtime.dbo.TFSOLP100180 as a,FactoryLoading.dbo.TFSCPP201 as b
					WHERE A.T$CWAR = B.T$CWAR	AND A.T$ORNO = @SO	
					
					-- UPDATE ITEM'S STANDARD COST
					UPDATE Cancellation_Charge_Order_Details SET T$COPR = A.T$COPR 
					FROM FactoryLoading.dbo.TTIITM001180 AS A ,Cancellation_Charge_Order_Details AS B
					WHERE A.T$ITEM = B.T$ITEM

					-- Insert FG Information
					INSERT INTO dbo.Cancellation_Charge_PPC_FG
					SELECT * FROM Cancellation_Charge_vw_fscpp253180 WHERE T$ORNO = @SO 

					-- Update Standard cost
				END
			ELSE
				BEGIN
					RAISERROR('The order had requested cancel,Please check request list!',16,1)
					RETURN
				END
			-- SEND EMAIL TO PPC 
			IF EXISTS(SELECT * FROM Cancellation_Charge_Order_Header WHERE SO = @SO)
				BEGIN
					SET @To = ''
					SELECT TOP 1 @PLANT = PLANT FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO and STATUS = 'Request' ORDER BY ID DESC
					IF @PLANT = '2F' 
						SET @PLANT = 'B2F'
					IF @PLANT = 'P1' OR @PLANT = 'P2' 
						SET @PLANT = 'B1'

					--SELECT @To = @To + Email FROM dbo.Cancellation_ppc_Email WHERE PLANT = @PLANT
					SELECT @To = @To + A.Email FROM dbo.Cancellation_Charge_Users AS A LEFT JOIN 
						dbo.Cancellation_Charge_UserPlantAuthority AS B ON A.UserID = B.UserID WHERE A.Administrator = 'PPC'
						AND	B.Plant = @PLANT

					SET @To = ISNULL(@To,'')
					
					SET @CC = ''
					SET @CC = ISNULL(@CC,'')
					
					SET @Body = ''
					SET @Body = @Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
					SET @Body = @Body+'<HTML>'
					SET @Body = @Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
					SET @Body = @Body+'Dear ppc colleagues,<br><br>'
					SET @Body = @Body+''
					SET @Body = @Body+'	MKT will cancell following order,would you please help to check relation information.thanks<br>'
					SET @Body = @Body+'<br>'
					SET @Body = @Body+'	Click <a href=''#''>Here</a> to enter information!'
					SET @Body = @Body+'<br>'
					SET @Body = @Body+'<br>'
					SET @Body = @Body+'<table cellpadding=''1'' border=''1''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;border-color:#FFFFFF''>'
					SET @Body = @Body+'<tr align=Left style=''font-weight:bold;color:white;background-color:blue;''>'
					SET @Body = @Body+'	<td><b>SO         </b></td>'
					SET @Body = @Body+'	<td><b>Order Quantity       </b></td>'
					SET @Body = @Body+'	<td><b>Backlog Quantity       </b></td>'
					SET @Body = @Body+'	<td><b>Request User</b> </td>'
					SET @Body = @Body+'</tr>'
					SET @Body = @Body+'<tr>'
					SET @Body = @Body+'<td>'+(SELECT TOP 1 CONVERT(varchar,SO,1) FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO ORDER BY ID DESC )+'</td>'
					SET @Body = @Body+'<td>'+(SELECT TOP 1 CONVERT(varchar,OrderQuantity,1) FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO ORDER BY ID DESC )+'</td>'
					SET @Body = @Body+'<td>'+(SELECT TOP 1 CONVERT(varchar,BacklogQuantity,1) FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO ORDER BY ID DESC )+'</td>'
					SET @Body = @Body+'<td>'+(SELECT TOP 1 [USER] FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO ORDER BY ID DESC )+'</td>'
					SET @Body = @Body+'</tr>'
					SET @Body = @Body+'</table>'
					SET @Body = @Body+'<br>Best Regards'
					SET @Body = @Body+'</BODY></HTML>'
					
					SET @Subject = 'Cost calculation for Cancellation of sale order - '+ CONVERT(VARCHAR,@SO,1)

					SET @BCC='Rivern.Li@hk.multek.com'

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
END






GO

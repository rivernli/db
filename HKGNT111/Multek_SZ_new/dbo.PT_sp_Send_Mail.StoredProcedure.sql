USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Send_Mail]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Send_Mail] 
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@OrderCheckListAutoID INT=NULL,
	@OrderCheckListDetailAutoID INT=NULL,
	@OperatorUserID VARCHAR(50)=NULL,
	@Option VARCHAR(50)=NULL,
	@Code VARCHAR(10)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)

	IF @Option='Insert Order'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (SELECT AutoID FROM PT_Department WHERE CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0)
				AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' created a new order . The following is the detail . Please upload the related files ASAP.<br><br>'
			SET @Body=@Body+'<b>Order ID: </b>'+@OrderNo+'<br><br>'
			SET @Body=@Body+'<table cellpadding=''0'' border=''0''  cellspacing=''0'' width=800px>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Multek Sites</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>Transferring Site :</td>'
			SET @Body=@Body+' <td width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT TransferingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td  width=''200px''>Receiving Site :</td>'
			SET @Body=@Body+'	<td  align=LEFT width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT ReceivingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Transferring Site Owner :</td>'
			SET @Body=@Body+' <td >'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td >Receiving Site Owner :</td>'
			SET @Body=@Body+' <td>'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+' </tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+' <td height=25PX colspan=4></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Product</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Part Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT PartNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Revision Number :</td>'
			SET @Body=@Body+'	<td>'+(SELECT RevisionNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Tool Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT ToolNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'                           
			SET @Body=@Body+'	<td >Customer CEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerCEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Customer OEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerOEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td  >Delivery Date :</td>'
			SET @Body=@Body+'	<td align=''left''>'+CONVERT(VARCHAR(10),(SELECT DeliveryDate FROM PT_Order WHERE OrderNo=@OrderNo),120)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'	<td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Customer Approval :</td>'
			SET @Body=@Body+'	<td colspan=''3'' >'+(CASE WHEN (SELECT CustomerApprove FROM PT_Order WHERE OrderNo=@OrderNo)=1 THEN 'Yes' ELSE 'No' END)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject='New Order '+@OrderNo+' was created.'

		END
	IF @Option='Update Order'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (SELECT AutoID FROM PT_Department WHERE CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0)
				AND Enable=1
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
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' updated the order . The following is the newest detail . <br><br>'
			SET @Body=@Body+'<b>Order ID: </b>'+@OrderNo+'<br><br>'
			SET @Body=@Body+'<table cellpadding=''0'' border=''0''  cellspacing=''0'' width=800px>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Multek Sites</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>Transferring Site :</td>'
			SET @Body=@Body+' <td width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT TransferingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td  width=''200px''>Receiving Site :</td>'
			SET @Body=@Body+'	<td  align=LEFT width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT ReceivingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Transferring Site Owner :</td>'
			SET @Body=@Body+' <td >'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td >Receiving Site Owner :</td>'
			SET @Body=@Body+' <td>'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+' </tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+' <td height=25PX colspan=4></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Product</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Part Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT PartNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Revision Number :</td>'
			SET @Body=@Body+'	<td>'+(SELECT RevisionNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Tool Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT ToolNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'                           
			SET @Body=@Body+'	<td >Customer CEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerCEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Customer OEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerOEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td  >Delivery Date :</td>'
			SET @Body=@Body+'	<td align=''left''>'+CONVERT(VARCHAR(10),(SELECT DeliveryDate FROM PT_Order WHERE OrderNo=@OrderNo),120)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'	<td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Customer Approval :</td>'
			SET @Body=@Body+'	<td colspan=''3'' >'+(CASE WHEN (SELECT CustomerApprove FROM PT_Order WHERE OrderNo=@OrderNo)=1 THEN 'Yes' ELSE 'No' END)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject=@OrderNo+' was updated.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Delete Order'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (SELECT AutoID FROM PT_Department WHERE CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0)
				AND Enable=1
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
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' deleted the order . The following is the detail . <br><br>'
			SET @Body=@Body+'<b>Order ID: </b>'+@OrderNo+'<br><br>'
			SET @Body=@Body+'<table cellpadding=''0'' border=''0''  cellspacing=''0'' width=800px>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Multek Sites</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>Transferring Site :</td>'
			SET @Body=@Body+' <td width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT TransferingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td  width=''200px''>Receiving Site :</td>'
			SET @Body=@Body+'	<td  align=LEFT width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT ReceivingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Transferring Site Owner :</td>'
			SET @Body=@Body+' <td >'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td >Receiving Site Owner :</td>'
			SET @Body=@Body+' <td>'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+' </tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+' <td height=25PX colspan=4></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Product</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Part Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT PartNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Revision Number :</td>'
			SET @Body=@Body+'	<td>'+(SELECT RevisionNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Tool Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT ToolNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'                           
			SET @Body=@Body+'	<td >Customer CEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerCEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Customer OEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerOEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td  >Delivery Date :</td>'
			SET @Body=@Body+'	<td align=''left''>'+CONVERT(VARCHAR(10),(SELECT DeliveryDate FROM PT_Order WHERE OrderNo=@OrderNo),120)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'	<td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Customer Approval :</td>'
			SET @Body=@Body+'	<td colspan=''3'' >'+(CASE WHEN (SELECT CustomerApprove FROM PT_Order WHERE OrderNo=@OrderNo)=1 THEN 'Yes' ELSE 'No' END)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject=@OrderNo+' was deleted.'
				
			SET @To=''
			SET @Cc=''
	
		END
	IF @Option='Update Board'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (SELECT AutoID FROM PT_Department WHERE CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0)
				AND Enable=1
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
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' updated the board . The following is the newest detail . <br><br>'
			SET @Body=@Body+'<b>Order ID: </b>'+@OrderNo+'<br><br>'
			SET @Body=@Body+'<table cellpadding=''0'' border=''0''  cellspacing=''0'' width=800px>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=5><b>Golden board(s) (At least one should be sent)</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>Shipped?</td>'
			SET @Body=@Body+'	<td   width=''200px'' COLSPAN=4>'+(SELECT (CASE GoldenBoardShipment WHEN 1 THEN 'Yes' WHEN 2 THEN 'No' ELSE 'Undefined' END) FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>If yes,shipped</td>'
			SET @Body=@Body+'	<td   width=''200px''>Quantity :</td>'
			SET @Body=@Body+'	<td width=''200px''>' +(SELECT ISNULL(CONVERT(VARCHAR(50),GoldenBoardQuantity),'') FROM PT_Order WHERE OrderNo=@OrderNo)+' unit</td>'
			SET @Body=@Body+'	<td  width=''200px''>When :</td>'
			SET @Body=@Body+'	<td  align=LEFT width=''200px''>'+(SELECT ISNULL(CONVERT(VARCHAR(20),GoldenBoardWhen,120),'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   ></td>'
			SET @Body=@Body+'	<td   >AWB # :</td>'
			SET @Body=@Body+'	<td >'+(SELECT ISNULL(GoldenBoardAWB,'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'	<td >By Whom :</td>'
			SET @Body=@Body+'	<td>'+(SELECT ISNULL(GoldenBoardByWhom,'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' </tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td >If no,why?</td>'
			SET @Body=@Body+'	<td	COLSPAN=4>' +(SELECT ISNULL(GoldenBoardComment,'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+' <td height=25PX colspan=5></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=5><b>Rejected Board(s) (At least ten to do analysis) </b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>Shipped?</td>'
			SET @Body=@Body+'	<td   width=''200px'' COLSPAN=4>'+(SELECT (CASE RejectedBoardShipment WHEN 1 THEN 'Yes' WHEN 2 THEN 'No' ELSE 'Undefined' END) FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>If yes,shipped</td>'
			SET @Body=@Body+'	<td   width=''200px''>Quantity :</td>'
			SET @Body=@Body+'	<td width=''200px''>' +(SELECT ISNULL(CONVERT(VARCHAR(50),RejectedBoardQuantity),'') FROM PT_Order WHERE OrderNo=@OrderNo)+' unit</td>'
			SET @Body=@Body+'	<td  width=''200px''>When :</td>'
			SET @Body=@Body+'	<td  align=LEFT width=''200px''>'+(SELECT ISNULL(CONVERT(VARCHAR(20),RejectedBoardWhen,120),'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   ></td>'
			SET @Body=@Body+'	<td   >AWB # :</td>'
			SET @Body=@Body+'	<td >'+(SELECT ISNULL(RejectedBoardAWB,'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'	<td >By Whom :</td>'
			SET @Body=@Body+'	<td>'+(SELECT ISNULL(RejectedBoardByWhom,'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' </tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td >If no,why?</td>'
			SET @Body=@Body+'	<td	COLSPAN=4>' +(SELECT ISNULL(RejectedBoardComment,'') FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject=@OrderNo+' board was updated .'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Close Order'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (SELECT AutoID FROM PT_Department WHERE CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0)
				AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' closed the order . The following is the detail . Thank you very much for your collaboration!<br><br>'
			SET @Body=@Body+'<b>Order ID: </b>'+@OrderNo+'<br><br>'
			SET @Body=@Body+'<table cellpadding=''0'' border=''0''  cellspacing=''0'' width=800px>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Multek Sites</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   width=''200px''>Transferring Site :</td>'
			SET @Body=@Body+' <td width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT TransferingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td  width=''200px''>Receiving Site :</td>'
			SET @Body=@Body+'	<td  align=LEFT width=''200px''>'+(SELECT Name FROM PT_Location WHERE AutoID=(SELECT ReceivingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Transferring Site Owner :</td>'
			SET @Body=@Body+' <td >'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+'	<td >Receiving Site Owner :</td>'
			SET @Body=@Body+' <td>'+(SELECT BDM+'('+UserID+')'FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+'</td>'
			SET @Body=@Body+' </tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+' <td height=25PX colspan=4></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td colspan=4><b>Product</b><hr size=''3'' style=''background-color: #003366'' /></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Part Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT PartNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Revision Number :</td>'
			SET @Body=@Body+'	<td>'+(SELECT RevisionNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td   >Tool Number :</td>'
			SET @Body=@Body+' <td>'+(SELECT ToolNumber FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'                           
			SET @Body=@Body+'	<td >Customer CEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerCEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+' <td >Customer OEM :</td>'
			SET @Body=@Body+' <td>'+(SELECT CustomerOEM FROM PT_Order WHERE OrderNo=@OrderNo)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr >'
			SET @Body=@Body+'	<td  >Delivery Date :</td>'
			SET @Body=@Body+'	<td align=''left''>'+CONVERT(VARCHAR(10),(SELECT DeliveryDate FROM PT_Order WHERE OrderNo=@OrderNo),120)+'</td>'
			SET @Body=@Body+' <td></td>'
			SET @Body=@Body+'	<td></td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'<tr>'
			SET @Body=@Body+'	<td  >Customer Approval :</td>'
			SET @Body=@Body+'	<td colspan=''3'' >'+(CASE WHEN (SELECT CustomerApprove FROM PT_Order WHERE OrderNo=@OrderNo)=1 THEN 'Yes' ELSE 'No' END)+'</td>'
			SET @Body=@Body+'</tr>'
			SET @Body=@Body+'</table>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject=@OrderNo+' was closed !'

		END
	IF @Option='Update Check List Item Avaliable'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (SELECT AutoID FROM PT_Department WHERE CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0)
				AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' changed the check list item avaliablity . Order ID is '+@OrderNo+' . The check list item is '

			SET @Body=@Body+(SELECT c.Name
								FROM PT_Order_CheckList b,PT_CheckList c
								WHERE b.CheckListAutoID=c.AutoID
									AND b.CheckListAutoID=@OrderCheckListAutoID
									AND b.OrderNo=@OrderNo
								GROUP BY c.Name
							)
			SET @Body=@Body+'. Now it is '
			SET @Body=@Body+(SELECT (CASE WHEN NotAvaliable=1 THEN 'NOT AVALIABLE' ELSE 'AVALIABLE' END) FROM PT_Order_CheckList WHERE CheckListAutoID=@OrderCheckListAutoID AND OrderNo=@OrderNo)
			SET @Body=@Body+'. <br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject='Changed check list item avaliablity for '+@OrderNo+'.'

			SET @To=''
			SET @Cc=''

		END

	IF @Option='Upload File'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (
										SELECT AutoID
										FROM PT_Department
										WHERE AutoID IN (
															SELECT DepartmentAutoID
															FROM PT_Department_CheckList 
															WHERE CheckListAutoID=(
																					SELECT b.CheckListAutoID
																					FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
																					WHERE a.OrderCheckListAutoID=b.AutoID
																						AND a.AutoID=@OrderCheckListDetailAutoID
																					GROUP BY b.CheckListAutoID
																				   )
																AND Enable=1
														 )
											AND LocationAutoID=(
																SELECT ReceivingDepartmentAutoID
																FROM PT_Order
																WHERE OrderNo=@OrderNo
																)
									   )
					AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' uploaded a file . Order ID is '+@OrderNo+' . The check list item is '
			SET @Body=@Body+(SELECT c.Name
								FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b,PT_CheckList c
								WHERE a.OrderCheckListAutoID=b.AutoID
									AND b.CheckListAutoID=c.AutoID
									AND a.AutoID=@OrderCheckListDetailAutoID
								GROUP BY c.Name
							)
			SET @Body=@Body+'. The file name is '
			SET @Body=@Body+(SELECT Attachment FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID)
			SET @Body=@Body+'. Please check it ASAP.<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject='A new file of '+@OrderNo+' was uploaded.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Download File'
		BEGIN
			--Send Mail
			SET @To=''
			SET @To=@To+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferUserID FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID) AND Enable=1)

			SET @Cc=''
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' downloaded a file . Order ID is '+@OrderNo+' . The check list item is '
			SET @Body=@Body+(SELECT c.Name
								FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b,PT_CheckList c
								WHERE a.OrderCheckListAutoID=b.AutoID
									AND b.CheckListAutoID=c.AutoID
									AND a.AutoID=@OrderCheckListDetailAutoID
								GROUP BY c.Name
							)
			SET @Body=@Body+'. The file name is '
			SET @Body=@Body+(SELECT Attachment FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID)
			SET @Body=@Body+'. <br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject='A file of '+@OrderNo+'  was downloaded.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Delete File'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (
										SELECT AutoID
										FROM PT_Department
										WHERE AutoID IN (
															SELECT DepartmentAutoID
															FROM PT_Department_CheckList 
															WHERE CheckListAutoID=(
																					SELECT b.CheckListAutoID
																					FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
																					WHERE a.OrderCheckListAutoID=b.AutoID
																						AND a.AutoID=@OrderCheckListDetailAutoID
																					GROUP BY b.CheckListAutoID
																				   )
																AND Enable=1
														 )
											AND LocationAutoID=(
																SELECT ReceivingDepartmentAutoID
																FROM PT_Order
																WHERE OrderNo=@OrderNo
																)
									   )
						AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=@OperatorUserID AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),GETDATE(),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=@OperatorUserID)
			SET @Body=@Body+' deleted a file . Order ID is '+@OrderNo+' . The check list item is '
			SET @Body=@Body+(SELECT c.Name
								FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b,PT_CheckList c
								WHERE a.OrderCheckListAutoID=b.AutoID
									AND b.CheckListAutoID=c.AutoID
									AND a.AutoID=@OrderCheckListDetailAutoID
								GROUP BY c.Name
							)
			SET @Body=@Body+'. The file name is '
			SET @Body=@Body+(SELECT Attachment FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID)
			SET @Body=@Body+'. <br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			SET @Subject='A file of '+@OrderNo +' was deleted.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Need Check File'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (
										SELECT AutoID
										FROM PT_Department
										WHERE AutoID IN (
															SELECT DepartmentAutoID
															FROM PT_Department_CheckList 
															WHERE CheckListAutoID=(
																					SELECT b.CheckListAutoID
																					FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
																					WHERE a.OrderCheckListAutoID=b.AutoID
																						AND a.AutoID=@OrderCheckListDetailAutoID
																					GROUP BY b.CheckListAutoID
																				   )
																AND Enable=1
														 )
											AND LocationAutoID=(
																SELECT ReceivingDepartmentAutoID
																FROM PT_Order
																WHERE OrderNo=@OrderNo
																)
									   )
					 AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferUserID FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),(SELECT TransferDate FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT  TransferUserID FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID))
			SET @Body=@Body+' uploaded a file . Order ID is '+@OrderNo+' . The check list item is '
			SET @Body=@Body+(SELECT c.Name
								FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b,PT_CheckList c
								WHERE a.OrderCheckListAutoID=b.AutoID
									AND b.CheckListAutoID=c.AutoID
									AND a.AutoID=@OrderCheckListDetailAutoID
								GROUP BY c.Name
							)
			SET @Body=@Body+'. The file name is '
			SET @Body=@Body+(SELECT Attachment FROM PT_Order_CheckList_Detail WHERE AutoID=@OrderCheckListDetailAutoID)
			SET @Body=@Body+'. Please check it ASAP.<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?

			set @subject='Please download file for '+@OrderNo+'.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Need Upload File'
		BEGIN
			--Send Mail
			SET @To=''
			DECLARE User_C CURSOR FOR
			SELECT Email
			FROM PT_Users
			WHERE DepartmentAutoID IN (
										SELECT AutoID
										FROM PT_Department
										WHERE AutoID IN (
															SELECT DepartmentAutoID
															FROM PT_Department_CheckList 
															WHERE CheckListAutoID=@OrderCheckListAutoID
																AND Enable=1
														 )
											AND CHARINDEX(','+CONVERT(VARCHAR(10),AutoID)+',', (
																									SELECT TransferingInvolvedDepartmentAutoID
																									FROM PT_Order
																									WHERE OrderNo=@OrderNo
																								)
														 )>0
									   )
					 AND Enable=1
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
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=(SELECT CreatedUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=@Cc+';'+(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+'Please upload files ASAP.'
			SET @Body=@Body+' Order ID is '+@OrderNo+' . The check list item is '
			SET @Body=@Body+(SELECT c.Name
								FROM PT_CheckList c
								WHERE c.AutoID=@OrderCheckListAutoID
								GROUP BY c.Name
							)

			SET @Body=@Body+'.<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?
			
			IF @OrderNo='GERCH5100500001'
				BEGIN
					SET @To=''
				END

			set @subject='Please upload file for ' +@OrderNo+'.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='ReceivingSiteOwnerNeedApprove'
		BEGIN
			--Send Mail
			SET @To=''
			SET @To=(SELECT Email FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=''

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+',<br><br>'
			SET @Body=@Body+'The order should be confirmed.'
			SET @Body=@Body+' Order ID is '+@OrderNo+' . Please process it ASAP. '
			SET @Body=@Body+'<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?

			set @subject='Please confirm order '+@OrderNo+''

			SET @To=''
			SET @Cc=''

		END
	IF @Option='TransferringSiteOwnerNeedApprove'
		BEGIN
			--Send Mail
			SET @To=''
			SET @To=(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=''

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+',<br><br>'
			SET @Body=@Body+'The order should be confirmed.'
			SET @Body=@Body+' Order ID is '+@OrderNo+' . Please process it ASAP. '
			SET @Body=@Body+'<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?

			set @subject='Please confirm order '+@OrderNo+''

			SET @To=''
			SET @Cc=''

		END
	IF @Option='NeedClose'
		BEGIN
			--Send Mail
			SET @To=''
			SET @To=(SELECT Email FROM PT_Users WHERE UserID=(SELECT CreatedUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=''
			SET @Cc=@Cc+(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT CreatedUserID FROM PT_Order WHERE OrderNo=@OrderNo))+',<br><br>'
			SET @Body=@Body+'The order should be closed.'
			SET @Body=@Body+' Order ID is '+@OrderNo+' . Please process it ASAP. '
			SET @Body=@Body+'<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?

			set @subject='Please close order '+@OrderNo+''

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Receiving Site Owner Approve'
		BEGIN
			--Send Mail
			SET @To=''
			SET @To=(SELECT Email FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=''

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))+',<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),(SELECT ReceivingSiteOwnerApproveDate FROM PT_Order WHERE OrderNo=@OrderNo),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT  ReceivingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))
			SET @Body=@Body+' changed receiving site owner confirm . Order ID is '+@OrderNo+' . Now, receiving site owner '
			SET @Body=@Body+(SELECT (CASE ReceivingSiteOwnerApprove WHEN 1 THEN 'confirms all receiving data is OK!' ELSE ' does not confirm all receiving data is OK!' END) FROM PT_Order WHERE OrderNo=@OrderNo)
			SET @Body=@Body+(SELECT (CASE ReceivingSiteOwnerApprove WHEN 1 THEN 'Now,you can confirm all transferring data is OK!' ELSE '' END) FROM PT_Order WHERE OrderNo=@OrderNo)
			SET @Body=@Body+'.<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?

			set @subject='Receiving Site Owners Confirmed '+@OrderNo+'.'

			SET @To=''
			SET @Cc=''

		END
	IF @Option='Transferring Site Owner Approve'
		BEGIN
			--Send Mail
			SET @To=''
			SET @To=(SELECT Email FROM PT_Users WHERE UserID=(SELECT CreatedUserID FROM PT_Order WHERE OrderNo=@OrderNo) AND Enable=1)
			SET @Cc=''

			SET @Bcc=''

			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<html>'
			SET @Body=@Body+'<body style=''font-size: 8pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT CreatedUserID FROM PT_Order WHERE OrderNo=@OrderNo))+',<br><br>'
			SET @Body=@Body+'In '+CONVERT(VARCHAR(20),(SELECT TransferringSiteOwnerApproveDate FROM PT_Order WHERE OrderNo=@OrderNo),120)+' , '+(SELECT BDM+'('+UserID+')' FROM PT_Users WHERE UserID=(SELECT  TransferingSiteOwnerUserID FROM PT_Order WHERE OrderNo=@OrderNo))
			SET @Body=@Body+' changed transferring site owner confirm . Order ID is '+@OrderNo+' . Now, transferring site owner '
			SET @Body=@Body+(SELECT (CASE TransferringSiteOwnerApprove WHEN 1 THEN 'confirms all transferring data is OK!' ELSE ' does not confirm all transferring data is OK!' END) FROM PT_Order WHERE OrderNo=@OrderNo)
			SET @Body=@Body+(SELECT (CASE TransferringSiteOwnerApprove WHEN 1 THEN '.Now, you can close the order.' ELSE '' END) FROM PT_Order WHERE OrderNo=@OrderNo)+'<br>'
			SET @Body=@Body+'<br>You can click <a href=http://hkgnt111.asia.ad.flextronics.com/PT>here</a> to access product transfer track. <br><br>Regards,<br><br>System Administration'
			SET @Body=@Body+'</body></html>'

			--SET @subject='Please check the file  '+@OrderNo+'.'   why can't send mail with the subject? flex's rules?

			set @subject='Transferring Site Owners Confirmed '+@OrderNo+'.'

			SET @To=''
			SET @Cc=''

		END

		--SET @TO=''
		--SET @CC=''
		SET @BCC='PETER.XU@HK.MULTEK.COM;JIANGUANG.ZHANG@HK.MULTEK.COM;JOE.CHENG@HK.MULTEK.COM'

		SET @Subject='PT Alert mail '+@Code+': '+@Subject
		EXECUTE sp_Send_Mail @TO=@To,@Cc=@Cc,@Bcc=@Bcc,@Subject=@Subject,@Body=@Body

END
GO

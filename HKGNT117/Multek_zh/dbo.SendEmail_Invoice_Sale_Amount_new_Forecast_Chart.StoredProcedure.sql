USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SendEmail_Invoice_Sale_Amount_new_Forecast_Chart]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SendEmail_Invoice_Sale_Amount_new_Forecast_Chart]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-------------------------------------------------------------------------------------------------
		DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@ID INT,@LOOP INT,@Plant NVARCHAR(4),@Sign NVARCHAR(30)
	
		SET @To			= ''
		SET	@Cc			= ''
		SET @Bcc		= ''
		SET @Subject	= ''
		SET @Body		= ''
		SET	@Email		= ''





		--图的变量
		DECLARE	@charWidth NVARCHAR(10),@chartForecastColor NVARCHAR(10),@chartActvieColor NVARCHAR(10)
		DECLARE	@chart_2F_Forecast	NVARCHAR(10),@chart_2F_actual NVARCHAR(10),@chart_2F_blue NVARCHAR(10),@chart_2F_red NVARCHAR(10)
		DECLARE	@chart_b1_Forecast	NVARCHAR(10),@chart_b1_actual NVARCHAR(10),@chart_b1_blue NVARCHAR(10),@chart_b1_red NVARCHAR(10)
		DECLARE	@chart_b3_Forecast	NVARCHAR(10),@chart_b3_actual NVARCHAR(10),@chart_b3_blue NVARCHAR(10),@chart_b3_red NVARCHAR(10)
		DECLARE	@chart_b4_Forecast	NVARCHAR(10),@chart_b4_actual NVARCHAR(10),@chart_b4_blue NVARCHAR(10),@chart_b4_red NVARCHAR(10)
		DECLARE	@chart_b5_Forecast	NVARCHAR(10),@chart_b5_actual NVARCHAR(10),@chart_b5_blue NVARCHAR(10),@chart_b5_red NVARCHAR(10)
		DECLARE	@chart_vvi_Forecast	NVARCHAR(10),@chart_vvi_actual NVARCHAR(10),@chart_vvi_blue NVARCHAR(10),@chart_vvi_red NVARCHAR(10)
		DECLARE	@chart_rigid_Forecast	NVARCHAR(10),@chart_rigid_actual NVARCHAR(10),@chart_rigid_blue NVARCHAR(10),@chart_rigid_red NVARCHAR(10)
		DECLARE	@chart_total_Forecast	NVARCHAR(10),@chart_total_actual NVARCHAR(10),@chart_total_blue NVARCHAR(10),@chart_total_red NVARCHAR(10)

		SET @charWidth = '30px'
		SET @chartForecastColor = 'blue'
		SET @chartActvieColor = 'red'

		SET @chart_2F_Forecast = '$5M'
		SET @chart_2F_actual = '$2M'
		SET @chart_2F_red = '36px'
		SET @chart_2F_blue = '18px'

		SET @chart_b1_Forecast = '$7M'
		SET @chart_b1_actual = '$2M'
		SET @chart_b1_red = '48px'
		SET @chart_b1_blue = '15px'

		SET @chart_b3_Forecast = '$7M'
		SET @chart_b3_actual = '$3M'
		SET @chart_b3_red = '51px'
		SET @chart_b3_blue = '20px'

		SET @chart_b4_Forecast = '$3M'
		SET @chart_b4_actual = '$0.9M'
		SET @chart_b4_red = '20px'
		SET @chart_b4_blue = '6px'

		SET @chart_b5_Forecast = '$14M'
		SET @chart_b5_actual = '$5M'
		SET @chart_b5_red = '94px'
		SET @chart_b5_blue = '34px'

		SET @chart_vvi_Forecast = '$2M'
		SET @chart_vvi_actual = '$0.8M'
		SET @chart_vvi_red = '16px'
		SET @chart_vvi_blue = '5px'

		SET @chart_rigid_Forecast = '$34M'
		SET @chart_rigid_actual = '$12M'
		SET @chart_rigid_red = '230px'
		SET @chart_rigid_blue = '82px'

		SET @chart_total_Forecast = '$40M'
		SET @chart_total_actual = '$15M'
		SET @chart_total_red = '267px'
		SET @chart_total_blue = '101px'

	--邮件Chart部分
		SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<HTML>'
			SET @Body=@Body+'<body style=''font-size: 10pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
			SET @Body=@Body+'Dear All,<br><br>'
			SET @Body=@Body+''
			SET @Body=@Body+'Cut Off Time : <br><br>'
			SET @Body=@Body+'The current period PTD sales invoice as:  <br><br>'
			SET @Body=@Body+'<table width= ''100%''>'
			SET @Body=@Body+'  <tr>'
			SET @Body=@Body+'    <td align=''center''>'
			SET @Body=@Body+'		<table width = ''70%'' cellpadding=''0'' border=''0''  cellspacing=''0'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'

			--标题 FY2014 / P05 PTD at 20:00  Sales Invoiced Amount is: $15,291K
			SET @Body=@Body+'			<tr>'
			SET @Body=@Body+'				<td colspan=''18'' align = ''center''>'
			SET @Body=@Body+'					<b><div>FY2014 / P05 PTD at 20:00  Sales Invoiced Amount is: $15,291K</div></b>'
			SET @Body=@Body+'				</td>'
			SET @Body=@Body+'			</tr>'
			SET @Body=@Body+'			<tr>'
			-- 分割线
			SET @Body=@Body+'				<td colspan=''18''>'
			SET @Body=@Body+'					<hr/>'
			SET @Body=@Body+'				</td>'
			SET @Body=@Body+'			</tr>'
			SET @Body=@Body+'			<tr>'
			SET @Body=@Body+'				<td colspan=''18''>'
			SET @Body=@Body+'				</td>'
			SET @Body=@Body+'			</tr>'
			-- 图例
			SET @Body=@Body+'			<tr>'
			SET @Body=@Body+'				<td align=''right''><div style= ''background-color :red; width:30px; height:10px''/></td>'
			SET @Body=@Body+'				<td colspan=''17'' align=''left'' nowrap=''nowrap''>Finance Forecast</td>'
			SET @Body=@Body+'			</tr>'
			SET @Body=@Body+'			<tr>'
			SET @Body=@Body+'				<td align=''right''><div style= ''background-color :blue; width:30px; height:10px''/></td>'
			SET @Body=@Body+'				<td colspan=''17'' align=''left'' nowrap=''nowrap''>Sales Amount</td>'
			SET @Body=@Body+'			</tr>'
			-- 开始画图
			SET @Body=@Body+'			<tr>'
			SET @Body=@Body+'				<td></td>'
				--2F
			--SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_2F_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_2F_red+';''></div></td>'
			--SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_2F_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_2F_blue+';''></div></td>'

				--2F
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom'' heigh=''500px''><div style=''background-color:blue ; width:30px; height:100px; z-index:1;left:0px;''>&nbsp;</div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_2F_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_2F_blue+';''></div></td>'
				--b1
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_b1_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_b1_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_b1_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_b1_blue+';''></div></td>'
				--b3
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_b3_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_b3_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_b3_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_b3_blue+';''></div></td>'
				--b4
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_b4_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_b4_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_b4_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_b4_blue+';''></div></td>'
				--b5
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_b5_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_b5_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_b5_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_b5_blue+';''></div></td>'
				--vvi
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_vvi_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_vvi_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_vvi_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_vvi_blue+';''></div></td>'
				--rigid
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_rigid_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_rigid_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_rigid_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_rigid_blue+';''></div></td>'
				--total
			SET @Body=@Body+'				<td align = ''right'' valign=''bottom''><div>'+@chart_total_Forecast+'</div><div style=''background-color:'+@chartForecastColor+' ; width:'+@charWidth+'; height:'+@chart_total_red+';''></div></td>'
			SET @Body=@Body+'				<td align = ''left'' valign=''bottom''><div>'+@chart_total_actual+'</div><div style=''background-color:'+@chartActvieColor+' ; width:'+@charWidth+'; height:'+@chart_total_blue+';''></div></td>'
			SET @Body=@Body+'			</tr>'
			-- 图下面的plant
			SET @Body=@Body+'			<tr>'
			SET @Body=@Body+'				<td style=''border-top:#000000 solid 1px;''></td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>2F</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>B1</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>B3</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>B4</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>B5</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>VVI</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>Rigid</td>'
			SET @Body=@Body+'				<td colspan=''2'' align=''center'' style=''border-top:#000000 solid 1px;''>Total</td>'
			SET @Body=@Body+'				<td style=''border-top:#000000 solid 1px;''></td>'
			SET @Body=@Body+'			</tr>'
			--结束
			SET @Body=@Body+'		</table>'
			SET @Body=@Body+'    </td>'
			SET @Body=@Body+'   </tr>'
			SET @Body=@Body+'<table cellpadding=''0'' border=''0''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
			SET @Body=@Body+'</table>'
			SET @Body=@Body+'</BODY></HTML>'
		-- Header
			SET @Subject = 'sales amount testing!'

			--SET @Body='<div style=''background-color:red;width:100%;height:200px;overflow:auto;font-size:1px;zoom:1''><div><hr style=''background-color:red;height:30px''></div></div>'
	-- SEND EMAIL
		SET @To = 'Rivern.li@hk.multek.com'
		SET @BCC= 'Rivern.li@hk.multek.com'
		SET @CC = ''

		--SET @BCC='Rivern.Li@HK.MULTEK.COM;Peter.xu@hk.multek.com'
		--SET @Cc = 'Robert.Ho@hk.multek.com'

		--IF @IFOK = 'OK'
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

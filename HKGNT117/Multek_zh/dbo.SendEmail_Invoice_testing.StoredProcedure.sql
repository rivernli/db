USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SendEmail_Invoice_testing]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SendEmail_Invoice_testing]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@ID INT,@LOOP INT,@Plant NVARCHAR(4),@Sign NVARCHAR(30)
	
		SET @To			= ''
		SET	@Cc			= ''
		SET @Bcc		= ''
		SET @Subject	= ''
		SET @Body		= ''
		SET	@Email		= ''

		SET @Body=''
			SET @Body='
				<html>
				<head>
					<title>Untitled Page</title>
					   <style type=''text/css''>
							 .home {

							border-left:2px solid #00CCCC; 
							border-right:2px solid #008080; 
							border-top:2px solid #00CCCC; 
							border-bottom:2px solid #008080; 
							background-color: #009999;
							position: absolute;
							z-index: 1;
							bottom: 0;
							left: 20px;
							width: 30px;
							height: 132px 
							}

							.work {
							border-left:2px solid #ff80ff; 
							border-right:2px solid #9a0053; 
							border-top:2px solid #ff80ff; 
							border-bottom:0px none #000; 
							background-color: #e6007c;
							position: absolute;
							z-index: 2;
							bottom: 0;
							left: 35px;
							width: 30px;
							height: 86px;

							}

							.biz {
							border-left:2px solid #b3daff; 
							border-right:2px solid #06f; 
							border-top:2px solid #9cf; 
							border-bottom:0px none #000; 
							background-color: #39f;
							position: absolute;
							z-index: 3;
							bottom: 0;
							left: 50px;
							width: 30px;
							height: 42px;

							}

							.school {
							border-left:2px solid #ffec35; 
							border-right:2px solid #9a8c00; 
							border-top:2px solid #ffec35; 
							border-bottom:0px none #000; 
							background-color: #e6d000;
							position: absolute;
							z-index: 4;
							bottom: 0;
							left: 65px;
							width: 30px;
							height: 36px;
							}
            
						.outline {
						text-align: center;
						visibility: visible;
						margin-right: 5px;
						margin-left: 5px;
						position: relative;
						width: 150px;
						height: 196px;
						float: left;
						border-style: solid;
						border-width: 2px;
						border-color: #5f4a94 #e6e8ff #e6e8ff #5f4a94
						}
            
				.red { background-image: url(redbar.gif);
					  background-repeat: repeat-y;
					  visibility: visible;
					  width: 32px;
					  height: 60px;
					  margin-top: 60px;
					  float: right
					  }
      
					  .title {
				font-size: 10pt;
				color: #000080;
				font-weight: bold;
				margin-top:6px;
				}
					</style>
				</head>
				<body>
				<div class=''outline''>
				<div class=''title''>网民上网地方比例</div>
				<table>
					<tr>
						<td><div class=''home''>&nbsp;</div></td>
						<td><div class=''work''>&nbsp;</div></td>
						<td><div class=''biz''>&nbsp;</div></td>
						<td><div class=''school''>&nbsp;</div></td>
						<td><div class=''red''>&nbsp;</div></td>
					</tr>
				</table>
				</body>
				</html>
			'

			set @body = '<table width=''100%''>
							<tr>
								<td width = ''200px'' heigh = ''200px'' bgcolor=''red''>
								</td>
								<td></td>
							</tr>
							<tr>
								<td width = ''300px'' heigh = ''300px'' bgcolor=''blue''>
								</td>
								<td></td>
							</tr>
							<tr>
								<td width = ''400px'' heigh = ''400px'' bgcolor=''red''>
								</td>
								<td></td>
							</tr>
							<tr>
								<td width = ''500px'' heigh = ''500px'' bgcolor=''blue''>
								</td>
								<td></td>
							</tr>
						</table>
			'
			SET @Body=''
			SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
			SET @Body=@Body+'<HTML xmlns='+'''http://www.w3.org/1999/xhtml'''+'>'
			SET @Body=@Body+'<head>'
			SET @Body =@Body+'
					<style type=''text/css''>
					body{margin:0;padding:0;}
					ul,li,dl,dd,dt,p{margin:0;padding:0;}
					ul,li{list-style:none;}
					/*柱状图样式*/
					.histogram-container{position:relative;margin-left:60px;margin-top:10px;margin-bottom:25px;}
					.histogram-bg-line{border:#999 solid;border-width:0 1px 1px 1px;border-right-color:#eee;overflow:hidden;width:99%;}
					.histogram-bg-line ul{overflow:hidden;border:#eee solid;border-width:1px 0 0 0;}
					.histogram-bg-line li{float:left;width:20%;/*根据.histogram-bg-line下的ul里面li标签的个数来控制比例*/overflow:hidden;}
					.histogram-bg-line li div{border-right:1px #eee solid;}
					.histogram-content{position:absolute;left:0px;top:0;width:99%;height:100%;}
					.histogram-content ul{height:100%;}
					.histogram-content li{float:left;height:100%;width:20%;/*根据直方图的个数来控制这个width比例*/text-align:center;position:relative;}
					.histogram-box{position:relative;display:inline-block;height:100%;width:20px;}
					.histogram-content li a{position:absolute;bottom:0;right:0;display:block;width:20px;}
					.histogram-content li .name{position:absolute;bottom:-20px;left:0px;white-space:nowrap;display:inline-block;width:100%;font-size:12px;}
					.histogram-y{position:absolute;left:-60px;top:-10px;font:12px/1.8 verdana,arial;}
					.histogram-y li{text-align:right;width:55px;padding-right:5px;color:#333;}
					.histogram-bg-line li div,.histogram-y li{height:60px;/*控制单元格的高度及百分比的高度，使百分数与线条对齐*/}
					</style>
					</head>
					<body>
				<div class=''histogram-container'' id=''histogram-container''>
					<!--背景方格-->
					<div class=''histogram-bg-line''>
						<ul>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
						</ul>
						<ul>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
						</ul>
						<ul>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
						</ul>
						<ul>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
						</ul>
						<ul>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
							<li><div></div></li>
						</ul>
					</div>
					<!--柱状条-->
					<div class=''histogram-content''>
						<ul>
							<li>
								<span class=''histogram-box''><a style=''height:20%;background:#2f87d9;'' title=''20%''></a></span>
								<span class=''name''>百度一下</span>
							</li>
							<li>
								<span class=''histogram-box''><a style=''height:40%;background:green;'' title=''40%''></a></span>
								<span class=''name''>夜深风竹敲秋韵</span>
							</li>
							<li>
								<span class=''histogram-box''><a style=''height:50%;background:orange;'' title=''50%''></a></span>
								<span class=''name''>腾讯</span>
							</li>
							<li>
								<span class=''histogram-box''><a style=''height:80%;background:gray;'' title=''80%''></a></span>
								<span class=''name''>小虾虎鱼一下</span>
							</li>
						</ul>
					</div>
					<!--百分比 y轴-->
					<div class=''histogram-y''>
						<ul>
							<li>100%</li>
							<li>80%</li>
							<li>60%</li>
							<li>40%</li>
							<li>20%</li>
							<li>0%</li>
						</ul>
					</div>
				</div>
				<canvas id="can1" width="800" height="400">

    </canvas>
			'
			SET @Body=@Body+'</body>'
			SET @Body=@Body+'</HTML>'

	-- Header
		SET @Subject = 'sales amount testing!'

			--SET @Body='<div style=''background-color:red;width:100%;height:200px;overflow:auto;font-size:1px;zoom:1''><div><hr style=''background-color:red;height:30px''></div></div>'
	-- SEND EMAIL
		SET @To = 'Rivern.li@hk.multek.com'
		SET @BCC= 'Rivern.li@hk.multek.com'
		SET @CC = ''

		--set @body = '''http://chart.apis.google.com/chart?cht=p3&chd=t:60,40&chs=250x100&chl=Hello|World'''

    -- Insert statements for procedure here

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

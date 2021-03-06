USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_FiscalPeriodRangeMonthAmount]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_FiscalPeriodRangeMonthAmount]
	-- Add the parameters for the stored procedure here
	@Year INT,
	@UserID VARCHAR(50),
	@Type VARCHAR(50),
	@ReportCode VARCHAR(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @ReturnTable TABLE (Period VARCHAR(10),Display VARCHAR(MAX))
    DECLARE @RevenueAmount INT,@Display VARCHAR(MAX),@MenuID VARCHAR(50),@Plant VARCHAR(50),@i INT,@Period VARCHAR(50),@NowPeriod INT

	SET @NowPeriod=(SELECT FiscalPeriod FROM Calendar WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))

	SET @i=1
    WHILE @i<=12
		BEGIN
			SET @Display=''
			--B1
			SET @Plant='B1'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000100003'
						   WHEN 'Shipment' THEN '000030000100003'
						   WHEN 'Outbound' THEN '000040000100003'
						   WHEN 'HubIn' THEN '000050000100003'
						   WHEN 'RMA' THEN '000060000100003'
						   WHEN 'Scrap' THEN '0000700001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B2F
			SET @Plant='B2F'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000200003'
						   WHEN 'Shipment' THEN '000030000200003'
						   WHEN 'Outbound' THEN '000040000200003'
						   WHEN 'HubIn' THEN '000050000200003'
						   WHEN 'RMA' THEN '000060000200003'
						   WHEN 'Scrap' THEN '0000700002'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B3
			SET @Plant='B3'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000300003'
						   WHEN 'Shipment' THEN '000030000300003'
						   WHEN 'Outbound' THEN '000040000300003'
						   WHEN 'HubIn' THEN '000050000300003'
						   WHEN 'RMA' THEN '000060000300003'
						   WHEN 'Scrap' THEN '0000700003'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B4
			SET @Plant='B4'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000400003'
						   WHEN 'Shipment' THEN '000030000400003'
						   WHEN 'Outbound' THEN '000040000400003'
						   WHEN 'HubIn' THEN '000050000400003'
						   WHEN 'RMA' THEN '000060000400003'
						   WHEN 'Scrap' THEN '0000700004'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B5
			SET @Plant='B5'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000500003'
						   WHEN 'Shipment' THEN '000030000500003'
						   WHEN 'Outbound' THEN '000040000500003'
						   WHEN 'HubIn' THEN '000050000500003'
						   WHEN 'RMA' THEN '000060000500003'
						   WHEN 'Scrap' THEN '0000700005'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--VVI
			SET @Plant='VVI'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000600003'
						   WHEN 'Shipment' THEN '000030000600003'
						   WHEN 'Outbound' THEN '000040000600003'
						   WHEN 'HubIn' THEN '000050000600003'
						   WHEN 'RMA' THEN '000060000600003'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--ZhuHai
			SET @Plant=''
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000700003'
						   WHEN 'Shipment' THEN '000030000700003'
						   WHEN 'Outbound' THEN '000040000700003'
						   WHEN 'HubIn' THEN '000050000700003'
						   WHEN 'RMA' THEN '000060000700003'
						   WHEN 'Scrap' THEN '0000700007'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=dbo.DistributionReport_sp_Get_Period_Amount(@Year,@i,@ReportCode,@Type,@Plant)
					SET @Display=@Display+'<tr><td>'+'ZhuHai'+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END

			SET @Period=( 
							CASE @i WHEN 1 THEN 'Apr(P1)'
									WHEN 2 THEN 'May(P2)'
									WHEN 3 THEN 'Jun(P3)'
									WHEN 4 THEN 'Jul(P4)'
									WHEN 5 THEN 'Aug(P5)'
									WHEN 6 THEN 'Sep(P6)'
									WHEN 7 THEN 'Oct(P7)'
									WHEN 8 THEN 'Nov(P8)'
									WHEN 9 THEN 'Dec(P9)'
									WHEN 10 THEN 'Jan(P10)'
									WHEN 11 THEN 'Feb(P11)'
									WHEN 12 THEN 'Mar(P12)'
							ELSE ''
							END
						)
			IF @i>@NowPeriod
				BEGIN
					SET @Display=REPLACE(@Display,'0','')
				END
				
			SET @Period=(CASE WHEN @i=@NowPeriod THEN 'PToday' ELSE @Period END)

			IF @Display<>'' AND @Period='PToday'
				BEGIN
					SET @Display='<table style='+'"'+'background-image: url('+''''+'../Images/bg_blue_White.png'+''''+');'+'"'+' width=100% cellpadding=0 cellspacing=0 >'+@Display+'</table>'
				END
			IF @Display<>'' AND @Period<>'PToday'
				BEGIN
					SET @Display='<table width=100% cellpadding=0 cellspacing=0>'+@Display+'</table>'
				END

			INSERT INTO @ReturnTable (Period,Display)
				VALUES(@Period,@Display)
			SET @i=@i+1
		END
	SELECT * FROM @ReturnTable
END
GO

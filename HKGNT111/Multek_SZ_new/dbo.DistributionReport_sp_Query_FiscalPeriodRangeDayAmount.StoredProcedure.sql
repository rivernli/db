USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_FiscalPeriodRangeDayAmount]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_FiscalPeriodRangeDayAmount]
	-- Add the parameters for the stored procedure here
	@Year INT,
	@Period VARCHAR(10),
	@UserID VARCHAR(50),
	@Type VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @ReturnTable TABLE (Day VARCHAR(10),Display VARCHAR(MAX))
    DECLARE @DateFrom DATETIME,@DateTo DATETIME ,@Date DATETIME,@RevenueAmount INT,@Display VARCHAR(MAX),@MenuID VARCHAR(50),@Plant VARCHAR(50)
    SET @DateFrom=(
					SELECT  MIN(CONVERT(VARCHAR(10),CalenderDate,120)) 
					FROM Calendar 
					WHERE FiscalYear=@Year 
						AND FiscalPeriod=@Period
				)
	SET @DateTo=(
					SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120))
					FROM Calendar 
					WHERE FiscalYear=@Year 
						AND FiscalPeriod=@Period
				)
	
	SET @Date=@DateFrom
	WHILE @Date<=@DateTo
		BEGIN
			SET @Display=''
			--B1
			SET @Plant='B1'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000100001'
						   WHEN 'Shipment' THEN '000030000100001'
						   WHEN 'Outbound' THEN '000040000100001'
						   WHEN 'HubIn' THEN '000050000100001'
						   WHEN 'RMA' THEN '000060000100001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant=@Plant),0)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B2F
			SET @Plant='B2F'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000200001'
						   WHEN 'Shipment' THEN '000030000200001'
						   WHEN 'Outbound' THEN '000040000200001'
						   WHEN 'HubIn' THEN '000050000200001'
						   WHEN 'RMA' THEN '000060000200001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant=@Plant),0)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B3
			SET @Plant='B3'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000300001'
						   WHEN 'Shipment' THEN '000030000300001'
						   WHEN 'Outbound' THEN '000040000300001'
						   WHEN 'HubIn' THEN '000050000300001'
						   WHEN 'RMA' THEN '000060000300001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant=@Plant),0)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B4
			SET @Plant='B4'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000400001'
						   WHEN 'Shipment' THEN '000030000400001'
						   WHEN 'Outbound' THEN '000040000400001'
						   WHEN 'HubIn' THEN '000050000400001'
						   WHEN 'RMA' THEN '000060000400001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant=@Plant),0)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--B5
			SET @Plant='B5'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000500001'
						   WHEN 'Shipment' THEN '000030000500001'
						   WHEN 'Outbound' THEN '000040000500001'
						   WHEN 'HubIn' THEN '000050000500001'
						   WHEN 'RMA' THEN '000060000500001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant=@Plant),0)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--VVI
			SET @Plant='VVI'
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000600001'
						   WHEN 'Shipment' THEN '000030000600001'
						   WHEN 'Outbound' THEN '000040000600001'
						   WHEN 'HubIn' THEN '000050000600001'
						   WHEN 'RMA' THEN '000060000600001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant='HK'),0)
					SET @Display=@Display+'<tr><td>'+@Plant+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END
			--ZhuHai
			SET @Plant=''
			SET @MenuID=(
				CASE @Type WHEN 'Output' THEN '000020000700001'
						   WHEN 'Shipment' THEN '000030000700001'
						   WHEN 'Outbound' THEN '000040000700001'
						   WHEN 'HubIn' THEN '000050000700001'
						   WHEN 'RMA' THEN '000060000700001'
				ELSE '0'
				END
			)
			IF EXISTS(SELECT * FROM DistributionReport_Authority WHERE UserID=@UserID AND MenuID=@MenuID AND CanSee=1)
				BEGIN
					SET @RevenueAmount=ISNULL((SELECT Amount FROM DistribitionReport_Daily WHERE Day=@Date AND Type=@Type AND Site='Chi' AND Plant=@Plant),0)
					SET @Display=@Display+'<tr><td>'+'ZhuHai'+':'+'</td>'+(CASE WHEN @RevenueAmount>=0 THEN '<td>' ELSE '<td style="color: #FF0000">' END)+CONVERT(VARCHAR(50),@RevenueAmount)+'</td></tr>'
				END

			IF @Date>CONVERT(VARCHAR(10),GETDATE()-1,120)
				BEGIN
					SET @Display=REPLACE(@Display,'0','')
				END
			IF @Display<>'' AND @Date=CONVERT(VARCHAR(10),GETDATE()-1,120)
				BEGIN
					SET @Display='<table style='+'"'+'background-image: url('+''''+'../Images/bg_blue_White.png'+''''+');'+'"'+' width=100% cellpadding=0 cellspacing=0 >'+@Display+'</table>'
				END
			IF @Display<>'' AND @Date<>CONVERT(VARCHAR(10),GETDATE()-1,120)
				BEGIN
					SET @Display='<table width=100% cellpadding=0 cellspacing=0 >'+@Display+'</table>'
				END

			INSERT INTO @ReturnTable (Day,Display)
				VALUES(CONVERT(VARCHAR(10),@Date,120),@Display)
			SET @Date=@Date+1
		END
	SELECT * FROM @ReturnTable
END
GO

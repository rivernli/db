USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_SiteMonthlyDistributionTrend_ByPlant_Fiscal_For_BI.Multek.com]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_SiteMonthlyDistributionTrend_ByPlant_Fiscal_For_BI.Multek.com] 
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(3)='001',
	@Type VARCHAR(10),
	@Year CHAR(4),
	@Site VARCHAR(3)='Chi',
	@Plant VARCHAR(10)='ZhuHai'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)

	DECLARE @YearMonth VARCHAR(7),@xmlData AS VARCHAR(MAX)
	
	CREATE TABLE #Temp (M1 NUMERIC(19,2),M2 NUMERIC(19,2),M3 NUMERIC(19,2),M4 NUMERIC(19,2),M5 NUMERIC(19,2),M6 NUMERIC(19,2),M7 NUMERIC(19,2),M8 NUMERIC(19,2),M9 NUMERIC(19,2),M10 NUMERIC(19,2),M11 NUMERIC(19,2),M12 NUMERIC(19,2))
		
	IF EXISTS(	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
				FROM DistribitionReport_Amount_Fiscal
				WHERE ReportCode=@ReportCode
					AND Type=@Type
					AND Year=@Year
					AND Site=@Site
					AND Plant=@Plant
			)
		BEGIN
			IF @ReportCode='001' AND @Plant='' AND @Type='RMA'
				BEGIN	
					INSERT INTO #Temp					
					SELECT M1-(
								SELECT M1 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M1,
							M2-(
								SELECT M2 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M2,
							M3-(
								SELECT M3 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M3,
							M4-(
								SELECT M4 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M4,
							M5-(
								SELECT M5 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M5,
							M6-(
								SELECT M6 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M6,
							M7-(
								SELECT M7 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M7,
							M8-(
								SELECT M8 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M8,
							M9-(
								SELECT M9 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M9,
							M10-(
								SELECT M10 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M10,
							M11-(
								SELECT M11 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M11,
							M12-(
								SELECT M12 
								FROM DistribitionReport_Amount_Fiscal 
								WHERE ReportCode=@ReportCode
									AND Type=@Type
									AND Year=@Year
									AND Site=@Site
									AND Plant='HK' 
								) AS M12
					
					FROM DistribitionReport_Amount_Fiscal
					WHERE ReportCode=@ReportCode
						AND Type=@Type
						AND Year=@Year
						AND Site=@Site
						AND Plant=@Plant
				END			
			ELSE
				BEGIN
					INSERT INTO #Temp
					SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
					FROM DistribitionReport_Amount_Fiscal
					WHERE ReportCode=@ReportCode
						AND Type=@Type
						AND Year=@Year
						AND Site=@Site
						AND Plant=@Plant
				END
		END
	ELSE
		BEGIN
			INSERT INTO #Temp VALUES (0,0,0,0,0,0,0,0,0,0,0,0)
		END

	SET @Site=(CASE @Site WHEN 'Chi' THEN 'China' WHEN 'Ger' THEN 'Germany' WHEN 'Sao' THEN 'Brazil' WHEN 'NFD' THEN 'North Field' ELSE '' END)
	SET @xmlData=''
	SET @Type=(CASE @Type WHEN 'Shipment' THEN 'FG Out' WHEN 'Outbound' THEN 'Invoice Sales' WHEN 'Output' THEN 'FG In' ELSE @Type END)
	SET @xmlData=@xmlData+'<chart labelStep=''2'' swfurl=''flash/Column3D.swf'' caption='+''''+@Site+' '+@Type+' Distribution Trend - Fiscal Year - ' +@Year+''''+' xAxisName='+''''+'Month'+''''+' yAxisName='+''''+'Amount'+''''+' decimals='+''''+'1'+''''+' animation ='+''''+'1'+''''+' numberPrefix='+''''+'$'+''''+' formatNumberScale='+''''+'1'+''''+' showValues='+''''+'1'+''''+' imageSave='+''''+'1'+''''+' imageSaveURL='+''''+'flash/FCExporter.aspx'+''''+'>'		
	
	SET @xmlData=@xmlData+'<set label='+''''+'Apr(P1)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M1 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'May(P2)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M2 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Jun(P3)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M3 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Jul(P4)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M4 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Aug(P5)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M5 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Sep(P6)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M6 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Oct(P7)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M7 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Nov(P8)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M8 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Dec(P9)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M9 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Jan(P10)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M10 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Feb(P11)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M11 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Mar(P12)'+''''+' value='+''''+CONVERT(VARCHAR(20),(SELECT M12 FROM #Temp))+''''+' />'
	SET @xmlData=@xmlData+'</chart>'

	SELECT @xmlData AS xmlData
	
END
GO

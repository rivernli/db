USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_For_BI.Multek.com]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_For_BI.Multek.com] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Site VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7),@xmlData AS VARCHAR(MAX),@M1 NUMERIC(19,2),@M2 NUMERIC(19,2),@M3 NUMERIC(19,2),@M4 NUMERIC(19,2),@M5 NUMERIC(19,2),@M6 NUMERIC(19,2),@M7 NUMERIC(19,2),@M8 NUMERIC(19,2),@M9 NUMERIC(19,2),@M10 NUMERIC(19,2),@M11 NUMERIC(19,2),@M12 NUMERIC(19,2)
	IF EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal
				WHERE ReportCode='002'
						AND Year=@Year
						AND Site=@Site)
		BEGIN
			SET @M1=(
						SELECT M1
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M2=(
						SELECT M2
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M3=(
						SELECT M3
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M4=(
						SELECT M4
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M5=(
						SELECT M5
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M6=(
						SELECT M6
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M7=(
						SELECT M7
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M8=(
						SELECT M8
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M9=(
						SELECT M9
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M10=(
						SELECT M10
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M11=(
						SELECT M11
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M1=(
						SELECT M1
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
			SET @M12=(
						SELECT M12
						FROM ShipmentReport_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site
					)
		END
	ELSE
		BEGIN
			SET @M1=0
			SET @M2=0
			SET @M3=0
			SET @M4=0
			SET @M5=0
			SET @M6=0
			SET @M7=0
			SET @M8=0
			SET @M9=0
			SET @M10=0
			SET @M11=0
			SET @M12=0
		END
		
	SET @Site=(CASE @Site WHEN 'Chi' THEN 'China' WHEN 'Ger' THEN 'Germany' WHEN 'Sao' THEN 'Brazil' WHEN 'NFD' THEN 'North Field' ELSE '' END)
	SET @xmlData=''
	--SET @xmlData=@xmlData+'<swfurl='+''''+'../flash/Column3D.swf'+''''+' chart caption='+''''+@Site+' Monthly Revenue Trend - Fiscal Year - ' +@Year+''''+' xAxisName='+''''+'Month'+''''+' yAxisName='+''''+'Amount'+''''+' decimals='+''''+'1'+''''+' animation ='+''''+'1'+''''+' numberPrefix='+''''+'$'+''''+' formatNumberScale='+''''+'1'+''''+' showValues='+''''+'1'+''''+' imageSave='+''''+'1'+''''+' imageSaveURL='+''''+'../flash/FCExporter.aspx'+''''+'>'		
	SET @xmlData=@xmlData+'<chart labelStep=''2'' swfurl=''flash/Column3D.swf'' caption='+''''+@Site+' Monthly Revenue Trend - Fiscal Year - ' +@Year+''''+' xAxisName='+''''+'Month'+''''+' yAxisName='+''''+'Amount'+''''+' decimals='+''''+'1'+''''+' animation ='+''''+'1'+''''+' numberPrefix='+''''+'$'+''''+' formatNumberScale='+''''+'1'+''''+' showValues='+''''+'1'+''''+' imageSave='+''''+'1'+''''+' imageSaveURL='+''''+'flash/FCExporter.aspx'+''''+'>'		
	SET @xmlData=@xmlData+'<set label='+''''+'Apr(P1)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M1)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'May(P2)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M2)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Jun(P3)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M3)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Jul(P4)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M4)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Aug(P5)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M5)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Sep(P6)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M6)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Oct(P7)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M7)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Nov(P8)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M8)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Dec(P9)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M9)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Jan(P10)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M10)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Feb(P11)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M11)+''''+' />'
	SET @xmlData=@xmlData+'<set label='+''''+'Mar(P12)'+''''+' value='+''''+CONVERT(VARCHAR(20),@M12)+''''+' />'
	SET @xmlData=@xmlData+'</chart>'

	SELECT @xmlData AS xmlData

END
GO

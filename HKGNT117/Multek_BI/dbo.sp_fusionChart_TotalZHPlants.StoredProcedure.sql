USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_fusionChart_TotalZHPlants]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_fusionChart_TotalZHPlants] 
@type varchar(20),
@plant char(4) = ''
as
-- “Outbound” is “Invoice Sales”. “Output” is “FG In”. “Shipment” is “FG Out”.
declare @year char(4)
select @year=fiscalYear from multek_zh.dbo.vw_calender_ext where idate = convert(varchar(8),getdate(),112)

if(@plant <> '')
exec HKGNT111.multek_sz_new.dbo.[DistributionReport_sp_Query_SiteMonthlyDistributionTrend_ByPlant_Fiscal_For_BI.Multek.com]
default,@type,@year,'Chi',@plant

else
exec HKGNT111.multek_sz_new.dbo.[DistributionReport_sp_Query_SiteMonthlyDistributionTrend_ByPlant_Fiscal_For_BI.Multek.com]
default,@type,@year


/*
	@ReportCode VARCHAR(3)='001',
	@Type VARCHAR(10),
	@Year CHAR(4),
	@Site VARCHAR(3)='Chi',
	@Plant VARCHAR(10)='ZhuHai'*/
GO

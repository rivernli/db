USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_fusionChart_shipmentRP]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_fusionChart_shipmentRP] 
@year int,
@plant char(4) = ''
as
if(@plant ='')
	exec HKGNT111.multek_sz_new.dbo.ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_Fiscal_Year_Period @year,'chi'
else
	exec HKGNT111.multek_sz_new.dbo.ShipmentReport_sp_Query_Site_Monthly_Shipment_Trend_By_Plant_Fiscal_Year_Period @year,'chi',@plant

GO

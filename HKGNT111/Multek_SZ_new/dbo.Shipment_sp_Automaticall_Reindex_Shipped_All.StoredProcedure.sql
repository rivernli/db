USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Shipment_sp_Automaticall_Reindex_Shipped_All]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Shipment_sp_Automaticall_Reindex_Shipped_All]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
    -- Insert statements for procedure here
	ALTER INDEX [PK_ShipmentReport_Shipped_All] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [UpdateSHDate] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [UpdateRealOEMCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [ShDols] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateRealOEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateRealCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateLays] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDate] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [OEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [CustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [RealOEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [RealCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [Plant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [Loc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [Lays] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [invCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [CustNum] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateRealCustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateRealCustomerLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateRealOEMLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [SHDateRealOEMLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [LocPlantSHDateSOType] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [LocPlantSOTypeSHDateBaanItem] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [LocPlantSOTypeSHDateCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	
	
	
	ALTER INDEX [LocPlantSOTypeSHDateOEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	

	
	
	ALTER INDEX [PK_ShipmentReport_Shipped_All] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [UpdateSHDate] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [UpdateRealOEMCustomer] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [ShDols] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateRealOEM] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateRealCustomer] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateLoc] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateLays] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDate] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [OEM] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [CustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [RealOEM] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [RealCustomer] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [Plant] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [Loc] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [Lays] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [invCustomer] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [CustNum] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateRealCustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateRealCustomerLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateRealOEMLoc] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [SHDateRealOEMLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [LocPlantSHDateSOType] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [LocPlantSOTypeSHDateBaanItem] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [LocPlantSOTypeSHDateCustomer] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	
	
	
	ALTER INDEX [LocPlantSOTypeSHDateOEM] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )

	ALTER INDEX [LocPlantSHDateLayer] ON [dbo].[ShipmentReport_Shipped_All] REORGANIZE WITH ( LOB_COMPACTION = ON )
	*/
END
GO

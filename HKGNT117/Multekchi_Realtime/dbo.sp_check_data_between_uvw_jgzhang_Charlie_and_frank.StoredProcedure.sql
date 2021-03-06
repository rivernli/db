USE [multekchi_realtime]
GO
/****** Object:  StoredProcedure [dbo].[sp_check_data_between_uvw_jgzhang_Charlie_and_frank]    Script Date: 2014/11/12 17:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_check_data_between_uvw_jgzhang_Charlie_and_frank]
	-- Add the parameters for the stored procedure here
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
execute sp_tables 'compare'
if @@rowcount>0
	begin
		drop table compare
	end
	
	select 
a.Loc as Loc_1,c.Loc as Loc_2, (case when a.Loc=c.Loc then 'ok' else 'Diff' end)  as Compare1,
convert(numeric(19,0),a.SONum) as SONum_1,convert(numeric(19,0),c.SONum) as SONum_2, (case when convert(numeric(19,0),a.SONum)=convert(numeric(19,0),c.SONum) then 'ok' else 'Diff' end)  as Compare2,
convert(numeric(19,0),a.SOPos) as SOPos_1,convert(numeric(19,0),c.SOPos) as SOPos_2, (case when convert(numeric(19,0),a.SOPos)=convert(numeric(19,0),c.SOPos) then 'ok' else 'Diff' end)  as Compare3,
convert(numeric(19,0),a.DD) as DD_1,convert(numeric(19,0),c.DD) as DD_2, (case when convert(numeric(19,0),a.DD)=convert(numeric(19,0),c.DD) then 'ok' else 'Diff' end)  as Compare4,
a.SHDate as SHDate_1,c.SHDate as SHDate_2, (case when a.SHDate=c.SHDate then 'ok' else 'Diff' end)  as Compare5,
a.Sh1Date as Sh1Date_1,c.Sh1Date as Sh1Date_2, (case when a.Sh1Date=c.Sh1Date then 'ok' else 'Diff' end)  as Compare6,
convert(numeric(19,0),a.Sh1) as Sh1_1,convert(numeric(19,0),c.Sh1) as Sh1_2, (case when convert(numeric(19,0),a.Sh1)=convert(numeric(19,0),c.Sh1) then 'ok' else 'Diff' end)  as Compare7,
a.ShTime as ShTime_1,c.ShTime as ShTime_2, (case when a.ShTime=c.ShTime then 'ok' else 'Diff' end)  as Compare8,
a.CustNum as CustNum_1,c.CustNum as CustNum_2, (case when a.CustNum=c.CustNum then 'ok' else 'Diff' end)  as Compare9,
a.[Customer Name] as Customer_Name_1,c.[Customer Name] as Customer_Name_2, (case when a.[Customer Name]=c.[Customer Name] then 'ok' else 'Diff' end)  as Compare10,
a.ShCust as ShCust_1,c.ShCust as ShCust_2, (case when a.ShCust=c.ShCust then 'ok' else 'Diff' end)  as Compare11,
a.ShCustName as ShCustName_1,c.ShCustName as ShCustName_2, (case when a.ShCustName=c.ShCustName then 'ok' else 'Diff' end)  as Compare12,
a.InvCust as InvCust_1,c.InvCust as InvCust_2, (case when a.InvCust=c.InvCust then 'ok' else 'Diff' end)  as Compare13,
a.InvCustName as InvCustName_1,c.InvCustName as InvCustName_2, (case when a.InvCustName=c.InvCustName then 'ok' else 'Diff' end)  as Compare14,
a.CustPONum as CustPONum_1,c.CustPONum as CustPONum_2, (case when a.CustPONum=c.CustPONum then 'ok' else 'Diff' end)  as Compare15,
a.BusSegNum as BusSegNum_1,c.BusSegNum as BusSegNum_2, (case when a.BusSegNum=c.BusSegNum then 'ok' else 'Diff' end)  as Compare16,
a.BusSeg as BusSeg_1,c.BusSeg as BusSeg_2, (case when a.BusSeg=c.BusSeg then 'ok' else 'Diff' end)  as Compare17,
a.CDueDate as CDueDate_1,c.CDueDate as CDueDate_2, (case when a.CDueDate=c.CDueDate then 'ok' else 'Diff' end)  as Compare18,
a.DocDate as DocDate_1,c.DocDate as DocDate_2, (case when a.DocDate=c.DocDate then 'ok' else 'Diff' end)  as Compare19,
a.CPartNum as CPartNum_1,c.CPartNum as CPartNum_2, (case when a.CPartNum=c.CPartNum then 'ok' else 'Diff' end)  as Compare20,
a.CPartRev as CPartRev_1,c.CPartRev as CPartRev_2, (case when a.CPartRev=c.CPartRev then 'ok' else 'Diff' end)  as Compare21,
convert(numeric(19,0),a.CprtID) as CprtID_1,convert(numeric(19,0),c.CprtID) as CprtID_2, (case when convert(numeric(19,0),a.CprtID)=convert(numeric(19,0),c.CprtID) then 'ok' else 'Diff' end)  as Compare22,
convert(numeric(19,0),a.Priority) as Priority_1,convert(numeric(19,0),c.Priority) as Priority_2, (case when convert(numeric(19,0),a.Priority)=convert(numeric(19,0),c.Priority) then 'ok' else 'Diff' end)  as Compare23,
convert(numeric(19,0),a.OrdBrds) as OrdBrds_1,convert(numeric(19,0),c.OrdBrds) as OrdBrds_2, (case when convert(numeric(19,0),a.OrdBrds)=convert(numeric(19,0),c.OrdBrds) then 'ok' else 'Diff' end)  as Compare24,
convert(numeric(19,0),a.ShBrds) as ShBrds_1,convert(numeric(19,0),c.ShBrds) as ShBrds_2, (case when convert(numeric(19,0),a.ShBrds)=convert(numeric(19,0),c.ShBrds) then 'ok' else 'Diff' end)  as Compare25,
convert(numeric(19,0),a.ShDols) as ShDols_1,convert(numeric(19,0),c.ShDols) as ShDols_2, (case when convert(numeric(19,0),a.ShDols)=convert(numeric(19,0),c.ShDols) then 'ok' else 'Diff' end)  as Compare26,
convert(numeric(19,0),a.NRE) as NRE_1,convert(numeric(19,0),c.NRE) as NRE_2, (case when convert(numeric(19,0),a.NRE)=convert(numeric(19,0),c.NRE) then 'ok' else 'Diff' end)  as Compare27,
convert(numeric(19,0),a.TtlSales) as TtlSales_1,convert(numeric(19,0),c.TtlSales) as TtlSales_2, (case when convert(numeric(19,0),a.TtlSales)=convert(numeric(19,0),c.TtlSales) then 'ok' else 'Diff' end)  as Compare28,
convert(numeric(19,0),a.PriceB) as PriceB_1,convert(numeric(19,0),c.PriceB) as PriceB_2, (case when convert(numeric(19,0),a.PriceB)=convert(numeric(19,0),c.PriceB) then 'ok' else 'Diff' end)  as Compare29,
convert(numeric(19,0),a.CostB) as CostB_1,convert(numeric(19,0),c.CostB) as CostB_2, (case when convert(numeric(19,0),a.CostB)=convert(numeric(19,0),c.CostB) then 'ok' else 'Diff' end)  as Compare30,
convert(numeric(19,0),a.ProfitB) as ProfitB_1,convert(numeric(19,0),c.ProfitB) as ProfitB_2, (case when convert(numeric(19,0),a.ProfitB)=convert(numeric(19,0),c.ProfitB) then 'ok' else 'Diff' end)  as Compare31,
convert(numeric(19,0),a.UP) as UP_1,convert(numeric(19,0),c.UP) as UP_2, (case when convert(numeric(19,0),a.UP)=convert(numeric(19,0),c.UP) then 'ok' else 'Diff' end)  as Compare32,
convert(numeric(19,0),a.PriceP) as PriceP_1,convert(numeric(19,0),c.PriceP) as PriceP_2, (case when convert(numeric(19,0),a.PriceP)=convert(numeric(19,0),c.PriceP) then 'ok' else 'Diff' end)  as Compare33,
convert(numeric(19,0),a.CostP) as CostP_1,convert(numeric(19,0),c.CostP) as CostP_2, (case when convert(numeric(19,0),a.CostP)=convert(numeric(19,0),c.CostP) then 'ok' else 'Diff' end)  as Compare34,
convert(numeric(19,0),a.ProfitP) as ProfitP_1,convert(numeric(19,0),c.ProfitP) as ProfitP_2, (case when convert(numeric(19,0),a.ProfitP)=convert(numeric(19,0),c.ProfitP) then 'ok' else 'Diff' end)  as Compare35,
convert(numeric(19,0),a.ProfitPct) as ProfitPct_1,convert(numeric(19,0),c.ProfitPct) as ProfitPct_2, (case when convert(numeric(19,0),a.ProfitPct)=convert(numeric(19,0),c.ProfitPct) then 'ok' else 'Diff' end)  as Compare36,
convert(numeric(19,0),a.ProfitT) as ProfitT_1,convert(numeric(19,0),c.ProfitT) as ProfitT_2, (case when convert(numeric(19,0),a.ProfitT)=convert(numeric(19,0),c.ProfitT) then 'ok' else 'Diff' end)  as Compare37,
a.SODate as SODate_1,c.SODate as SODate_2, (case when a.SODate=c.SODate then 'ok' else 'Diff' end)  as Compare38,
a.SOTime as SOTime_1,c.SOTime as SOTime_2, (case when a.SOTime=c.SOTime then 'ok' else 'Diff' end)  as Compare39,
a.SOType as SOType_1,c.SOType as SOType_2, (case when a.SOType=c.SOType then 'ok' else 'Diff' end)  as Compare40,
convert(numeric(19,0),a.OrdStat) as OrdStat_1,convert(numeric(19,0),c.OrdStat) as OrdStat_2, (case when convert(numeric(19,0),a.OrdStat)=convert(numeric(19,0),c.OrdStat) then 'ok' else 'Diff' end)  as Compare41,
convert(numeric(19,0),a.InRepNum) as InRepNum_1,convert(numeric(19,0),c.InRepNum) as InRepNum_2, (case when convert(numeric(19,0),a.InRepNum)=convert(numeric(19,0),c.InRepNum) then 'ok' else 'Diff' end)  as Compare42,
a.InRepName as InRepName_1,c.InRepName as InRepName_2, (case when a.InRepName=c.InRepName then 'ok' else 'Diff' end)  as Compare43,
a.OutRepNum as OutRepNum_1,c.OutRepNum as OutRepNum_2, (case when a.OutRepNum=c.OutRepNum then 'ok' else 'Diff' end)  as Compare44,
a.OutRepName as OutRepName_1,c.OutRepName as OutRepName_2, (case when a.OutRepName=c.OutRepName then 'ok' else 'Diff' end)  as Compare45,
a.ContactNum as ContactNum_1,c.ContactNum as ContactNum_2, (case when a.ContactNum=c.ContactNum then 'ok' else 'Diff' end)  as Compare46,
a.ContactName as ContactName_1,c.ContactName as ContactName_2, (case when a.ContactName=c.ContactName then 'ok' else 'Diff' end)  as Compare47,
a.BaanItemNum as BaanItemNum_1,c.BaanItemNum as BaanItemNum_2, (case when a.BaanItemNum=c.BaanItemNum then 'ok' else 'Diff' end)  as Compare48,
a.ProToolNum as ProToolNum_1,c.ProToolNum as ProToolNum_2, (case when a.ProToolNum=c.ProToolNum then 'ok' else 'Diff' end)  as Compare49,
a.OEM as OEM_1,c.OEM as OEM_2, (case when a.OEM=c.OEM then 'ok' else 'Diff' end)  as Compare50,
a.[OEM Name] as OEM_Name_1,c.[OEM Name] as OEM_Name_2, (case when a.[OEM Name]=c.[OEM Name] then 'ok' else 'Diff' end)  as Compare51,
a.Carrier as Carrier_1,c.Carrier as Carrier_2, (case when a.Carrier=c.Carrier then 'ok' else 'Diff' end)  as Compare52,
a.TrackNum as TrackNum_1,c.TrackNum as TrackNum_2, (case when a.TrackNum=c.TrackNum then 'ok' else 'Diff' end)  as Compare53,
a.Lays as Lays_1,c.Lays as Lays_2, (case when a.Lays=c.Lays then 'ok' else 'Diff' end)  as Compare54,
a.SelCode as SelCode_1,c.SelCode as SelCode_2, (case when a.SelCode=c.SelCode then 'ok' else 'Diff' end)  as Compare55,
convert(numeric(19,0),a.ShPan) as ShPan_1,convert(numeric(19,0),c.ShPan) as ShPan_2, (case when convert(numeric(19,0),a.ShPan)=convert(numeric(19,0),c.ShPan) then 'ok' else 'Diff' end)  as Compare56,
convert(numeric(19,0),a.ShLays) as ShLays_1,convert(numeric(19,0),c.ShLays) as ShLays_2, (case when convert(numeric(19,0),a.ShLays)=convert(numeric(19,0),c.ShLays) then 'ok' else 'Diff' end)  as Compare57,
convert(numeric(19,0),a.WidthB) as WidthB_1,convert(numeric(19,0),c.WidthB) as WidthB_2, (case when convert(numeric(19,0),a.WidthB)=convert(numeric(19,0),c.WidthB) then 'ok' else 'Diff' end)  as Compare58,
convert(numeric(19,0),a.LengthB) as LengthB_1,convert(numeric(19,0),c.LengthB) as LengthB_2, (case when convert(numeric(19,0),a.LengthB)=convert(numeric(19,0),c.LengthB) then 'ok' else 'Diff' end)  as Compare59,
convert(numeric(19,0),a.AreaB) as AreaB_1,convert(numeric(19,0),c.AreaB) as AreaB_2, (case when convert(numeric(19,0),a.AreaB)=convert(numeric(19,0),c.AreaB) then 'ok' else 'Diff' end)  as Compare60,
convert(numeric(19,0),a.WidthP) as WidthP_1,convert(numeric(19,0),c.WidthP) as WidthP_2, (case when convert(numeric(19,0),a.WidthP)=convert(numeric(19,0),c.WidthP) then 'ok' else 'Diff' end)  as Compare61,
convert(numeric(19,0),a.LengthP) as LengthP_1,convert(numeric(19,0),c.LengthP) as LengthP_2, (case when convert(numeric(19,0),a.LengthP)=convert(numeric(19,0),c.LengthP) then 'ok' else 'Diff' end)  as Compare62,
convert(numeric(19,0),a.AreaP) as AreaP_1,convert(numeric(19,0),c.AreaP) as AreaP_2, (case when convert(numeric(19,0),a.AreaP)=convert(numeric(19,0),c.AreaP) then 'ok' else 'Diff' end)  as Compare63,
a.Subs as Subs_1,c.Subs as Subs_2, (case when a.Subs=c.Subs then 'ok' else 'Diff' end)  as Compare64,
a.BaseMtl as BaseMtl_1,c.BaseMtl as BaseMtl_2, (case when a.BaseMtl=c.BaseMtl then 'ok' else 'Diff' end)  as Compare65,
convert(numeric(19,0),a.HolesB) as HolesB_1,convert(numeric(19,0),c.HolesB) as HolesB_2, (case when convert(numeric(19,0),a.HolesB)=convert(numeric(19,0),c.HolesB) then 'ok' else 'Diff' end)  as Compare66,
convert(numeric(19,0),a.HolesP) as HolesP_1,convert(numeric(19,0),c.HolesP) as HolesP_2, (case when convert(numeric(19,0),a.HolesP)=convert(numeric(19,0),c.HolesP) then 'ok' else 'Diff' end)  as Compare67,
convert(numeric(19,0),a.SmallHole) as SmallHole_1,convert(numeric(19,0),c.SmallHole) as SmallHole_2, (case when convert(numeric(19,0),a.SmallHole)=convert(numeric(19,0),c.SmallHole) then 'ok' else 'Diff' end)  as Compare68,
convert(numeric(19,0),a.Thick) as Thick_1,convert(numeric(19,0),c.Thick) as Thick_2, (case when convert(numeric(19,0),a.Thick)=convert(numeric(19,0),c.Thick) then 'ok' else 'Diff' end)  as Compare69,
convert(numeric(19,0),a.AspRatio) as AspRatio_1,convert(numeric(19,0),c.AspRatio) as AspRatio_2, (case when convert(numeric(19,0),a.AspRatio)=convert(numeric(19,0),c.AspRatio) then 'ok' else 'Diff' end)  as Compare70,
convert(numeric(19,0),a.ShBrdsDD) as ShBrdsDD_1,convert(numeric(19,0),c.ShBrdsDD) as ShBrdsDD_2, (case when convert(numeric(19,0),a.ShBrdsDD)=convert(numeric(19,0),c.ShBrdsDD) then 'ok' else 'Diff' end)  as Compare71,
convert(numeric(19,0),a.ShPanDD) as ShPanDD_1,convert(numeric(19,0),c.ShPanDD) as ShPanDD_2, (case when convert(numeric(19,0),a.ShPanDD)=convert(numeric(19,0),c.ShPanDD) then 'ok' else 'Diff' end)  as Compare72,
convert(numeric(19,0),a.ShLaysDD) as ShLaysDD_1,convert(numeric(19,0),c.ShLaysDD) as ShLaysDD_2, (case when convert(numeric(19,0),a.ShLaysDD)=convert(numeric(19,0),c.ShLaysDD) then 'ok' else 'Diff' end)  as Compare73,
convert(numeric(19,0),a.ShDolsDD) as ShDolsDD_1,convert(numeric(19,0),c.ShDolsDD) as ShDolsDD_2, (case when convert(numeric(19,0),a.ShDolsDD)=convert(numeric(19,0),c.ShDolsDD) then 'ok' else 'Diff' end)  as Compare74,
a.ATLCusNum as ATLCusNum_1,c.ATLCusNum as ATLCusNum_2, (case when a.ATLCusNum=c.ATLCusNum then 'ok' else 'Diff' end)  as Compare75,
a.ShipName as ShipName_1,c.ShipName as ShipName_2, (case when a.ShipName=c.ShipName then 'ok' else 'Diff' end)  as Compare76,
convert(numeric(19,0),a.UPArr) as UPArr_1,convert(numeric(19,0),c.UPArr) as UPArr_2, (case when convert(numeric(19,0),a.UPArr)=convert(numeric(19,0),c.UPArr) then 'ok' else 'Diff' end)  as Compare77,
convert(numeric(19,0),a.BrdPerArr) as BrdPerArr_1,convert(numeric(19,0),c.BrdPerArr) as BrdPerArr_2, (case when convert(numeric(19,0),a.BrdPerArr)=convert(numeric(19,0),c.BrdPerArr) then 'ok' else 'Diff' end)  as Compare78,
convert(numeric(19,0),a.AreaA) as AreaA_1,convert(numeric(19,0),c.AreaA) as AreaA_2, (case when convert(numeric(19,0),a.AreaA)=convert(numeric(19,0),c.AreaA) then 'ok' else 'Diff' end)  as Compare79,
convert(numeric(19,0),a.CPRTSID) as CPRTSID_1,convert(numeric(19,0),c.CPRTSID) as CPRTSID_2, (case when convert(numeric(19,0),a.CPRTSID)=convert(numeric(19,0),c.CPRTSID) then 'ok' else 'Diff' end)  as Compare80,
a.InvBP as InvBP_1,c.InvBP as InvBP_2, (case when a.InvBP=c.InvBP then 'ok' else 'Diff' end)  as Compare81,
a.InvBPName as InvBPName_1,c.InvBPName as InvBPName_2, (case when a.InvBPName=C.InvBPName then 'ok' else 'Diff' end)  as Compare82,
convert(numeric(19,0),a.CprtID_PDDim) as CprtID_PDDim_1,convert(numeric(19,0),c.CprtID_PDDim) as CprtID_PDDim_2, (case when convert(numeric(19,0),a.CprtID_PDDim)=convert(numeric(19,0),c.CprtID_PDDim) then 'ok' else 'Diff' end)  as Compare83,
a.ProToolNum_PDDim as ProToolNum_PDDim_1,c.ProToolNum_PDDim as ProToolNum_PDDim_2, (case when a.ProToolNum_PDDim=c.ProToolNum_PDDim then 'ok' else 'Diff' end)  as Compare84,
convert(numeric(19,0),a.SOSeq) as SOSeq_1,convert(numeric(19,0),c.SOSeq) as SOSeq_2, (case when convert(numeric(19,0),a.SOSeq)=convert(numeric(19,0),c.SOSeq) then 'ok' else 'Diff' end)  as Compare85,
convert(numeric(19,0),a.ShDols_loc) as ShDols_loc_1,convert(numeric(19,0),c.ShDols_loc) as ShDols_loc_2, (case when convert(numeric(19,0),a.ShDols_loc)=convert(numeric(19,0),c.ShDols_loc) then 'ok' else 'Diff' end)  as Compare86,
convert(numeric(19,0),a.NRE_loc) as NRE_loc_1,convert(numeric(19,0),c.NRE_loc) as NRE_loc_2, (case when convert(numeric(19,0),a.NRE_loc)=convert(numeric(19,0),c.NRE_loc) then 'ok' else 'Diff' end)  as Compare87,
convert(numeric(19,0),a.TtlSales_loc) as TtlSales_loc_1,convert(numeric(19,0),c.TtlSales_loc) as TtlSales_loc_2, (case when convert(numeric(19,0),a.TtlSales_loc)=convert(numeric(19,0),c.TtlSales_loc) then 'ok' else 'Diff' end)  as Compare88,
convert(numeric(19,0),a.PriceB_loc) as PriceB_loc_1,convert(numeric(19,0),c.PriceB_loc) as PriceB_loc_2, (case when convert(numeric(19,0),a.PriceB_loc)=convert(numeric(19,0),c.PriceB_loc) then 'ok' else 'Diff' end)  as Compare89,
convert(numeric(19,0),a.CostB_loc) as CostB_loc_1,convert(numeric(19,0),c.CostB_loc) as CostB_loc_2, (case when convert(numeric(19,0),a.CostB_loc)=convert(numeric(19,0),c.CostB_loc) then 'ok' else 'Diff' end)  as Compare90,
convert(numeric(19,0),a.ProfitB_loc) as ProfitB_loc_1,convert(numeric(19,0),c.ProfitB_loc) as ProfitB_loc_2, (case when convert(numeric(19,0),a.ProfitB_loc)=convert(numeric(19,0),c.ProfitB_loc) then 'ok' else 'Diff' end)  as Compare91,
convert(numeric(19,0),a.PriceP_loc) as PriceP_loc_1,convert(numeric(19,0),c.PriceP_loc) as PriceP_loc_2, (case when convert(numeric(19,0),a.PriceP_loc)=convert(numeric(19,0),c.PriceP_loc) then 'ok' else 'Diff' end)  as Compare92,
convert(numeric(19,0),a.CostP_loc) as CostP_loc_1,convert(numeric(19,0),c.CostP_loc) as CostP_loc_2, (case when convert(numeric(19,0),a.CostP_loc)=convert(numeric(19,0),c.CostP_loc) then 'ok' else 'Diff' end)  as Compare93,
convert(numeric(19,0),a.ProfitP_loc) as ProfitP_loc_1,convert(numeric(19,0),c.ProfitP_loc) as ProfitP_loc_2, (case when convert(numeric(19,0),a.ProfitP_loc)=convert(numeric(19,0),c.ProfitP_loc) then 'ok' else 'Diff' end)  as Compare94,
convert(numeric(19,0),a.ProfitPct_loc) as ProfitPct_loc_1,convert(numeric(19,0),c.ProfitPct_loc) as ProfitPct_loc_2, (case when convert(numeric(19,0),a.ProfitPct_loc)=convert(numeric(19,0),c.ProfitPct_loc) then 'ok' else 'Diff' end)  as Compare95,
convert(numeric(19,0),a.ProfitT_loc) as ProfitT_loc_1,convert(numeric(19,0),c.ProfitT_loc) as ProfitT_loc_2, (case when convert(numeric(19,0),a.ProfitT_loc)=convert(numeric(19,0),c.ProfitT_loc) then 'ok' else 'Diff' end)  as Compare96,
convert(numeric(19,0),a.ShDolsDD_loc) as ShDolsDD_loc_1,convert(numeric(19,0),c.ShDolsDD_loc) as ShDolsDD_loc_2, (case when convert(numeric(19,0),a.ShDolsDD_loc)=convert(numeric(19,0),c.ShDolsDD_loc) then 'ok' else 'Diff' end)  as Compare97,
a.Item as Item_1,c.Item as Item_2, (case when a.Item=c.Item then 'ok' else 'Diff' end)  as Compare98,
a.ShDateTime as ShDateTime_1,c.ShDateTime as ShDateTime_2, (case when a.ShDateTime=c.ShDateTime then 'ok' else 'Diff' end)  as Compare99,
convert(numeric(19,0),a.ShipID) as ShipID_1,convert(numeric(19,0),c.ShipID) as ShipID_2, (case when convert(numeric(19,0),a.ShipID)=convert(numeric(19,0),c.ShipID) then 'ok' else 'Diff' end)  as Compare100,
a.Plant as Plant_1,c.Plant as Plant_2, (case when a.Plant=c.Plant then 'ok' else 'Diff' end)  as Compare101,
a.Bus_Unit as Bus_Unit_1,c.Bus_Unit as Bus_Unit_2, (case when a.Bus_Unit=c.Bus_Unit then 'ok' else 'Diff' end)  as Compa102
into Compare
	from dbo.uvw_jgzhang_Charlie a,
	(
		select a.sonum,a.sopos,a.shipid
		from dbo.uvw_jgzhang_Charlie a,frank_shipped_all_china b
		where a.sonum=b.sonum
			and a.sopos=b.sopos
			and a.shipid=b.shipid
			and b.loc='chi'
			and a.shdate between @DateFrom and @DateTo
			and b.shdate between @DateFrom and @DateTo
		group by a.sonum,a.sopos,a.shipid
	) b,
	frank_shipped_all_china c
	where a.sonum=b.sonum
		and a.sopos=b.sopos
		and a.shipid=b.shipid
		and a.shdate between @DateFrom and @DateTo
		and a.sonum=c.sonum
		and a.sopos=c.sopos
		and a.shipid=c.shipid
		and C.loc='chi'
		and C.shdate between @DateFrom and @DateTo
	order by a.sonum desc,a.sopos desc,a.shipid desc
END


GO

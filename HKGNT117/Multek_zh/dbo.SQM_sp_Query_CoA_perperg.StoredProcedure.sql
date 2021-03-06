USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Query_CoA_perperg]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SQM_sp_Query_CoA_perperg]
	@item NVARCHAR(50),
	@CoANo NVARCHAR(50)=NULL,
	@vdor NVARCHAR(50)=NULL,
	@mafr NVARCHAR(50)=NULL,
	@VendorPN NVARCHAR(50)=NULL,
	@Location NVARCHAR(50)=NULL,
	@DeliveryDate NVARCHAR(50)=NULL,
	@LotNo NVARCHAR(50)=NULL,
	@isExact bit = 0 

AS
SET NOCOUNT ON 

select * into #temp from 
(
	--select a.T$VERS,b.T$UPRN,b.T$CAID,(CASE b.T$TYPE WHEN '2' THEN b.T$CAD1 WHEN '1' THEN b.T$CAD2 END) as result,b.T$ITEM,a.T$DATE,  
	--vdor as Vendor, mafr as Manufacturer, loca as ManufacturingLocation, vdpn as VendorPN, dsca as MaterialsDescription 
	--from tfspur018180 a
	--INNER JOIN tfspur019180 b ON b.T$UPRN=a.T$UPRN AND b.T$ITEM=a.T$ITEM 
	--LEFT JOIN HKGNT137.misDB.dbo.tAttr_prepreg c ON c.item=b.T$ITEM 
	--WHERE ltrim(a.T$CITG)='IG005' 
	select a.T$VERS,b.T$UPRN,b.T$CAID,b.T$CAD1 as result,b.T$ITEM,a.T$DATE,  
	vdor as Vendor, mafr as Manufacturer, loca as ManufacturingLocation, vdpn as VendorPN, dsca as MaterialsDescription,	
	(case when d.tolerance1 is null then d.rc when d.tolerance1 = 'N/A' then d.rc when d.tolerance1 = '**' then d.rc else d.rc+'+/-'+d.tolerance1 end) as RCRequirementinIQCSpec,
	(case when d.tolerance2 is null then d.rfOfMultek when d.tolerance2 = 'N/A' then d.rfOfMultek when d.tolerance2 = '**' then d.rfOfMultek else d.rfOfMultek+'+/-'+d.tolerance2 end) as RFRequirementinIQCSpec,
	(case when d.tolerance3 is null then d.gtOfMultek when d.tolerance3 = 'N/A' then d.gtOfMultek when d.tolerance3 = '**' then d.gtOfMultek else d.gtOfMultek+'+/-'+d.tolerance3 end) as GTRequirementinIQCSpec 	
	from tfspur018180 a
	INNER JOIN tfspur019180 b ON b.T$UPRN=a.T$UPRN AND b.T$ITEM=a.T$ITEM 
	LEFT JOIN HKGNT137.misDB.dbo.tAttr_prepreg c ON c.item=b.T$ITEM 
	LEFT JOIN HKGNT137.misDB.dbo.iqc_prepreg d ON d.Location=c.loca AND d.vendorPN=c.vdpn AND d.[type]=c.atyp AND d.rc=c.rcpc AND d.LaserDrillable=c.lsdr 
	WHERE ltrim(a.T$CITG)='IG005' 
) tb  


declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + T$CAID from TFSITM034180 group by T$CAID 
set @sql = '[' + @sql + ']'

declare @sqlstr nvarchar(max)
set @sqlstr='select T$VERS as version,[T$UPRN] as UPRN,[#STDN!] as PN,[#STSO!] as CoANo,[#STLT!] as LotNo,[#STPD!] as ManufactureDate,[#STDT!] as DeliveryDate,[#RC!] as RC,
			 [#RF!] as RF,[#GT!] as GT,[#VC!] as VC,[#MV!] as MV,[#TV!] as TV,
			 [#FC!] as FC,Vendor, Manufacturer,  ManufacturingLocation, VendorPN, MaterialsDescription,
			 RCRequirementinIQCSpec,RFRequirementinIQCSpec,GTRequirementinIQCSpec,
			 (select T$CAD3 from tfspur019180 where T$CAID=''#RC!'' AND T$UPRN=b.T$UPRN AND T$ITEM=b.[#STDN!]) as RCRequirementinCoA,
			 (select T$CAD3 from tfspur019180 where T$CAID=''#RF!'' AND T$UPRN=b.T$UPRN AND T$ITEM=b.[#STDN!]) as RFRequirementinCoA,
			 (select T$CAD3 from tfspur019180 where T$CAID=''#GT!'' AND T$UPRN=b.T$UPRN AND T$ITEM=b.[#STDN!]) as RFRequirementinCoA 
			 from (select * from #temp) a pivot (max(result) for T$CAID in (' + @sql + ')) b where 1=1 ' 
			 
			+ dbo.fx_AIS_CoA_jsExact(@item,'[#STDN!]',@isExact)
		+ dbo.fx_AIS_CoA_jsExact(@CoANo,'[#STSO!]',@isExact)
		+ dbo.fx_AIS_CoA_jsExact(@vdor,'Vendor',@isExact)
		+ dbo.fx_AIS_CoA_jsExact(@mafr,'Manufacturer',@isExact) 
		+ dbo.fx_AIS_CoA_jsExact(@VendorPN,'VendorPN',@isExact) 
		+ dbo.fx_AIS_CoA_jsExact(@Location,'ManufacturingLocation',@isExact) 
		+ dbo.fx_AIS_CoA_jsExact(@DeliveryDate,'[#STDT!]',@isExact) 
		+ dbo.fx_AIS_CoA_jsExact(@LotNo,'[#STLT!]',@isExact)	+	
	' order by T$DATE desc '
	
	EXEC(@sqlstr)
GO

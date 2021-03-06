USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_SupplierSummary_List]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_SupplierSummary_List] 
as
SELECT  
Company
,[T$SUNO] as Supplier
,[T$NAMA]+[T$NAMB] as [Name]
,[T$NAMC]+[T$NAMD] as Address
,[T$NAME]+[T$NAMF] as City
,[T$PSTC] as [ZIP Code]
,(select T$DSCA from ttcmcs010180 where REPLACE(T$CCTY,' ','')=REPLACE(vw_Supplier_info.T$CCTY,' ','')) as Country 
,[T$cadr] as [Transportation Address]
,[T$ccor] as [Postal Address]
,[T$cwar] as [Warehouse]
,(case [T$txta] when '0' then 'No' when '1' then 'Yes' end) as [Text]
,[T$comp] as [Default Financial Company]
,(case [T$sndr] when '1' then 'Yes' when '2' then 'No' else '' end) as [One-Time Supplier]
,[T$pspr] as [Supplier for Pices/Discounts]
,[T$pstx] as [Supplier for Texts]
,[T$refs] as [Sales Reference]
,[T$refa] as [Accounting Reference]
,[T$ocus] as [Our Customer Number]
,[T$telp] as Telephone
,[T$telx] as Telex 
,[T$tefx] as Fax 
,[T$clan] as [Language]
,[T$cbrn] as [Line of Busines]
,(select T$DSCA from ttcmcs002180 where T$ccur=vw_Supplier_info.T$ccur) as Currency 
,[T$cotp] as [Order Type] 
,(case [T$inrl] when '1' then 'Yes' when '2' then 'No' else '' end)  as [Affiliated Company]
,[T$iscn] as [Affiliated Company No]
,[T$creg] as [Area]
,[T$ccon] as [Contact(Purchase)]
,[T$cfcc] as [Factoring Company]
,[T$fano] as [Customer Number at Factor.Co.]
,[T$cplp] as [Purchase Price List]
,(select T$DSCA from ttcmcs013180 where REPLACE(T$cpay,' ','')=REPLACE(vw_Supplier_info.T$cpay,' ','')) as [Terms Of Payment]
,[T$cdec] as [Terms of Delivery]
,[T$ccrs] as [Late Payment Surcharge]
,(select T$DESC from ttfcmg003180 where T$PAYM=vw_Supplier_info.T$PAYM) as [Payment Method]
,[T$eded] as [Extra Days after Due Date]
,(select T$DESC from ttfacp001180 where REPLACE(T$FISU,' ','')=REPLACE(vw_Supplier_info.T$cfsg,' ','')) as [Financial SupplierGroup]
,[T$odis] as [Order Discount]
,[T$cuno] as [Customer]
,(case [T$subc] when '1' then 'Yes' when '2' then 'No' else '' end) as [Subcontracting]
,(case [T$qual] when '1' then 'Yes' when '2' then 'No' else '' end) as [Inspection]
,(case [T$cvyn] when '1' then 'Yes' when '2' then 'No' else '' end) as [Tax]
,[T$fovn] as [Tax Number]
,(select T$BANO from ttccom025180 where T$SUNO=vw_Supplier_info.T$SUNO AND T$CBAN=vw_Supplier_info.T$CBAN) as Bank 
,[T$buor] as [Order Balance]
,[T$buin] as [Invoice Balance]
,(case [T$sust] when '1' then 'Actual' when '2' then 'Potential' when '3' then 'Purchase Entry Blocked' when '4' then 'Payments Blocked' when '5' then 'Paym. & Purch. Entr. B1.' end) as [Supplier Status] 
  FROM vw_Supplier_info

GO

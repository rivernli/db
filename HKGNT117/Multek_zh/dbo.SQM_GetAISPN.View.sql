USE [Multek_ZH]
GO
/****** Object:  View [dbo].[SQM_GetAISPN]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[SQM_GetAISPN]
as
select item,vdor,mafr,loca,mats,dsca,dwid+wuni+'X'+dlen+luni as LWSize,'Board' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,'' AS RoHS,'' AS HF from MCNNT801.MULTEK_BI.dbo.tAttr_board
UNION ALL 
select item,vdor,mafr,loca,mats,dsca,dwid+wuni+'X'+dlen+luni as LWSize,'Foil' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS, RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_foil
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dwid+wuni+'X'+dlen+luni as LWSize,'DryFilm' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4, '' AS STS,'' AS RoHS,'' AS HF from MCNNT801.MULTEK_BI.dbo.tAttr_dryfilm
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dwar+dwun+'X'+dfil+dfun as LWSize,'Laminate' as PNType,vdpn AS w0, dctk AS w1,cons AS w2,cutk AS w3,cutr AS w4,stsa AS STS, RoHS,hal3 as HF FROM  MCNNT801.MULTEK_BI.dbo.tAttr_laminate 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dwar+dwun+'X'+dfil+dfun as LWSize,'Prepreg' as PNType,vdpn AS w0, atyp AS w1,rcpc AS w2,rohs AS w3,lsdr AS w4,stsa AS STS,RoHS,hal3 as HF from  MCNNT801.MULTEK_BI.dbo.tAttr_prepreg 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dwid+wuni+'X'+dlen+luni as LWSize,'RCC' as PNType, vdpn AS w0, Plyu AS w1, rohs AS w2, hal3 AS w3, '' AS w4,stsa AS STS,RoHS,hal3 as HF from  MCNNT801.MULTEK_BI.dbo.tAttr_rcc
UNION ALL
select item,vdor,mafr,loca,mats,dsca,sfun as LWSize ,'SMCM' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_smcm
UNION ALL 
select item,vdor,mafr,loca,mats,dsca,ddia+diun+'X'+dfln+flun as LWSize,'Tools' as PNType, vdpn AS w0, ddia+diun AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,'' AS RoHS,'' AS HF from  MCNNT801.MULTEK_BI.dbo.tAttr_tools
UNION ALL
select item,vdor,mafr,loca,mats,dsca, dscc as LWSize,'General' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_general 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dmtd+duni+'X'+dmmd+muni as LWSize,'Fccl' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_fccl 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dmtd+duni+'X'+dmmd+muni as LWSize,'Coverlay' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_coverlay
UNION ALL 
select item,vdor,mafr,loca,mats,dsca,dmtd+duni+'X'+dmmd+muni as LWSize,'Adhesive' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_adhesive 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dmtd+duni+'X'+dmlg+luni as LWSize,'Stiffener' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_stiffener
UNION ALL 
select item,vdor,mafr,loca,mats,dsca,dmtd+duni+'X'+dmlg+luni as LWSize,'Sheildling_film' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_sheildling_film
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dscc as LWSize,'Chemical' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_chemical 
UNION ALL
select item,'' as vdor,mafr,'' as loca,mats,dsca,'' as LWSize,'SMD' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_smd 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dscc as LWSize,'Metal' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_metal
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dscc as LWSize,'Packing' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS,'' AS RoHS,'' AS HF from MCNNT801.MULTEK_BI.dbo.tAttr_packing 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dscc as LWSize,'PCBA Packing' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,stsa AS STS, '' as RoHS,'' as HF from MCNNT801.MULTEK_BI.dbo.tAttr_packing WHERE uses = 'PCBA'
UNION ALL
select item,vdor,mafr,loca,mats,dsca,dscc as LWSize,'Coin' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,RoHS,hal3 as HF from MCNNT801.MULTEK_BI.dbo.tAttr_coin 
UNION ALL
select item,vdor,mafr,loca,mats,dsca,'' as LWSize,'Non Prod' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,'' as RoHS,'' as HF from MCNNT801.MULTEK_BI.dbo.tAttr_non_inventory
UNION ALL
select item,vdor,mafr,loca,mats,dsca,'' as LWSize,'NIV-Non Inventory' as PNType,''AS w0,''AS w1,'' AS w2,'' AS w3,'' AS w4,'' AS STS,'' as RoHS,'' as HF from MCNNT801.MULTEK_BI.dbo.tAttr_non_inventory WHERE item <> 'NIV-I-PRODCONS'


GO

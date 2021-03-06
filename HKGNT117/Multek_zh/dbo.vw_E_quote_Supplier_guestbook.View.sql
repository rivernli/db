USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_E_quote_Supplier_guestbook]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[vw_E_quote_Supplier_guestbook]
as
select 
(select Email from E_quote_Users where UserID=Initiator) as Email,
(select Mobile from E_quote_Users where UserID=Initiator) as Mobile,
(select tel from E_quote_Users where UserID=Initiator) as Tel,
(select BDM from E_quote_Users where UserID=Initiator) as RealName,'' as VendorCode,'' as CorpName,
'' as Ip_address,Initiator_Date as Posted_Date,Pur_Content as Remark, '-1' as guestbookId,id as Pur_Id,Attachment
 from E_quote_New_Purchase 

union all

select b.Email,b.Mobile,b.Tel,b.RealName,VendorCode,VendorName as CorpName, 	
	a.Ip_address,a.Posted_Date,a.Remark,a.ID as guestbookId,Pur_Id,a.Attachment
	from E_quote_Supplier_guestbook a  
	LEFT JOIN E_quote_SupplierUser b on a.Email=b.Email






GO

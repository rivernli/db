USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_CusOEMUpdate]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_CusOEMUpdate]
@CusOEM nvarchar(100),
@BaanId int,
@salesmanId int,
@OEMID int,
@isValid bit,
@viewsalesmanId int =0
as 

insert into gam_oem_changelog (cusOEM,baanid,salesmanId,oemid,isvalid,viewsalesmanId)
select cusoem,baanid,salesmanId,OEMID,isvalid,viewsalesmanId from gam_oem where OEMID=@OEMID

Update gam_OEM set CusOEM=@CusOEM,
BaanId=@BaanId,
SalesmanId=@salesmanId,
isValid=@isValid,
viewsalesmanId=@viewsalesmanId
where OEMID=@OEMID



GO

USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_CusOEMAdd]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_CusOEMAdd]
@CusOEM nvarchar(100),
@BaanId int,
@salesmanId int,
@viewsalesmanId int=0,
@OEMID int output
as 
insert into gam_oem (CusOEM,BaanId,SalesmanId,viewsalesmanId)
values (@CusOEM,@BaanId,@salesmanId,@viewsalesmanId);
set @OEMID = scope_identity();

GO

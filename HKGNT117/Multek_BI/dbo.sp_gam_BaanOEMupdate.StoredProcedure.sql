USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_BaanOEMupdate]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_gam_BaanOEMupdate]
@groupname nvarchar(50),
@oemid int
as 
update gam_baanoemlist
set GroupName=@groupname
where BaanOEMId=@oemid
GO

USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_getCEM_OEMs]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create procedure [dbo].[sp_gam_getCEM_OEMs]
 as

select baanName from gam_cem_oemName order by baanName
GO

USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_getSalesEmail]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_SGP_getSalesEmail] @sales nvarchar(30)
as 
set nocount on
select email,manager,memail from sgp_acl where name=@sales

set nocount off
GO

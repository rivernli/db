USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDelUserProfile]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create procedure [dbo].[sp_ITAppsDelUserProfile] 
@uid char(8),@domain varchar(12)
as
set nocount on;
	delete ITAppsUserProfile where uid=@uid and domain=@domain
set nocount off;

GO

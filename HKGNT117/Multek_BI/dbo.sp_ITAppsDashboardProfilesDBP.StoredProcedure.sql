USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDashboardProfilesDBP]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_ITAppsDashboardProfilesDBP]
as
select DBPId,Title,parentId,isItem from dbo.ITAppsDashboardProfiles where isItem=0 order by sortDesc 

GO

USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsGetsuggest]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_ITAppsGetsuggest] @key nvarchar(500)
as
select top 20 appName from itapps where appName like '%'+@key+'%'
and isActive=1 and url <>''


GO

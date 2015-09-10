USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInventoryDetail_getSelectItems]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_HubInventoryDetail_getSelectItems]
	@objectField nvarchar(100),
	@keyword nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar (1000);
	set @sql = 'select top 30 * from (select distinct '+ ltrim(rtrim(@objectField)) +' from vw_4RP_HubInventoryForMkt'+
	' where '+ ltrim(rtrim(@objectField)) +' like ''%' + ltrim(rtrim(@keyword)) +'%'') as t '
	execute(@sql)


END

	


GO

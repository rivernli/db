USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_SalesAmount_SelectedItem]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from dbo.TFSOLP147180

CREATE proc [dbo].[sp_SalesAmount_SelectedItem]
@field nvarchar(50),
@keyword   nvarchar(10)
as
 declare	@sql nvarchar(1000)
	set @sql = 'select distinct('+@field+') from TFSOLP147180 where '+@field+ ' like ''%'+ltrim(rtrim(@keyword))+'%'' order by '+@field
	execute(@sql)
GO

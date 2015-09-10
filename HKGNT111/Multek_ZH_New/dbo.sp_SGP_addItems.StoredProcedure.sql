USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_addItems]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_SGP_addItems] @item nvarchar(500),@itype varchar(50)
AS

if not exists(select 1 from dbo.sgp_item where itype=@itype and item=@item)
	insert into sgp_item (itype,item,flag) values (@itype,@item,0)
GO

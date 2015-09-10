USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[updateTable]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from dbo.TFSOLP123180

CREATE proc [dbo].[updateTable]
@vend nvarchar(50)
as
begin
declare @item nvarchar(50)
declare temp_item CURSOR for 
select item from DBa.dbo.tableA where vend = @vend
open temp_item
fetch next from temp_item into @item
	WHILE @@FETCH_STATUS=0
		BEGIN
			 tran
				delete from DBb.dbo.tableB where item = @item
				insert into DBb.dbo.tableB select * from DBa.dbo.tableA where item = @item

				begin commit tran

				fetch next from temp_item into @item
		END
	close temp_item
	deallocate temp_item
END



 



GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[update_SMD_manufature]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[update_SMD_manufature]
as
declare @item nvarchar(50)
declare @man nvarchar(200)
declare @manpn nvarchar(200)
declare @fman nvarchar(50)
declare @fmanpn nvarchar(50)
declare @str nvarchar(2000)
declare @strTemp nvarchar(2000)
declare @Titem nvarchar(50)
declare @i int
declare @j int
set @i = 1
set @j = 1
set @Titem = 'ABCD'
truncate table fifam020180
insert into fifam020180(T$item,T$mitm,T$mapn) select T$item,T$mitm,T$manu from tfifam020180 group by T$item,T$mitm,T$manu order by T$item,T$mitm,T$manu
update a set a.T$manu = b.T$desc from fifam020180 a ,tfifam002180 b where a.T$mapn = b.T$manu
truncate table manu 
insert into manu(item) select  T$item from  fifam020180 group by T$item
declare cur cursor for

select T$item,T$mitm,T$manu from fifam020180  group by  T$item,T$mitm,T$manu  order by T$item, T$mitm, T$manu
open cur
fetch next from cur into @item, @manpn,@man
while @@fetch_status = 0
begin 
	if	@i<11
	begin 
		if	@Titem <> @item
			begin
				set @i = 1
				set @Titem = @item
			end
			set @fman = 'man'+CAST(@i AS VARCHAR)
			set @fmanpn = 'manpn'+CAST(@i AS VARCHAR)
			set @str = 'update manu set '+@fman+' ='+''''+@man+''''+ ','+@fmanpn+ ' = '+''''+@manpn+''''+' where item = '+''''+@item+''''
			
		set @j = @j +1
		execute(@str)
	end
	if	(@Titem = 'ABCD' or @Titem = @item)	
		begin
			set @Titem = @item
            if	@i < 9
				begin
					set @i = @i + 1 
				end
		end
	fetch next from cur into @item,@manpn,@man
end

close cur
deallocate cur




GO

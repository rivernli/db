USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_CopyTableToLinkServer]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_CopyTableToLinkServer] @table nvarchar(255),@linkedServer nvarchar(255),@db nvarchar(255)
as
set nocount on
	declare @sqlStr nvarchar(max)
	declare @sqltbl table (s varchar(1000),id int identity,mid int default 1)
	
	insert into @sqlTbl (s) values ('create table ['+@table +'] (')
	
	insert into @sqltbl(s) select ' ['+ column_name+'] '+ data_type + 
	case when character_maximum_length > 0 then
		coalesce('('+ cast(character_maximum_length as varchar)+')','') + ' ' 
	else
		' '
	end +
	case when exists (
		select id from syscolumns 
		where object_name(id)=@table and name=column_name and 
		columnproperty(id,name,'IsIdentity')=1
	)then 'IDENTITY('+ cast(ident_seed(@table) as varchar) +','+ cast(ident_incr(@table) as varchar)+')'
	else '' end +
	' '+ (case when IS_NULLABLE='No' then 'NOT ' else '' end) +'NULL '+ coalesce('DEFAULT '+  column_default,'')+', '
	from information_schema.columns where table_name=@table order by ordinal_position
	
	insert into @sqlTbl (s) values (')')
	
	select @sqlStr = coalesce(@sqlStr +' ','')+s from @sqltbl order by id
	select @sqlStr = case when isnull(@linkedServer,'')='' then '' else @linkedServer +'.' end +'['+@db +']..sp_executesql N'''+@sqlStr +''' '
	execute(@sqlStr)
	--select @sqlStr
	delete @sqltbl
set nocount off
GO

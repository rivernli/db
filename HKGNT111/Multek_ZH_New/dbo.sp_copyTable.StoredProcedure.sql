USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_copyTable]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_copyTable]
@fromServer nvarchar(255),@fromDB nvarchar(255),@table nvarchar(255),@myServer nvarchar(255),@myDB nvarchar(255)
as



declare @script nvarchar(max),@sp_name nvarchar(100),@sqlStr nvarchar(max), @ex nvarchar(max)

set @sp_name='sp_CopyTableToLinkServer'
select @ex = case when isnull(@fromServer,'')='' then '' else @fromServer +'.' end +'['+@fromDB +']'



select @sqlStr = 'IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE=''BASE TABLE'' AND TABLE_NAME='''+@table +''') select ''table exists''; return'--drop table '+ @table
exec sp_executesql @sqlStr
select @sqlStr=N'exec '+@ex +N'..'+@sp_name+' @table='''+ @table+''',@linkedServer='''+@myServer+''',@db='''+@myDB+''' '
exec sp_executesql @sqlStr



declare @fields nvarchar(max),@id_exists bit
select @fields='',
@id_exists =case when exists (select id from syscolumns where object_name(id)=@table and columnproperty(id,name,'IsIdentity')=1)
then 1 else 0 end,
@sqlStr = N'select @fieldx = @fieldx +'',''+ name from syscolumns where object_name(id)=@tablex order by colid'
exec sp_executesql @sqlStr,N'@fieldx nvarchar(max) output,@tablex nvarchar(255)',@fieldx=@fields output,@tablex=@table 

select @fields=substring(@fields,2,len(@fields)-1)

if @id_exists = 1 
	select @sqlStr = N'SET IDENTITY_INSERT '+@table +' ON;'+
		'insert into '+@table +' (' +@fields +') select '+ @fields +' from ' + @ex+'.dbo.'+@table +
		';SET IDENTITY_INSERT '+@table +' OFF; select top 10 * from '+ @table	
else
	select @sqlStr = N'insert into '+@table +' (' +@fields +') select '+ @fields +' from ' + @ex+'.dbo.'+@table +
		'; select top 10 * from '+ @table	

exec sp_executesql @sqlStr
GO

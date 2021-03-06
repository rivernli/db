USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_copyTable]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_copyTable] 
@fromServer nvarchar(255),@fromDB nvarchar(255),@table nvarchar(255),@myServer nvarchar(255),@myDB nvarchar(255) 
as
  
select 'Copy a table from out side server to current execute server DB. is COPY From. not Copy to.'
return; 
  
  
/* 
declare @fromServer nvarchar(255),@fromDB nvarchar(255),@table nvarchar(255),@myServer nvarchar(255),@myDB nvarchar(255) 
select @fromServer='hkgnt105',@fromDB='multek',@table='tSalesQuotes_history',@myServer='hkgnt117',@myDb='multek_bi'
*/ 
  
declare @script nvarchar(max),@sp_name nvarchar(100),@sqlStr nvarchar(max), @ex nvarchar(max) 
  
set @sp_name='sp_CopyTableToLinkServer'
select @ex = case when isnull(@fromServer,'')='' then '' else @fromServer +'.' end +'['+@fromDB +']'
  
  
select @sqlStr = @ex+'..sp_executesql N''if exists(SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'''''+@sp_name+''''') AND type in (N''''P'''', N''''PC'''')) drop procedure '+@sp_name +''' '
execute(@sqlStr) 
  
SELECT @script=ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE='PROCEDURE' and specific_name =@sp_name 
  
  
select @sqlStr = @ex +'..sp_executesql N'''+replace(@script,'''','''''') +''' '
execute(@sqlStr) 
  
select @sqlStr = 'IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE=''BASE TABLE'' AND TABLE_NAME='''+@table +''') drop table '+ @table
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
  
select @sqlStr = @ex+'..sp_executesql N''if exists(SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'''''+@sp_name+''''') AND type in (N''''P'''', N''''PC'''')) drop procedure '+@sp_name +''' '
execute(@sqlStr) 

GO

USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_BaanOEMsSearching]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_BaanOEMsSearching]
@key nvarchar(50)='',
@top int= 0,
@group nvarchar(50)= '',
@id int = 0
as 

if(@id > 0)
	select * from gam_baanoemlist where BaanOEMID=@id

else
begin

declare @sql nvarchar(1000)
set @sql = 'select * from gam_baanoemlist where baanoemid > 0 ' 
if(@top > 0)
	set @sql = 'select top '+ cast(@top as varchar(10)) +' * from gam_baanoemlist where baanoemid >0 '

if(@key <> '')
	set @sql = @sql +' and oemname like N''%'+ @key+ '%'' '

if(@group <> '')
	set @sql = @sql +' and groupName = '''+ @group +''' '


set @sql = @sql + ' order by groupName,oemname'


exec(@sql)
end

GO

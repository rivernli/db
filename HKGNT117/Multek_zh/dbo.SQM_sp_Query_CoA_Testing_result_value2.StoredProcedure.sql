USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Query_CoA_Testing_result_value2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SQM_sp_Query_CoA_Testing_result_value2]
	@ITEM VARCHAR(50)=NULL,
	@UPRN VARCHAR(50)=NULL,
	@Vers VARCHAR(50)=NULL 
AS

SET NOCOUNT ON


select * into #temp from 
(
select replace(a.T$CAID,'!','') as T$CAID,
(case when a.T$CAD2 is null then 'NA' when a.T$CAD2 = '-----' then 'NA' when a.T$CAD2 like '%F:--%' then 'NA' else a.T$CAD2+b.T$CUN2 end) as T$CAD2 
from tfspur019180 a Left JOIN TFSITM034180 b ON b.T$CAID=a.T$CAID where a.T$ITEM=@ITEM AND a.T$UPRN=@UPRN AND a.T$TYPE='1' 
AND b.T$VERS=@Vers 
) tb

declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + T$CAID from #temp
set @sql = '[' + @sql + ']'

exec ('select * from (select * from #temp) a pivot (max(T$CAD2) for T$CAID in (' + @sql + ')) b') 
GO

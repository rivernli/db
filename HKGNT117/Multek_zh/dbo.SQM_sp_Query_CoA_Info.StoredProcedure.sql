USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Query_CoA_Info]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[SQM_sp_Query_CoA_Info]
	@ITEM VARCHAR(50)=NULL,
	@Vers VARCHAR(50)=NULL,
	@UPRN VARCHAR(50)=NULL 
AS

SET NOCOUNT ON


select * into #temp from 
(
select replace(T$CAID,'!','') as T$CAID,T$CAD1 from tfspur019180 where T$ITEM=@ITEM 
AND T$UPRN=@UPRN AND T$CAID<>'#STLT!'
group by T$CAID,T$CAD1 
) tb

declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + T$CAID from #temp
set @sql = '[' + @sql + ']'

exec ('select * from (select * from #temp) a pivot (max(T$CAD1) for T$CAID in (' + @sql + ')) b') 


 
GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Query_CoA_VALU]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SQM_sp_Query_CoA_VALU]
	@Vers VARCHAR(50)=NULL
AS

SET NOCOUNT ON


select * into #temp from 
(
select replace(T$CAID,'!','') as T$CAID,T$VALU from TFSITM034180 where T$TYPE='1' AND T$VERS=@Vers 
) tb

declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + T$CAID from #temp
set @sql = '[' + @sql + ']'

exec ('select * from (select * from #temp) a pivot (max(T$VALU) for T$CAID in (' + @sql + ')) b')










GO

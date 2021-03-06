USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Query_CoA_Item]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SQM_sp_Query_CoA_Item]
	@type VARCHAR(5)=NULL,
	@field NVARCHAR(50)=NULL,
	@keyword NVARCHAR(50)=NULL 
AS
SET NOCOUNT ON 

	declare @sql nvarchar (1000);
	
	set @sql = 'select top 30 * from (select distinct T$CAD1 from tfspur018180 a
				INNER JOIN tfspur019180 b ON b.T$UPRN=a.T$UPRN AND b.T$ITEM=a.T$ITEM 
				where b.T$CAID='''+@field+''' AND b.T$CAD1 like ''%' + ltrim(rtrim(@keyword)) +'%'') as t '
	execute(@sql)
GO

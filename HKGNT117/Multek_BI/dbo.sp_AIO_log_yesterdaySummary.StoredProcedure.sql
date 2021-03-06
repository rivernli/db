USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_AIO_log_yesterdaySummary]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_AIO_log_yesterdaySummary]
as
set nocount on
declare @yesterday int
set @yesterday = convert(nvarchar(8),getdate()-1,112)

delete ITApps_LogAnalyst where logDate=@yesterday
insert into ITApps_LogAnalyst
select logType,count(logType) as num,@yesterday as dd from dbo.vw_AIO_Log 
where convert(nvarchar(8),actionTime ,112) = @yesterday group by logType

select userName,logtype,count(action) as access_count 
from dbo.vw_AIO_log_with_name
where CONVERT(varchar(8), actionTime, 112)  = @yesterday
group by userName,logtype
order by userName,logtype
set nocount off

GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HUBINV_getLog]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_HUBINV_getLog] 
	@type tinyint ,
	@key nvarchar(50),
	@startDate datetime,
	@endDate datetime
AS
BEGIN
	set @endDate = @endDate +1
	if(@type = 1)
		select top 1000 * from HUBINV_log where uid = @key and actiontime between @startDate and @endDate order by log_id desc
	if(@type=2)
		select top 1000 * from HUBINV_log where [action] = @key and actiontime between @startDate and @endDate order by log_id desc
	if(@type=0)
		select top 1000 a.* from HUBINV_log AS a INNER JOIN dbo.HUBINV_nUser AS b ON a.uid = b.uid 
		WHERE (b.hideFrLog = 0) and actiontime between @startDate and @endDate order by log_id desc
END










GO

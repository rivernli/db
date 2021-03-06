USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MCOS_getLog]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MCOS_getLog] 
	@type tinyint ,
	@key nvarchar(50),
	@startDate datetime,
	@endDate datetime
AS
BEGIN
	/*	0 nothing get all result, 
		1 search by user, 
		2 search by action 
	*/
	set @endDate = @endDate +1
	if(@type = 1)
		select top 1000 * from MCOS_log where uid = @key and actiontime between @startDate and @endDate order by log_id desc
	if(@type=2)
		select top 1000 * from MCOS_log where [action] = @key and actiontime between @startDate and @endDate order by log_id desc
	if(@type=0)
		select top 1000 a.* from MCOS_log AS a INNER JOIN dbo.MCOS_nUser AS b ON a.uid = b.uid 
		WHERE (b.hideFrLog = 0) and actiontime between @startDate and @endDate order by log_id desc
		--select top 1000 * from MCOS_log where actiontime between @startDate and @endDate order by log_id desc
END









GO

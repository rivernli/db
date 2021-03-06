USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_sp_getLog]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Cost_Sheet_Query_sp_getLog] 
	@type tinyint ,
	@key nvarchar(50),
	@startDate datetime,
	@endDate datetime
AS
BEGIN
	set @endDate = @endDate +1
	if(@type = 1)
		select top 1000 * from Cost_Sheet_Query_log where uid = @key and actiontime between @startDate and @endDate order by log_id desc
	if(@type=2)
		select top 1000 * from Cost_Sheet_Query_log where [action] = @key and actiontime between @startDate and @endDate order by log_id desc
	if(@type=0)
		select top 1000 a.* from Cost_Sheet_Query_log AS a INNER JOIN dbo.Cost_Sheet_Query_Users AS b ON a.uid = b.UserID 
		WHERE (b.hideFrLog = 0) and actiontime between @startDate and @endDate order by log_id desc
END











GO

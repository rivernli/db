USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_AIO_getLog]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_AIO_getLog] 
	@type tinyint ,
	@key nvarchar(50),
	@startDate datetime,
	@endDate datetime,
	@loginOnly bit = 0
AS
BEGIN
	set @endDate = @endDate +1
/*
	if(@type = 1)
		select top 1000 * from vw_AIO_Log where uid = @key and actiontime between @startDate and @endDate order by actionTime desc
	if(@type=2)
		select top 1000 * from vw_AIO_Log where [action] = @key and actiontime between @startDate and @endDate order by actionTime desc
	if(@type=0)
		select top 1000 * from vw_AIO_Log where actiontime between @startDate and @endDate order by actionTime desc
*/
	if(@loginOnly =0)
	begin
		if(@type = 1)
			select top 1000 * from vw_AIO_Log_with_name where uid = @key and actiontime between @startDate and @endDate order by actionTime desc
		if(@type=2)
			select top 1000 * from vw_AIO_Log_with_name where [action] = @key and actiontime between @startDate and @endDate order by actionTime desc
		if(@type=3)
			select top 1000 * from vw_AIO_Log_with_name where (uid like '%'+@key+'%' or userName like '%'+@key+'%') and actiontime between @startDate and @endDate order by actionTime desc
		if(@type=0)
			select top 1000 * from vw_AIO_Log_with_name where actiontime between @startDate and @endDate order by actionTime desc
	end
	else
	begin
		if(@type = 1)
			select top 1000 * from vw_AIO_Log_with_name where action ='login' and uid = @key and actiontime between @startDate and @endDate order by actionTime desc
		if(@type=2)
			select top 1000 * from vw_AIO_Log_with_name where action ='login' and [action] = @key and actiontime between @startDate and @endDate order by actionTime desc
		if(@type=3)
			select top 1000 * from vw_AIO_Log_with_name where action ='login' and (uid like '%'+@key+'%' or userName like '%'+@key+'%') and actiontime between @startDate and @endDate order by actionTime desc
		if(@type=0)
			select top 1000 * from vw_AIO_Log_with_name where action ='login' and actiontime between @startDate and @endDate order by actionTime desc
	end
END



GO

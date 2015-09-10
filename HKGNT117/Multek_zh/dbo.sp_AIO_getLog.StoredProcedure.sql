USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_AIO_getLog]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_AIO_getLog] 
	@type tinyint ,
	@key nvarchar(50),
	@startDate datetime,
	@endDate datetime
AS
BEGIN
	set @endDate = @endDate +1
	if(@type = 1)
		select top 1000 * from vw_AIO_Log where uid = @key and actiontime between @startDate and @endDate order by actionTime desc
	if(@type=2)
		select top 1000 * from vw_AIO_Log where [action] = @key and actiontime between @startDate and @endDate order by actionTime desc
	if(@type=0)
		select top 1000 * from vw_AIO_Log where actiontime between @startDate and @endDate order by actionTime desc
END













GO

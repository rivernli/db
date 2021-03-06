USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Traceability_LogGet]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[sp_Traceability_LogGet] 
	@Value	VARCHAR(500)
AS
BEGIN

	if(@Value='')
		SELECT TOP 50 
			[log_id]
			,[domain]
			,[uid]
			,[actionTime]
			,[action]
			,[description]
			,[url]
			,[session_id]
		FROM [Traceability_Log]
	ELSE
		SELECT TOP 50 
			[log_id]
			,[domain]
			,[uid]
			,[actionTime]
			,[action]
			,[description]
			,[url]
			,[session_id]
		FROM [Traceability_Log]
		WHERE [uid] LIKE '%'+@Value+'%' 
			OR [domain] LIKE '%'+@Value+'%'
			OR [action] LIKE '%'+@Value+'%'
			OR [description] LIKE '%'+@Value+'%'
			OR [url] LIKE '%'+@Value+'%'
		ORDER BY log_id desc
END


GO

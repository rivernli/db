USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_LogGet]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Exr2_LogGet] 
	@Value	VARCHAR(500)
AS
BEGIN

	if(@Value='')
		SELECT TOP 50 
			a.[log_id]
			,a.[domain]
			,a.[uid]
			,b.[name]
			,a.[actionTime]
			,a.[action]
			,a.[description]
			,a.[url]
			,a.[session_id]
		FROM [Exr2_Log] AS a LEFT JOIN [Exr2_User] AS b
		ON a.[domain]=b.[domain] AND a.[uid]=b.[uid]
		ORDER BY a.[log_id] DESC
	ELSE
		SELECT TOP 50 
			a.[log_id]
			,a.[domain]
			,a.[uid]
			,b.[name]
			,a.[actionTime]
			,a.[action]
			,a.[description]
			,a.[url]
			,a.[session_id]
		FROM [Exr2_Log] AS a LEFT JOIN [Exr2_User] AS b
		ON a.[domain]=b.[domain] AND a.[uid]=b.[uid]
		WHERE a.[uid] LIKE '%'+@Value+'%' 
			OR a.[domain] LIKE '%'+@Value+'%'
			OR b.[name] LIKE '%'+@Value+'%'
			OR a.[action] LIKE '%'+@Value+'%'
			OR a.[description] LIKE '%'+@Value+'%'
			OR a.[url] LIKE '%'+@Value+'%'
		ORDER BY a.[log_id] DESC
END


GO

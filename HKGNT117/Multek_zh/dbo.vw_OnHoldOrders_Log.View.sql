USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_OnHoldOrders_Log]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[vw_OnHoldOrders_Log]
as
SELECT
	FullName AS UID,
	ActionDate AS ActionTime,
	[Action] AS [Action],
	ActionDetail AS [Description],
	ActionUrl AS Url,
	'OnHoldOrders' AS LogType
FROM OnHoldOrders_Log

GO

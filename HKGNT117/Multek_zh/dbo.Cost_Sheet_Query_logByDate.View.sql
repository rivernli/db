USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Cost_Sheet_Query_logByDate]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Cost_Sheet_Query_logByDate]
as
SELECT     a.iDate, a.uid, a.ActivityCount, b.BDM as UserName
FROM         (SELECT     CONVERT(varchar(8), actionTime, 112) AS iDate, uid, COUNT(uid) AS ActivityCount
                       FROM          dbo.Cost_Sheet_Query_log
                       GROUP BY CONVERT(varchar(8), actionTime, 112), uid) AS a INNER JOIN
                      dbo.Cost_Sheet_Query_Users AS b ON a.uid = b.UserID
WHERE     (b.hideFrLog = 0)
GO

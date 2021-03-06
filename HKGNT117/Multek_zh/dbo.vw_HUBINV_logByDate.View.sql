USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_HUBINV_logByDate]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_HUBINV_logByDate]
AS
SELECT     a.iDate, a.uid, a.ActivityCount, b.userName
FROM         (SELECT     CONVERT(varchar(8), actionTime, 112) AS iDate, uid, COUNT(uid) AS ActivityCount
                       FROM          dbo.HUBINV_log
                       GROUP BY CONVERT(varchar(8), actionTime, 112), uid) AS a INNER JOIN
                      dbo.HUBINV_nUser AS b ON a.uid = b.uid
WHERE     (b.hideFrLog = 0)


GO

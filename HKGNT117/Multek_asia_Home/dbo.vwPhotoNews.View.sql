USE [Multek_AsiaHome]
GO
/****** Object:  View [dbo].[vwPhotoNews]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwPhotoNews]
AS
SELECT
a.*,
b.Ph_OnHome,
b.Ph_Path
FROM dbo.Mul_PhotoNews a
INNER JOIN dbo.Mul_PhotoNews_Photo b
ON a.Pn_Id = b.Ph_ReferId








GO

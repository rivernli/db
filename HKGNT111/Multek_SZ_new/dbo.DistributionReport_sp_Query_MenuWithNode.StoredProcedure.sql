USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_MenuWithNode]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_MenuWithNode]
AS

SET NOCOUNT ON

--Get menus
SELECT b.* 
FROM (
		SELECT '00000' AS NodeCode, 'System Menu' AS NodeName,NULL AS ParentNodeCode
		UNION
		SELECT a.ID AS NodeCode ,
			a.Description AS NodeName,
			 (
				CASE LEN(a.ID) WHEN 5 THEN '00000' ELSE (SELECT ID FROM Menu WHERE ID=LEFT(a.ID,LEN(a.ID)-5)) END
			 ) AS ParentNodeCode
		FROM Menu a
	) b
ORDER BY b.NodeCode
GO

USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Multek_IE_ME_ProjectList]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[Multek_IE_ME_ProjectList]
AS
SELECT 	(CASE T$PLNT WHEN 'P1' THEN 'B1' 
					WHEN 'P2' THEN 'B1' 
					WHEN '12' THEN 'B3' 
					WHEN '2F' THEN 'B2F' ELSE T$PLNT END) AS PLANT
,T$ICOD,T$PITM,T$PSPL,CAST(T$SQPL AS DECIMAL(18,4)) AS T$SQPL,T$PRJ1
--(SELECT TOP 1 100-T$busp FROM dbo.TFSBOM400180 WHERE t$pjno = t$prj1 and t$stat = 2 order by t$sern desc) AS Yield  --//IE Team request change logic
--(SELECT TOP 1 100-(case t$mr13 when 0 then t$masp when 100 then t$masp else t$mr13 end) FROM dbo.TFSBOM400180 WHERE t$pjno = t$prj1 and t$stat = 2 order by t$sern desc) AS Yield
--dbo.fun_Multek_IE_ME_ProjectList_Yield(t$prj1) as Yield
FROM DBO.TTIWIP006180
WHERE T$PLNT <> 'HK'



GO

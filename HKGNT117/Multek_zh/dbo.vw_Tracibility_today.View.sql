USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_Tracibility_today]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Tracibility_today]
AS
	SELECT 
		T$PLNT,
		T$LTNO,
		T$CWOC,
		T$SEQU,
		T$MACH,
		T$MATR,
		(SELECT A.T$DSCA FROM dbo.TTCMCS023180 AS a,FactoryLoading.dbo.TTIITM001180 AS B WHERE a.t$citg = b.t$citg and b.t$item = t$matr) AS t$DDEC,
		(SELECT T$SUNO FROM FactoryLoading.dbo.TTIITM001180 WHERE t$item = t$matr) AS T$suno,
		(SELECT A.T$NAMA FROM dbo.TTCCOM020180 AS a ,FactoryLoading.dbo.TTIITM001180 AS b WHERE a.t$suno = b.t$suno and b.t$item = t$matr) AS t$DESC,
		T$TOOL,
		T$REMK,
		--T$DATE,
		CONVERT(VARCHAR(10),T$DATE,120) AS T$DATE,
		(case len(T$TIME)
			when 4 then '0'+CAST(LEFT(T$TIME,1) AS NVARCHAR(1))+':0'+CAST(right(left(T$TIME,2),1) as NVARCHAR(1))+':'+CAST(RIGHT(T$TIME,2) AS NVARCHAR(2))
			when 5 then '0'+CAST(LEFT(T$TIME,1) AS NVARCHAR(1))+':'+CAST(right(left(T$TIME,3),2) as NVARCHAR(2))+':'+CAST(RIGHT(T$TIME,2) AS NVARCHAR(2))
			when 6  then CAST(LEFT(T$TIME,2) AS NVARCHAR(2))+':'+CAST(right(left(T$TIME,4),2) as NVARCHAR(2))+':'+CAST(RIGHT(T$TIME,2) AS NVARCHAR(2)) END
		) AS T$TIME,
		T$USER,
		T$MBCD,
		T$DCDE,
		T$PCDE,
		T$PROJ,
		T$PJNO,
		T$MNWC,
		T$BCDE,
		T$TQTY,
		T$TRCD,
		T$OULN,
		T$SPLN,
		T$STMP,
		T$MTYP,
		T$LCQT
	FROM dbo.TTIWIP615180 
	 WHERE t$date in 
	(SELECT distinct TOP 2 t$date FROM dbo.TTIWIP615180 ORDER BY T$DATE DESC)



GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Tracibility_job_update]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Tracibility_job_update]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		-- Today Date
		TRUNCATE TABLE Tracibility_today
		INSERT INTO Tracibility_today
		SELECT * FROM vw_Tracibility_today
		
		-- Plant
		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('Multek_ZH.dbo.Tracibility_plant') AND TYPE = 'U')
			BEGIN
				SELECT T$PLNT INTO Tracibility_plant FROM TTIWIP615180 GROUP BY T$PLNT
				CREATE INDEX Index1_Plant ON Tracibility_plant (T$Plnt)
			END
		ELSE
			BEGIN
				INSERT INTO Tracibility_plant
				SELECT T$PLNT FROM TTIWIP615180 
				WHERE T$PLNT NOT IN(SELECT T$PLNT FROM Tracibility_plant)
				GROUP BY T$PLNT
			END
		END
--		INSERT INTO Tracibility_plant(T$PLNT) VALUEs('')

		-- Project 
		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('Multek_ZH.dbo.Tracibility_project') AND TYPE = 'U')
			BEGIN
				SELECT T$PJNO INTO Tracibility_project FROM TTIWIP615180 GROUP BY T$PJNO
				CREATE INDEX Index1_Proj ON Tracibility_project (T$PJNO)
			END
		ELSE
			BEGIN
				INSERT INTO Tracibility_project
				SELECT T$PJNO FROM TTIWIP615180 
				WHERE T$PJNO NOT IN(SELECT T$PJNO FROM Tracibility_project)
				GROUP BY T$PJNO
			END

		-- Traceability details
			TRUNCATE TABLE Traceability_Details
			INSERT INTO Traceability_Details
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
GO

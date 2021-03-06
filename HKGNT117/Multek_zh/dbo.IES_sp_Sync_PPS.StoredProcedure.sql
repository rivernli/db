USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_PPS]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[IES_sp_Sync_PPS] 	
AS
	TRUNCATE TABLE IES_PPS_WIP

	SELECT CASE WHEN T$PLNT = 'B2' THEN 'B2F' ELSE RTRIM(T$PLNT) END AS T$PLNT, RTRIM(T$PITM) T$PITM, RTRIM(T$CWOC) T$CWOC, T$PANL, T$UNIT, T$LOPQ, T$LOTQ
		INTO #WIPCB FROM TFSOLP135180 WHERE LEN(T$PITM) > 8 AND T$CWOC <> 'PFIN'

	INSERT INTO #WIPCB
	SELECT T$PLNT, LayerNo, WorkCenter, T$PANL, T$UNIT, T$LOPQ, T$LOTQ FROM TFSOLP135180 t1
	INNER JOIN IES_WorkFlow t2 ON t1.T$PLNT = t2.Building AND t1.T$PITM = LEFT(t2.Project,8) 
			AND ID IN(SELECT MAX(ID) FROM IES_WorkFlow GROUP BY Project, Building)
	WHERE T$CWOC = 'PFIN'

	INSERT INTO IES_PPS_WIP(Building, Project, ProjectWV, SubProject, SubProjectWV, WorkCenter, CalendarDate, Core, Calc, Qty, Pnl, Seq, QtyOS, PnlOS)
	SELECT t3.Building, LEFT(t3.Project, 8), LEFT(t3.ProjectWV, 10), t3.Project, t3.ProjectWV, t1.T$CWOC, CONVERT(VARCHAR(10),GETDATE(),120), t4.Core, t4.Calc, SUM(t1.T$UNIT), SUM(t1.T$PANL), t4.ID, SUM(t1.T$LOTQ), SUM(t1.T$LOPQ)
		FROM #WIPCB t1
		INNER JOIN IES_PJDataBase t3 ON LEFT(LTRIM(t1.T$PITM),8)+RIGHT(RTRIM(t1.T$PITM),3) = t3.Project AND t1.T$PLNT = t3.Building
		INNER JOIN IES_WorkFlow t4 ON t3.ProjectWV = t4.LayerNo AND t1.T$CWOC = t4.WorkCenter AND t3.Building = t4.Building
		GROUP BY t3.Building, t3.Project, t3.ProjectWV, t1.T$CWOC, t4.Core, t4.Calc, t4.ID
	
	DROP TABLE #WIPCB

	TRUNCATE TABLE IES_PPS_WO
	INSERT INTO IES_PPS_WO(Building, PJID, Project, ProjectWV, SubProject, SubProjectWV, WorkCenter, CalendarDate, Unit, Yield, AttritionRate, BookingQty, Core, LT, Seq, PlanDate, QTA)	
	SELECT t3.Building, t2.ID, t1.Project, t3.Project, LEFT(t3.LayerNo, 8)+RIGHT(t3.LayerNo, 3), t3.LayerNo, t3.WorkCenter, t1.CalendarDate, ISNULL(t2.Unit,0), ISNULL(t2.AttritionRate,ISNULL(t2.Yield,1)), t2.AttritionRate, SUM(t1.BookingQty), t3.Core, CASE WHEN t1.QTA = 1 THEN t3.QTALT ELSE t3.LT END, t3.ID,
		CASE WHEN t1.QTA = 1 THEN 
			DATEADD(mi, -1*60*(PQTALT+ISNULL((SELECT SUM(QTALT) FROM IES_WorkFlow WHERE Building = t3.Building AND LayerNo = t3.LayerNo AND ID >= t3.ID),0)), t1.CalendarDate) 
		ELSE 
			DATEADD(mi, -1*60*(PLT+ISNULL((SELECT SUM(LT) FROM IES_WorkFlow WHERE Building = t3.Building AND LayerNo = t3.LayerNo AND ID >= t3.ID),0)), t1.CalendarDate) 
		END, t1.QTA
		FROM IES_ByWOCalc_Source t1 
		INNER JOIN IES_PJDataBase t2 ON t1.Project = t2.Project AND t1.Building = t2.Building
		INNER JOIN IES_WorkFlow t3 ON t2.ProjectWV = t3.Project AND t2.Building = t3.Building
		--WHERE t3.Calc = 1
	GROUP BY t3.Building, t2.ID, t1.Project, t3.Project, t3.LayerNo, t3.WorkCenter, t1.CalendarDate, t2.Unit, t2.Yield, t2.AttritionRate,t3.Core, t3.QTALT, t3.LT, t3.PLT,t3.PQTALT,t3.ID, t1.QTA
	ORDER BY t1.CalendarDate, t1.Project, t3.ID DESC
	
	UPDATE T1 SET T1.LRString = T1.SubProjectWV + ',' + ISNULL(T2.LRString, '')
		FROM IES_PPS_WO T1 LEFT JOIN IES_LayerRelation T2 ON T1.Building = T2.Building AND T1.SubProjectWV = T2.RLayer

	UPDATE IES_PPS_WO SET SubPJID = (SELECT ID FROM IES_PjDataBase WHERE Project = IES_PPS_WO.SubProject AND Building = IES_PPS_WO.Building)

	UPDATE IES_PPS_WO SET PnlQty = CEILING(CASE WHEN Unit = 0 OR Yield = 0 THEN 0 ELSE BookingQty / Unit / Yield END),
						  BookingPnlQty = CEILING(CASE WHEN Unit = 0 THEN 0 ELSE BookingQty / Unit END),
						  PlanDateShort =  CONVERT(CHAR(11),PlanDate,120)

	UPDATE t1 SET 
				t1.CompletedQty =  ISNULL(
				(SELECT SUM(t2.Pnl) FROM IES_PPS_WIP t2 
					WHERE t2.Building = t1.Building 
					AND t2.Project = t1.Project 
					AND t2.Seq > t1.Seq 
					AND CHARINDEX(','+t2.SubProjectWV+',',','+t1.LRString)>0),
				0),
				t1.CompletedQtyOS = ISNULL(
				(SELECT SUM(t2.Pnl+t2.PnlOS) FROM IES_PPS_WIP t2 
					WHERE t2.Building = t1.Building 
					AND t2.Project = t1.Project 
					AND t2.Seq > t1.Seq 
					AND CHARINDEX(','+t2.SubProjectWV+',',','+t1.LRString)>0),
				0),
				t1.WIP = ISNULL(
				(SELECT t2.Pnl FROM IES_PPS_WIP t2
					WHERE t2.SubProject = t1.SubProject 
					AND t2.Building = t1.Building 
					AND t2.WorkCenter = t1.WorkCenter),
				0),
				t1.WIPOS = ISNULL(
				(SELECT t2.PnlOS FROM IES_PPS_WIP t2
					WHERE t2.SubProject = t1.SubProject 
					AND t2.Building = t1.Building 
					AND t2.WorkCenter = t1.WorkCenter),
				0)
		FROM IES_PPS_WO t1

	UPDATE t1 SET t1.SubTotalQty = ISNULL(
				(SELECT SUM(t2.PnlQty) FROM IES_PPS_WO t2 
					WHERE t2.Building = t1.Building AND t2.SubProjectWV = t1.SubProjectWV 
					AND t2.WorkCenter = t1.WorkCenter AND t2.ID <= t1.ID),
				0)
		FROM IES_PPS_WO t1
		
	UPDATE IES_PPS_WO SET OweTotalQty = ISNULL(SubTotalQty,0) - CompletedQty, OweTotalQtyOS =  ISNULL(SubTotalQty,0) - CompletedQtyOS

	UPDATE IES_PPS_WO 
		SET OweQty = (
					CASE WHEN OweTotalQty <= 0 THEN 0 
						 WHEN OweTotalQty > PnlQty THEN PnlQty ELSE OweTotalQty END),
			OweQtyOS = (
					CASE WHEN OweTotalQtyOS <= 0 THEN 0 
						 WHEN OweTotalQtyOS > PnlQty THEN PnlQty ELSE OweTotalQtyOS END)
	
	--UPDATE t0 SET MRH = ISNULL(OweQty * (
	--	SELECT SUM(CycleTime) FROM dbo.IES_PJDatabase_SubCycleTime t1 
	--		INNER JOIN IES_PJDatabase t2 ON t1.PJID = t2.ID
	--		WHERE t2.Building = t0.Building AND t2.Project = t0.SubProject AND t1.WorkCenter = t0.WorkCenter
	--	),0)
	--	FROM IES_PPS_WO t0




GO

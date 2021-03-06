USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_IES_FlowData]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[IES_sp_Sync_IES_FlowData] 
AS
	TRUNCATE TABLE IES_LayerRelation
	TRUNCATE TABLE IES_WorkFlow

	--插入LayerRelation
	INSERT INTO IES_LayerRelation(Building, MLayer, RLayer, Project, SRNo, FmLayer, ToLayer, Seq)
		SELECT Building, RTRIM(LTRIM(T$PITM)), RTRIM(LTRIM(T$PITI)), RTRIM(LTRIM(T$GPTM)), T$SRNO, FLD, LLD, LLD-FLD FROM (
			SELECT CASE WHEN FL < 58 THEN FL - 48 ELSE FL - 55 END AS FLD, 
				   CASE WHEN LL < 58 THEN LL - 48 ELSE LL - 55 END AS LLD, * FROM (
				SELECT ASCII(UPPER(LEFT(RIGHT(LTRIM(RTRIM(T$PITI)), 2),1))) AS FL, 
					   ASCII(UPPER(RIGHT(LTRIM(RTRIM(T$PITI)),1))) AS LL, 
					   T$PITM, T$PITI, T$GPTM, T$SRNO, Building FROM TTIWIP105180
				INNER JOIN IES_PJDataBase ON TTIWIP105180.T$GPTM = IES_PJDataBase.ProjectWV)AS T1
		) AS T2 ORDER BY T$GPTM, T$SRNO

	--更新IES_LayerRelation的Core系统
	UPDATE T1 SET T1.Core = (
		SELECT COUNT(*) FROM IES_LayerRelation T2 WHERE T2.Building = T1.Building AND T2.MLayer = T1.MLayer)
		FROM IES_LayerRelation T1

	--B5现在有些Core大于12的，暂时把大于12的Core当成12
	UPDATE IES_LayerRelation SET Core = 12 WHERE Core > 12
		
	--插入WorkFlow, B2F的用TFSAMI105180,其它厂用TFSAMI003180
	--现在全部厂都用TFSAMI003180
	--INSERT INTO IES_WorkFlow(Building, Project, LayerNo, WorkCenter, Pos, Core)
	--	SELECT 'B2F', TWF.Project, TWF.LayerNo, TWF.WorkCenter, TWF.Pos,
	--	CASE WHEN TLR.MLayer IS NULL THEN 1 ELSE TLR.Core END FROM (
	--		SELECT RTRIM(LTRIM(T$PITM)) AS LayerNo, RTRIM(T$CWOC) AS WorkCenter, T$SEQE AS Pos, LEFT(RTRIM(LTRIM(T$PITM)), 10) AS Project, 'B2F' AS Building 
	--			FROM TFSAMI105180 WHERE LEFT(T$PITM, 10) IN(
	--				SELECT ProjectWV FROM IES_PjDatabase WHERE Building = 'B2F' AND ProjectWV IS NOT NULL
	--				)
	--	) AS TWF LEFT JOIN IES_LayerRelation TLR ON TWF.LayerNo = TLR.RLayer AND TWF.Building = TLR.Building
	--	ORDER BY TWF.Project ASC, ISNULL(TLR.Seq, 99) ASC, TLR.SRNo DESC, TWF.POS ASC

	INSERT INTO IES_WorkFlow(Building, Project, LayerNo, WorkCenter, Pos, Core)
		SELECT TWF.Building, TWF.Project, TWF.LayerNo, TWF.WorkCenter, TWF.Pos,
		CASE WHEN TLR.MLayer IS NULL THEN 1 ELSE TLR.Core END FROM (
			SELECT RTRIM(LTRIM(T$PJNO)) AS LayerNo, RTRIM(T$CWOC) AS WorkCenter, T$PONO AS Pos, LEFT(T$PJNO, 10) AS Project,
				(CASE T$PLNT
					WHEN 'P1' THEN 'B1' 
					WHEN 'P2' THEN 'B1' 
					WHEN '2F' THEN 'B2F'
					WHEN '12' THEN 'B3' ELSE T$PLNT END) AS Building 
			FROM TFSAMI003180 WHERE LEFT(T$PJNO, 10) IN(
				SELECT ProjectWV FROM IES_PjDatabase WHERE ProjectWV IS NOT NULL)
		) AS TWF LEFT JOIN IES_LayerRelation TLR ON TWF.LayerNo = TLR.RLayer AND TWF.Building = TLR.Building
		ORDER BY TWF.Project ASC, ISNULL(TLR.Seq, 99) ASC, TLR.SRNo DESC, TWF.POS ASC

	--更新IES_WorkFlow每个WorkCenter的LT
	UPDATE T1 SET 
		T1.LT = ISNULL(CASE 
		WHEN T1.Core = 1 THEN T2.LT 
		WHEN T1.Core = 2 THEN T2.LT*T2.Core2
		WHEN T1.Core = 3 THEN T2.LT*T2.Core3
		WHEN T1.Core = 4 THEN T2.LT*T2.Core4
		WHEN T1.Core = 5 THEN T2.LT*T2.Core5
		WHEN T1.Core = 6 THEN T2.LT*T2.Core6
		WHEN T1.Core = 7 THEN T2.LT*T2.Core7
		WHEN T1.Core = 8 THEN T2.LT*T2.Core8
		WHEN T1.Core = 9 THEN T2.LT*T2.Core9
		WHEN T1.Core = 10 THEN T2.LT*T2.Core10
		WHEN T1.Core = 11 THEN T2.LT*T2.Core11
		WHEN T1.Core = 12 THEN T2.LT*T2.Core12 END, 0),
		T1.QTALT = ISNULL(CASE 
		WHEN T1.Core = 1 THEN T2.QTALT 
		WHEN T1.Core = 2 THEN T2.QTALT*T2.Core2
		WHEN T1.Core = 3 THEN T2.QTALT*T2.Core3
		WHEN T1.Core = 4 THEN T2.QTALT*T2.Core4
		WHEN T1.Core = 5 THEN T2.QTALT*T2.Core5
		WHEN T1.Core = 6 THEN T2.QTALT*T2.Core6
		WHEN T1.Core = 7 THEN T2.QTALT*T2.Core7
		WHEN T1.Core = 8 THEN T2.QTALT*T2.Core8
		WHEN T1.Core = 9 THEN T2.QTALT*T2.Core9
		WHEN T1.Core = 10 THEN T2.QTALT*T2.Core10
		WHEN T1.Core = 11 THEN T2.QTALT*T2.Core11
		WHEN T1.Core = 12 THEN T2.QTALT*T2.Core12 END, 0)
	FROM IES_WorkFlow T1 LEFT JOIN IES_ProcessLT T2 ON T1.WorkCenter = T2.SubWorkCenter AND T1.Building = T2.Building

	UPDATE T1 SET BPLT = (
			SELECT TOP 1 ((T4.CycleTime/60*T2.LOTSize)+T2.WaittingTime) FROM IES_PJDataBase T3 
			INNER JOIN IES_PJDatabase_SubCycleTime T4 ON T3.ID = T4.PJID
			WHERE T3.Building = T2.Building AND T3.ProjectWV = T1.LayerNo AND T4.WorkCenter = T2.SubWorkCenter
		)
	FROM IES_WorkFlow T1 INNER JOIN IES_ProcessLT T2 ON T1.WorkCenter = T2.SubWorkCenter AND T1.Building = T2.Building
	WHERE T2.UCT = 1
	
	UPDATE IES_WorkFlow SET LT = BPLT WHERE BPLT <> 0 AND BPLT < LT
	UPDATE IES_WorkFlow SET QTALT = BPLT WHERE BPLT <> 0 AND BPLT < QTALT

	--更新IES_LayerRelation每个Layer的总LT
	--UPDATE IES_LayerRelation SET  
	--	LT = ISNULL((SELECT SUM(LT) FROM IES_WorkFlow 
	--		WHERE LayerNo = IES_LayerRelation.RLayer AND Building = IES_LayerRelation.Building),0),
	--	QTALT = ISNULL((SELECT SUM(QTALT) FROM IES_WorkFlow 
	--		WHERE LayerNo = IES_LayerRelation.RLayer AND Building = IES_LayerRelation.Building),0)
	--FROM IES_LayerRelation
	UPDATE IES_LayerRelation SET  
		LT = dbo.IES_fn_GetParentTotalLT(RLayer, Building, 0, 0),
		QTALT= dbo.IES_fn_GetParentTotalLT(RLayer, Building, 0, 1)
	FROM IES_LayerRelation
	
	UPDATE IES_LayerRelation SET  
		LRString = dbo.IES_fn_GetLRString(RLayer, Building, '')
	FROM IES_LayerRelation
	
	--根据IES_LayerRelation的计算逻辑更新到IES_WorkFlow上
	UPDATE T1 SET T1.PLT = T2.LT,T1.PQTALT = T2.QTALT
		FROM IES_WorkFlow T1 INNER JOIN IES_LayerRelation T2 ON T1.Building = T2.Building AND T1.LayerNo = T2.RLayer
	
	--Core为1时，必定在计算逻辑内
	--UPDATE IES_WorkFlow SET Calc = 1 WHERE Core = 1 AND Calc <> 1
	--UPDATE IES_LayerRelation SET Calc = 1 WHERE Core = 1 AND Calc <> 1

	--Core系数不为1的，把工序时间最长的放在计算逻辑内
	--UPDATE IES_LayerRelation SET Calc = 1 WHERE Core > 1 AND ID IN
	--(
	--		SELECT MIN(ID) AS ID FROM IES_LayerRelation T1 INNER JOIN (
	--			SELECT Building, MLayer, MAX(LT) AS LT FROM IES_LayerRelation WHERE Core > 1 
	--			GROUP BY Building, MLayer
	--		) AS T2 ON T1.Building = T2.Building AND T1.MLayer = T2.MLayer AND T1.LT = T2.LT
	--		GROUP BY T1.Building, T1.MLayer
	--)

	--根据IES_LayerRelation的计算逻辑更新到IES_WorkFlow上
	--UPDATE T1 SET T1.Calc = 1
	--	FROM IES_WorkFlow T1 INNER JOIN IES_LayerRelation T2 ON T1.Building = T2.Building AND T1.LayerNo = T2.RLayer
	--WHERE T1.Core > 1 AND T2.Calc = 1






GO

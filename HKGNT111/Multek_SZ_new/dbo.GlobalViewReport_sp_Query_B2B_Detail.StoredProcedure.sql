USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_B2B_Detail]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_B2B_Detail]
	-- Add the parameters for the stored procedure here
	@WeekNo INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @LastYear INT,@LastWeek INT,@LastWeekDesc VARCHAR(50),@LastWeekFrom DATETIME,@LastWeekTo DATETIME,@SQLString VARCHAR(MAX)
    DECLARE @LastYear4 INT,@LastWeek4 INT,@LastWeekDesc4 VARCHAR(50),@LastWeekFrom4 DATETIME,@LastWeekTo4 DATETIME
    DECLARE @LastYear13 INT,@LastWeek13 INT,@LastWeekDesc13 VARCHAR(50),@LastWeekFrom13 DATETIME,@LastWeekTo13 DATETIME
    CREATE TABLE #Temp (AutoID INT ,FiscalYear INT,FiscalWeek INT,FiscalWeekDesc VARCHAR(50),FiscalWeekFrom DATETIME,FiscalWeekTo DATETIME)

	SELECT IDENTITY(INT, 1,1) AS AutoID,a.*
	INTO #TempWeek
	FROM(
			SELECT FiscalYear,FiscalWeek,'W'+(CASE WHEN FiscalWeek<10 THEN '0'+CONVERT(CHAR(1),FiscalWeek) ELSE CONVERT(CHAR(2),FiscalWeek) END)+'FY'+RIGHT(CONVERT(CHAR(4),FiscalYear),2) AS FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
			FROM Calendar
			WHERE CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)<=
					(
						SELECT CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)
						FROM Calendar
						WHERE FiscalWeekTo=(
												SELECT DATEADD(DAY,-1,CONVERT(DATE,FiscalWeekFrom))
												FROM Calendar
												WHERE Calenderdate = CONVERT(VARCHAR(10),GETDATE(),120)
											)
						GROUP BY FiscalYear,FiscalWeek
					)
			GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
		) a
	ORDER BY a.FiscalYear DESC,a.FiscalWeek DESC

	SET @SQLString='INSERT INTO #Temp SELECT TOP ' +CONVERT(VARCHAR(10),@WeekNo)+' * FROM #TempWeek'
	EXECUTE (@SQLString)
	
	SET @LastYear=(SELECT FiscalYear FROM #Temp WHERE AutoID=1)
	SET @LastWeek=(SELECT FiscalWeek FROM #Temp WHERE AutoID=1)
	SET @LastWeekDesc=(SELECT FiscalWeekDesc FROM #Temp WHERE AutoID=1)
	SET @LastWeekFrom=(SELECT FiscalWeekFrom FROM #Temp WHERE AutoID=1)
	SET @LastWeekTo=(SELECT FiscalWeekTo FROM #Temp WHERE AutoID=1)
	
	SET @LastYear4=(SELECT FiscalYear FROM #Temp WHERE AutoID=4)
	SET @LastWeek4=(SELECT FiscalWeek FROM #Temp WHERE AutoID=4)
	SET @LastWeekDesc4=(SELECT FiscalWeekDesc FROM #Temp WHERE AutoID=4)
	SET @LastWeekFrom4=(SELECT FiscalWeekFrom FROM #Temp WHERE AutoID=4)
	SET @LastWeekTo4=(SELECT FiscalWeekTo FROM #Temp WHERE AutoID=4)
	
	SET @LastYear13=(SELECT FiscalYear FROM #Temp WHERE AutoID=13)
	SET @LastWeek13=(SELECT FiscalWeek FROM #Temp WHERE AutoID=13)
	SET @LastWeekDesc13=(SELECT FiscalWeekDesc FROM #Temp WHERE AutoID=13)
	SET @LastWeekFrom13=(SELECT FiscalWeekFrom FROM #Temp WHERE AutoID=13)
	SET @LastWeekTo13=(SELECT FiscalWeekTo FROM #Temp WHERE AutoID=13)
	
	SELECT *,(B1+B2F+B3+B4+B5+VVI) AS Total,(B1+B3+B4+B5+VVI) AS TotalEXB2F
	INTO #Temp1
	FROM (
			SELECT @LastWeekDesc AS WeekDesc,'2Invoice Sales for Normal Order' AS Type,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B1',@LastWeekFrom,@LastWeekTo) AS B1,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B2F',@LastWeekFrom,@LastWeekTo) AS B2F,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B3',@LastWeekFrom,@LastWeekTo) AS B3,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B4',@LastWeekFrom,@LastWeekTo) AS B4,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B5',@LastWeekFrom,@LastWeekTo) AS B5,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','VVI',@LastWeekFrom,@LastWeekTo) AS VVI
			UNION
			SELECT @LastWeekDesc AS WeekDesc,'1Order Booked' AS Type,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B1',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B1',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B1',@LastWeekFrom,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B1',@LastWeekFrom,@LastWeekTo) AS B1,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B2F',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B2F',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B2F',@LastWeekFrom,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B2F',@LastWeekFrom,@LastWeekTo) AS B2F,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B3',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B3',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B3',@LastWeekFrom,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B3',@LastWeekFrom,@LastWeekTo) AS B3,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B4',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B4',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B4',@LastWeekFrom,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B4',@LastWeekFrom,@LastWeekTo) AS B4,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B5',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B5',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B5',@LastWeekFrom,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B5',@LastWeekFrom,@LastWeekTo) AS B5,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','VVI',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','VVI',@LastWeekFrom,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','VVI',@LastWeekFrom,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','VVI',@LastWeekFrom,@LastWeekTo) AS VVI
			UNION
			SELECT @LastWeekDesc4+' ~ '+@LastWeekDesc+' Rolling 4 Weeks' AS WeekDesc,'2Invoice Sales for Normal Order' AS Type,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B1',@LastWeekFrom4,@LastWeekTo) AS B1,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B2F',@LastWeekFrom4,@LastWeekTo) AS B2F,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B3',@LastWeekFrom4,@LastWeekTo) AS B3,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B4',@LastWeekFrom4,@LastWeekTo) AS B4,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B5',@LastWeekFrom4,@LastWeekTo) AS B5,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','VVI',@LastWeekFrom4,@LastWeekTo) AS VVI
			UNION
			SELECT @LastWeekDesc4+' ~ '+@LastWeekDesc+' Rolling 4 Weeks' AS WeekDesc,'1Order Booked' AS Type,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B1',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B1',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B1',@LastWeekFrom4,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B1',@LastWeekFrom4,@LastWeekTo) AS B1,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B2F',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B2F',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B2F',@LastWeekFrom4,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B2F',@LastWeekFrom4,@LastWeekTo) AS B2F,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B3',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B3',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B3',@LastWeekFrom4,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B3',@LastWeekFrom4,@LastWeekTo) AS B3,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B4',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B4',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B4',@LastWeekFrom4,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B4',@LastWeekFrom4,@LastWeekTo) AS B4,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B5',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B5',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B5',@LastWeekFrom4,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B5',@LastWeekFrom4,@LastWeekTo) AS B5,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','VVI',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','VVI',@LastWeekFrom4,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','VVI',@LastWeekFrom4,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','VVI',@LastWeekFrom4,@LastWeekTo) AS VVI
			UNION
			SELECT @LastWeekDesc13+' ~ '+@LastWeekDesc+' Rolling 13 Weeks' AS WeekDesc,'2Invoice Sales for Normal Order' AS Type,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B1',@LastWeekFrom13,@LastWeekTo) AS B1,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B2F',@LastWeekFrom13,@LastWeekTo) AS B2F,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B3',@LastWeekFrom13,@LastWeekTo) AS B3,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B4',@LastWeekFrom13,@LastWeekTo) AS B4,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','B5',@LastWeekFrom13,@LastWeekTo) AS B5,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('FG OUT','VVI',@LastWeekFrom13,@LastWeekTo) AS VVI
			UNION
			SELECT @LastWeekDesc13+' ~ '+@LastWeekDesc+' Rolling 13 Weeks' AS WeekDesc,'1Order Booked' AS Type,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B1',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B1',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B1',@LastWeekFrom13,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B1',@LastWeekFrom13,@LastWeekTo) AS B1,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B2F',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B2F',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B2F',@LastWeekFrom13,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B2F',@LastWeekFrom13,@LastWeekTo) AS B2F,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B3',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B3',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B3',@LastWeekFrom13,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B3',@LastWeekFrom13,@LastWeekTo) AS B3,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B4',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B4',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B4',@LastWeekFrom13,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B4',@LastWeekFrom13,@LastWeekTo) AS B4,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B5',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B5',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B5',@LastWeekFrom13,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B5',@LastWeekFrom13,@LastWeekTo) AS B5,
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','VVI',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','VVI',@LastWeekFrom13,@LastWeekTo)+
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','VVI',@LastWeekFrom13,@LastWeekTo)-
				dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','VVI',@LastWeekFrom13,@LastWeekTo) AS VVI
		) a
	INSERT INTO #Temp1
	SELECT a.WeekDesc,'3Booked to Bill' AS Type,
		(SELECT b.B1 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.B1 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS B1,
		(SELECT b.B2F FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.B2F FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS B2F,
		(SELECT b.B3 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.B3 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS B3,
		(SELECT b.B4 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.B4 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS B4,
		(SELECT b.B5 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.B5 FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS B5,
		(SELECT b.VVI FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.VVI FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS VVI,
		(SELECT b.Total FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.Total FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS Total,
		(SELECT b.TotalEXB2F FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='1Order Booked')/
		(SELECT b.TotalEXB2F FROM #Temp1 b WHERE b.WeekDesc=a.WeekDesc AND b.Type='2Invoice Sales for Normal Order' ) AS TotalEXB2F
	FROM #Temp1 a 
	WHERE LEN(WeekDesc)>7
	GROUP BY a.WeekDesc
	
	SELECT (CASE WHEN RIGHT(Type,LEN(Type)-1)<>'Order Booked' THEN '' ELSE WeekDesc END) AS WeekDesc1,RIGHT(Type,LEN(Type)-1) AS OrderType,B1,B2F,B3,B4,B5,VVI,Total,TotalEXB2F 
	FROM #Temp1 
	--ORDER BY WeekDesc DESC,TYPE ASC
	ORDER BY SUBSTRING(WeekDesc,6,2) DESC,SUBSTRING(WeekDesc,2,2) DESC , TYPE ASC
	
	SELECT *
	INTO #Temp2
	FROM (
			SELECT AutoID,CONVERT(VARCHAR(2),FiscalWeek )+' ('+CONVERT(VARCHAR(8),FiscalWeekFrom,1)+'-'+CONVERT(VARCHAR(8),FiscalWeekTo,1)+')' AS WeekDesc,
					'1New Order Booked' AS Type,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B1',FiscalWeekFrom,FiscalWeekTo) AS B1,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B2F',FiscalWeekFrom,FiscalWeekTo) AS B2F,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B3',FiscalWeekFrom,FiscalWeekTo) AS B3,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B4',FiscalWeekFrom,FiscalWeekTo) AS B4,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','B5',FiscalWeekFrom,FiscalWeekTo) AS B5,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Order Intake','VVI',FiscalWeekFrom,FiscalWeekTo) AS VVI
			FROM #Temp 
			UNION
			SELECT AutoID,CONVERT(VARCHAR(2),FiscalWeek )+' ('+CONVERT(VARCHAR(8),FiscalWeekFrom,1)+'-'+CONVERT(VARCHAR(8),FiscalWeekTo,1)+')' AS WeekDesc,
					'2Price Change' AS Type,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B1',FiscalWeekFrom,FiscalWeekTo) AS B1,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B2F',FiscalWeekFrom,FiscalWeekTo) AS B2F,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B3',FiscalWeekFrom,FiscalWeekTo) AS B3,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B4',FiscalWeekFrom,FiscalWeekTo) AS B4,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','B5',FiscalWeekFrom,FiscalWeekTo) AS B5,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('Price Change','VVI',FiscalWeekFrom,FiscalWeekTo) AS VVI
			FROM #Temp 
			UNION
			SELECT AutoID,CONVERT(VARCHAR(2),FiscalWeek )+' ('+CONVERT(VARCHAR(8),FiscalWeekFrom,1)+'-'+CONVERT(VARCHAR(8),FiscalWeekTo,1)+')' AS WeekDesc,
					'4MKT Order Release' AS Type,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B1',FiscalWeekFrom,FiscalWeekTo) AS B1,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B2F',FiscalWeekFrom,FiscalWeekTo) AS B2F,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B3',FiscalWeekFrom,FiscalWeekTo) AS B3,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B4',FiscalWeekFrom,FiscalWeekTo) AS B4,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','B5',FiscalWeekFrom,FiscalWeekTo) AS B5,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-Release','VVI',FiscalWeekFrom,FiscalWeekTo) AS VVI
			FROM #Temp  
			UNION
			SELECT AutoID,CONVERT(VARCHAR(2),FiscalWeek )+' ('+CONVERT(VARCHAR(8),FiscalWeekFrom,1)+'-'+CONVERT(VARCHAR(8),FiscalWeekTo,1)+')' AS WeekDesc,
					'3MKT Order on Hold' AS Type,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B1',FiscalWeekFrom,FiscalWeekTo) AS B1,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B2F',FiscalWeekFrom,FiscalWeekTo) AS B2F,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B3',FiscalWeekFrom,FiscalWeekTo) AS B3,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B4',FiscalWeekFrom,FiscalWeekTo) AS B4,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','B5',FiscalWeekFrom,FiscalWeekTo) AS B5,
					dbo.GlobalViewReport_fun_Get_B2B_By_Type('MKT-On Hold','VVI',FiscalWeekFrom,FiscalWeekTo) AS VVI			FROM #Temp 
		) a
	INSERT INTO #Temp2
	SELECT a.AutoID,a.WeekDesc,'5Order Booked' AS Type,
		(
			SELECT SUM(b.B1) FROM #Temp2 b WHERE b.AutoID=a.AutoID 
		) -
		(
			SELECT b.B1 FROM #Temp2 b WHERE b.AutoID=a.AutoID AND b.Type='3MKT Order on Hold'
		)*2.0000 AS B1,
		(
			SELECT SUM(b.B2F) FROM #Temp2 b WHERE b.AutoID=a.AutoID 
		) -
		(
			SELECT b.B2F FROM #Temp2 b WHERE b.AutoID=a.AutoID AND b.Type='3MKT Order on Hold'
		)*2.0000 AS B2F,
		(
			SELECT SUM(b.B3) FROM #Temp2 b WHERE b.AutoID=a.AutoID 
		)-
		(
			SELECT b.B3 FROM #Temp2 b WHERE b.AutoID=a.AutoID AND b.Type='3MKT Order on Hold'
		)*2.0000  AS B3,
		(
			SELECT SUM(b.B4) FROM #Temp2 b WHERE b.AutoID=a.AutoID 
		) -
		(
			SELECT b.B4 FROM #Temp2 b WHERE b.AutoID=a.AutoID AND b.Type='3MKT Order on Hold'
		)*2.0000 AS B4,
		(
			SELECT SUM(b.B5) FROM #Temp2 b WHERE b.AutoID=a.AutoID 
		) -
		(
			SELECT b.B5 FROM #Temp2 b WHERE b.AutoID=a.AutoID AND b.Type='3MKT Order on Hold'
		)*2.0000 AS B5,
		(
			SELECT SUM(b.VVI) FROM #Temp2 b WHERE b.AutoID=a.AutoID 
		)-
		(
			SELECT b.VVI FROM #Temp2 b WHERE b.AutoID=a.AutoID AND b.Type='3MKT Order on Hold'
		)*2.0000  AS VVI
	FROM #Temp2 a
	GROUP BY a.AutoID,a.WeekDesc	
	
	SELECT (CASE WHEN RIGHT(Type,LEN(Type)-1)<>'New Order Booked' THEN '' ELSE WeekDesc END ) AS WeekDesc,RIGHT(Type,LEN(Type)-1) AS OrderType,B1,B2F,B3,B4,B5,VVI,(B1+B2F+B3+B4+B5+VVI) AS Total,(B1+B3+B4+B5+VVI) AS TotalEXB2F
	FROM #TEMP2 
	ORDER BY AutoID ASC,Type

END
GO

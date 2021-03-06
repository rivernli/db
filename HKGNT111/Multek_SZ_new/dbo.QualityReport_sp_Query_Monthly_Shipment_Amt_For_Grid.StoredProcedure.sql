USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_Monthly_Shipment_Amt_For_Grid]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_Monthly_Shipment_Amt_For_Grid] 
	-- Add the parameters for the stored procedure here
		@Year VARCHAR(12)=NULL,
		@Project VARCHAR(50)=NULL,
		@PartNo VARCHAR(200)=NULL,
		@Product VARCHAR(200)=NULL,
		@Plant VARCHAR(200)=NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

	SET @Year=(CASE WHEN @Year IS NULL THEN CONVERT(VARCHAR(4),GETDATE(),120) ELSE @Year END)
	SET @Project=LTRIM(RTRIM(ISNULL(@Project,'')))+'%'
	SET @PartNo=LTRIM(RTRIM(ISNULL(@PartNo,'')))+'%'
	SET @Product=LTRIM(RTRIM(ISNULL(@Product,'')))+'%'

	SELECT * INTO #Temp1 
	FROM QualityReport_uvw_VPT_MKT_Shipment
	SELECT * INTO #Temp 
	FROM #Temp1 
	WHERE CHARINDEX(CONVERT(VARCHAR(4),Invoice_Date,120),@Year)>0
		  AND Prj_No LIKE @Project
		  AND Part_No LIKE @PartNo
		  AND Product_Name LIKE @Product
		  AND CHARINDEX(Plant,@Plant)>0

	CREATE INDEX Index11 ON #Temp (Invoice_Date)
	CREATE INDEX Index21 ON #Temp (OEM_NAME)
	CREATE INDEX Index31 ON #Temp (PLANT)

	DECLARE @SQLString VARCHAR(8000),@NowYear CHAR(4),@I INT,@J INT,@K INT,@NowPlant VARCHAR(20),@ColumnSum NUMERIC(19,1)
	CREATE TABLE #TempData (Plant VARCHAR(10),OEM VARCHAR(200))
	CREATE TABLE #TempDataColumn(Data NUMERIC(19,1))

	SET @J=1
	SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
	WHILE @NowYear>''
		BEGIN
			SET @K=1
			WHILE @K<=12
				BEGIN
					SET @SQLString='ALTER TABLE #TempData ADD ['+@NowYear+'-'+CONVERT(VARCHAR(2),@K)+'] NUMERIC(19,1)'
					EXECUTE (@SQLString)
					SET @K=@K+1
				END
			SET @J=@J+1
			SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
		END

	SET @J=1
	SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)

	SET @SQLString='INSERT INTO #TempData SELECT a.Plant,a.OEM_Name,'
	WHILE @NowYear>''
		BEGIN
			SET @SQLString=@SQLString+'
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-01'+''''+'),0) AS [' +@NowYear+'1],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-02'+''''+'),0) AS [' +@NowYear+'2],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-03'+''''+'),0) AS [' +@NowYear+'3],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-04'+''''+'),0) AS [' +@NowYear+'4],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-05'+''''+'),0) AS [' +@NowYear+'5],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-06'+''''+'),0) AS [' +@NowYear+'6],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-07'+''''+'),0) AS [' +@NowYear+'7],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-08'+''''+'),0) AS [' +@NowYear+'8],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-09'+''''+'),0) AS [' +@NowYear+'9],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-10'+''''+'),0) AS [' +@NowYear+'10],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-11'+''''+'),0) AS [' +@NowYear+'11],
										ISNULL((
											SELECT SUM(ISNULL(b.Del_Amt_USD,0)) FROM #Temp b WHERE b.Plant=a.Plant AND b.OEM_Name=a.OEM_Name AND CONVERT(VARCHAR(7),b.Invoice_Date,120)='+''''+@NowYear+'-12'+''''+'),0) AS [' +@NowYear+'12],'
			SET @J=@J+1
			SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
		END
	SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
	SET @SQLString=@SQLString+'
								FROM #Temp a
								GROUP BY a.Plant,a.OEM_Name
								ORDER BY a.Plant,a.OEM_Name
								'
	EXECUTE (@SQLString)

	SET @SQLString='DELETE #TempData WHERE '
	SET @J=1
	SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
	WHILE @NowYear>''
		BEGIN
			SET @K=1
			WHILE @K<=12
				BEGIN
					SET @SQLString=@SQLString+' ['+@NowYear+'-'+CONVERT(VARCHAR(2),@K)+']=0 AND '
					SET @K=@K+1
				END
			SET @J=@J+1
			SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
		END
	SET @SQLSTRING= LEFT(@SQLSTRING,LEN(@SQLString)-4)
	EXECUTE (@SQLString)

	ALTER TABLE #TempData ADD [Total] NUMERIC(19,1)

	SET @SQLString='UPDATE #TempData SET [Total]= '
	SET @J=1
	SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
	WHILE @NowYear>''
		BEGIN
			SET @K=1
			WHILE @K<=12
				BEGIN
					SET @SQLString=@SQLString+' ['+@NowYear+'-'+CONVERT(VARCHAR(2),@K)+']+'
					SET @K=@K+1
				END
			SET @J=@J+1
			SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
		END
	SET @SQLSTRING= LEFT(@SQLSTRING,LEN(@SQLString)-1)
	EXECUTE (@SQLString)

	SET @I=1
	SET @NowPlant=SUBSTRING(@Plant,(@I-1)*2+1,2)
	WHILE @NowPlant>'' 
		BEGIN
			 IF EXISTS(SELECT * FROM #TempData WHERE Plant=@NowPlant)
				BEGIN
				INSERT INTO #TempData (Plant,OEM)
						VALUES(	@NowPlant,'ZZTotal')
				SET @J=1
				SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
				WHILE @NowYear>''
					BEGIN
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-1]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-1]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-2]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-2]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-3]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-3]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-4]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-4]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-5]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-5]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-6]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-6]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-7]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-7]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-8]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-8]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-9]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-9]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-10]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-10]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-11]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-11]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM(['+@NowYear+'-12]) FROM #TempData WHERE Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET ['+@NowYear+'-12]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							DELETE #TempDataColumn
							SET @SQLString='INSERT INTO #TempDataColumn SELECT SUM([Total]) FROM #TempData WHERE OEM<>'+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''
							EXECUTE (@SQLString)
							SET @ColumnSum=(SELECT Data FROM #TempDataColumn)
							SET @SQLString='UPDATE #TempData SET [Total]='+CONVERT(VARCHAR(20),@ColumnSum)+' WHERE OEM='+''''+'ZZTotal'+''''+' AND Plant='+''''+@NowPlant+''''

							EXECUTE (@SQLString)

							SET @J=@J+1
							SET @NowYear=SUBSTRING(@Year,(@J-1)*4+1,4)
					END	
					END
				SET @I=@I+1
				SET @NowPlant=SUBSTRING(@Plant,(@I-1)*2+1,2)
		END

		SELECT * INTO #TempDataRow FROM #TempData ORDER BY Plant,OEM

		UPDATE #TempDataRow SET OEM='Total' WHERE OEM='ZZTotal'

		UPDATE #TempDataRow
		SET Plant=(CASE Plant WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END)

		SELECT *  FROM #TempDataRow
END
GO

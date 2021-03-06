USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[new_M6_veryfi_formula]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[new_M6_veryfi_formula]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@MAX		INT
	DECLARE	@LOOP		INT
	DECLARE	@Count		INT

    -- Insert statements for procedure here
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#COMMON') AND TYPE = 'U')
			DROP TABLE #COMMON
			
		CREATE TABLE #COMMON
		(
			ID INT IDENTITY,
			Formula	NVARCHAR(5),
			sPercent	NVARCHAR(10)
		)

    ----------------------------------------------------------------------------------------------------------------------------------------------------------
    --1.同一期里最大减去最小的差，不会在下期出现
		--每期最大最小差
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#Difference') AND TYPE = 'U')
			DROP TABLE #Difference

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#Dif_Exit') AND TYPE = 'U')
			DROP TABLE #Dif_Exit
						
		SELECT ROW_NUMBER() over(order by date) AS ID ,[DATE],(MAX(NUMBER)-MIN(NUMBER)) AS DIF 
		INTO #Difference
		FROM DBO.M6 WHERE ISSP = 0
		GROUP BY DATE
		ORDER BY DATE
		
		SELECT * INTO #Dif_Exit FROM #Difference WHERE 1 <> 1
		SET @LOOP = 1
		SELECT @MAX = MAX(ID) FROM #Difference
		
		--计算差异时候在下期出现
		IF @MAX > 0 
			BEGIN
				WHILE @LOOP <= @MAX
					BEGIN
						INSERT INTO #Dif_Exit
						SELECT * FROM #Difference AS A
						WHERE	A.ID = @LOOP
						AND		A.DIF IN 
							(
								SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
							)
											
						SET @LOOP = @LOOP + 1
					END
				SELECT @Count = COUNT(*) FROM #Dif_Exit
				--SELECT 'Formula 1 - Max(Number)-Min(Number) exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
				INSERT INTO #COMMON(Formula,sPercent) VALUES('1',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
			END

	----------------------------------------------------------------------------------------------------------------------------------------------------------
	--2.当期开奖号码按照大小顺序排，第二位与第三位的差，在下期不会出现
	  --取得每组里按照大小排序的第二位与第三位，求差异
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID ,[DATE],(MAX(NUMBER)-MIN(NUMBER)) AS DIF 
			FROM
			(
				SELECT [DATE],NUMBER FROM M6 AS A
				WHERE NUMBER IN
				(
					SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0 ORDER BY NUMBER ASC
				)
				AND NUMBER NOT IN
				(
					SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0 ORDER BY NUMBER ASC
				)
				AND ISSP = 0
			) AS N
			GROUP BY [DATE] 
			ORDER BY [DATE]
			
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('2',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------
	--3.当期开奖号码大小顺序第二位与第五位的差,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID ,[DATE],MAX(NUMBER)-MIN(NUMBER) AS DIF FROM M6 AS A
			WHERE NUMBER NOT IN
			(
				SELECT MAX(NUMBER) FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0
			)
			AND NUMBER NOT IN
			(
				SELECT MIN(NUMBER) FROM M6 AS C WHERE C.DATE = A.DATE AND ISSP = 0
			)
			AND ISSP = 0
			GROUP BY [DATE]
			ORDER BY [DATE]
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('3',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--4. 当期开奖号码大小顺序第一位乘4再减掉2,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID ,[DATE],MIN(NUMBER)*4-2 AS DIF FROM M6 AS A 
			WHERE ISSP = 0
			GROUP BY [DATE] ORDER BY [DATE]
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('4',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--5. 当期开奖号码大小顺序第一位加当期开奖的兰号，计算的结果再乘3后,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID ,[DATE],MIN(NUMBER)+
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			) * 3 AS DIF 
			FROM M6 AS A 
			WHERE A.ISSP = 0
			GROUP BY [DATE] ORDER BY [DATE]

			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('5',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--6. 当期开奖号码大小顺序第一位加09,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID ,[DATE],MIN(NUMBER)+9 AS DIF FROM M6 AS A WHERE ISSP = 0 GROUP BY [DATE] ORDER BY [DATE]
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('6',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--7. 当期开奖号码大小顺序第二位加05,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MIN(NUMBER)+5
			FROM M6 AS A
			WHERE A.NUMBER NOT IN
			(
				SELECT MIN(NUMBER) FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0
			)
			AND ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('7',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--8. 当期开奖号码大小顺序第三位加04,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)+4
			FROM M6 AS A
			WHERE A.NUMBER IN
			(
				SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0 ORDER BY NUMBER ASC
			)
			AND ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('8',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--9. 当期开奖号码大小顺序第三位加07,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)+7
			FROM M6 AS A
			WHERE A.NUMBER IN
			(
				SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0 ORDER BY NUMBER ASC
			)
			AND ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('9',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--10. 当期开奖号码大小顺序第六位加04,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)+4
			FROM M6 AS A
			WHERE ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('10',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--11. 当期开奖号码大小顺序第四位与第五位的差，加当期的兰号，再加01,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MIN(NUMBER)-MAX(NUMBER)+1+
			(
				SELECT TOP 1 NUMBER FROM M6 AS C WHERE C.DATE = A.DATE AND C.ISSP = 1
			)
			FROM M6 AS A
			WHERE A.NUMBER IN
			(
				SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0 ORDER BY NUMBER ASC
			)
			AND A.NUMBER NOT IN
			(
				SELECT MAX(NUMBER) FROM M6 AS D WHERE D.DATE = A.DATE AND ISSP = 0
			)
			AND ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('11',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--12. 当期开奖号码出号顺序第一位与第二位的和,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)+MIN(NUMBER)
			FROM M6 AS A
			WHERE A.NUMBER IN
			(
				SELECT TOP 2 NUMBER FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0 ORDER BY NUMBER ASC
			)
			AND ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('12',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--14. 当期开奖号码出号顺序第三位与第五位的差,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)-MIN(NUMBER)
			FROM M6 AS A
			WHERE A.NUMBER IN
			(
				SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0 ORDER BY NUMBER DESC
			)
			AND A.NUMBER NOT IN
			(
				SELECT MAX(NUMBER) FROM M6 AS B WHERE B.[DATE] = A.[DATE] AND ISSP = 0
			)
			AND ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('14',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	

		--15. 当期开奖号码出号顺序首尾的差，加当期开奖的兰号，再减去03,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)-MIN(NUMBER) - 3 +
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)
			FROM M6 AS A
			WHERE ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('15',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--16. 当期开奖号码出号顺序第一位与第三位的差，加当期开奖的兰号，再加02,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MAX(NUMBER)-MIN(NUMBER) + 2 +
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)
			FROM M6 AS A
			WHERE ISSP = 0
			AND A.NUMBER IN
			(
				SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0
			)
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('16',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--17. 当期开奖号码出号顺序一位，二位，三位相加的和，加当期开奖的兰号，再减去01,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],SUM(NUMBER) - 1 +
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)
			FROM M6 AS A
			WHERE ISSP = 0
			AND A.NUMBER IN
			(
				SELECT TOP 3 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0
			)
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('17',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--18. 当期开奖的兰号，加当期开奖号码大小顺序第一位,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MIN(NUMBER)+
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)
			FROM M6 AS A
			WHERE A.ISSP = 0
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('18',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--19. 当期开奖的兰号，加当期开奖号码大小顺序第二位，再减去01,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],MIN(NUMBER)-1+
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)
			FROM M6 AS A
			WHERE A.ISSP = 0
			AND NUMBER IN
			(
				SELECT TOP 2 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0
			)
			AND NUMBER NOT IN
			(
				SELECT MIN(NUMBER) FROM M6 AS C WHERE C.DATE = A.DATE AND ISSP = 0
			)
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('19',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--20. 当期开奖的兰号，减当期开奖号码大小顺序第四位，再加上01，再减去01,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)- MAX(NUMBER)+1
			FROM M6 AS A
			WHERE A.ISSP = 0
			AND NUMBER IN
			(
				SELECT TOP 4 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0
			)
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('20',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--21. 当期开奖的兰号，减当期开奖号码大小顺序第五位,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)- MAX(NUMBER)
			FROM M6 AS A
			WHERE A.ISSP = 0
			AND NUMBER IN
			(
				SELECT TOP 5 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0 ORDER BY NUMBER
			)
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('21',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--22. 当期开奖的兰号，乘当期开奖号码大小顺序第一位,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			)* MIN(NUMBER)
			FROM M6 AS A
			WHERE A.ISSP = 0
			AND NUMBER IN
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 0 ORDER BY NUMBER
			)
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('22',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--23. 当期开奖的兰号，加+07,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			) + 7
			FROM M6 AS A
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('23',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--24. 当期开奖的兰号，加+09,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			) + 9
			FROM M6 AS A
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('24',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--25. 当期开奖的兰号，乘05加+02,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],
			(
				SELECT TOP 1 NUMBER FROM M6 AS B WHERE B.DATE = A.DATE AND ISSP = 1
			) * 5 + 2
			FROM M6 AS A
			GROUP BY A.DATE
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('25',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--26. 当期开奖的兰号，如为偶数时，乘上2，再加02,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],case number%2 when 0 then number *2 +2 else 0 end
			FROM M6 AS A
			where ISSP = 1
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('26',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	
		--27. 当期开奖的兰号，如为奇数时，乘上5，再加+02,在下期不会出现。
			TRUNCATE TABLE #Difference
			TRUNCATE TABLE #Dif_Exit
				
			INSERT INTO #Difference
			SELECT ROW_NUMBER() over(order by date) AS ID,[DATE],case number%2 when 0 then 0 else number * 5 +2 end
			FROM M6 AS A
			where ISSP = 1
	
			SET @LOOP = 1
			SET @COUNT = 0
			SELECT @MAX = MAX(ID) FROM #Difference
			
		--计算差异时候在下期出现
			IF @MAX > 0 
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							INSERT INTO #Dif_Exit
							SELECT * FROM #Difference AS A
							WHERE	A.ID = @LOOP
							AND		A.DIF IN 
								(
									SELECT NUMBER FROM DBO.M6 AS B WHERE B.[DATE] = (SELECT TOP 1 DATE FROM #Difference AS C WHERE C.ID = @LOOP + 1) AND ISSP = 0
								)
												
							SET @LOOP = @LOOP + 1
						END
					SELECT @Count = COUNT(*) FROM #Dif_Exit
					--SELECT 'Formula 2 - NUMBER 2 - NUMBER 3 exists in next period:'+CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%'
					INSERT INTO #COMMON(Formula,sPercent) VALUES('27',CAST(CAST(@Count*1.0*100/@Max AS DECIMAL(10,2)) AS VARCHAR(50))+'%')
				END
	----------------------------------------------------------------------------------------------------------------------------------------------------------	

	SELECT * FROM #COMMON
	
END

GO

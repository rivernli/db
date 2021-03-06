USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_Auto_update_Data]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[ItemPriceMasterQuery_Auto_update_Data] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		SET NOCOUNT ON;

    -- Insert statements for procedure here
		TRUNCATE TABLE ItemPriceMasterQuery_Data

	-- INSERT INTO Fin table
		INSERT INTO ItemPriceMasterQuery_Data
		SELECT
			CHI,
			T$CUNO,
			T1.T$ITEM,
			RIGHT(LEFT(LTRIM(T1.T$ITEM),7),4) AS T$PITM,
			T2.T$DSCA,
			T2.T$CSGS,
			OEM,
			T$CNTR,
			T$DILE,
			T$QANP,
			CONVERT(VARCHAR(10),CASE T$STDT WHEN '1753-01-01' THEN NULL ELSE T$STDT END,120) AS T$STDT,
			CONVERT(VARCHAR(10),CASE T$TDAT WHEN '1753-01-01' THEN NULL ELSE T$TDAT END,120) AS T$TDAT,
			CAST (T$PRIC AS DECIMAL(18,4)) AS T$PRIC,
			T$DISC,
			T$DAMT,
			T$CDIS,
			(CASE T$GNPR WHEN 1 THEN 'Gross' WHEN 2 THEN 'Net' END) AS T$GNPR,
			T$VERS,
			T$USED,
			(CASE T$TYPE WHEN 1 THEN 'Normal Price' WHEN 2 THEN 'Special Price' END) AS T$TYPE,
			(CASE T$STAT WHEN 1 THEN 'Yes' WHEN 2 THEN 'No' END) AS T$STAT,
			'' AS T$PLNT, 
			T$CCUR 		 
		FROM 
		(
			--SELECT '180' AS CHI,* FROM DBO.TTDSLS030180 					
			--UNION ALL
			--SELECT '183' AS CHI,* FROM DBO.TTDSLS030183 
			SELECT '180' AS CHI, A.*,B.T$CCUR FROM DBO.TTDSLS030180  AS A LEFT JOIN DBO.TTCCOM010180 AS B
			ON A.T$CUNO = B.T$CUNO 
			UNION ALL
			SELECT '183' AS CHI, A.*,B.T$CCUR FROM DBO.TTDSLS030183 AS A LEFT JOIN DBO.TTCCOM010183 AS B
			ON A.T$CUNO = B.T$CUNO	
		) T1	
		LEFT JOIN
		(
			SELECT A.T$ITEM,A.T$DSCA,A.T$CSGS,B.T$DSCA AS OEM 
			FROM FACTORYLOADING.DBO.TTIITM001180 AS A 
				LEFT JOIN FACTORYLOADING.DBO.TTCMCS044180 AS B
				  ON A.T$CSGS = B.T$CSGP
		) T2
		ON T1.T$ITEM = T2.T$ITEM

--	TRUNCATE TABLE ItemPriceMasterQuery_Data_Plant_Temp
--	INSERT INTO ItemPriceMasterQuery_Data_Plant_Temp SELECT * FROM (
--		SELECT  RTRIM(T$CUNO) AS T$CUNO,
--				RTRIM(T$ITEM) AS T$ITEM,
--				CASE WHEN T$PLNT = 'P1' OR T$PLNT = 'P2' THEN 'B1'
--					 WHEN T$PLNT = '12' THEN 'B3' ELSE T$PLNT END AS T$PLNT FROM 
--				(
--					SELECT T$CUNO,T$ITEM,CASE WHEN T$CWAR IN ('452','474') THEN 'HK' ELSE T$PLNT END T$PLNT
--					FROM    HKGNT111.multekChi_Realtime.dbo.TFSOLP102180
--					WHERE	T$COTP <>'SCS'
--						AND T$COTP <>'SL8'
--						AND T$COTP <>'RSS'
--						AND	T$PLNT <> ''
--						AND T$PLNT IS NOT NULL
--					GROUP BY T$CUNO,T$ITEM,T$CWAR,T$PLNT
--				
--					UNION
--
--					SELECT A.T$CUNO,A.T$ITEM,CASE WHEN A.T$CWAR IN ('452','474') THEN 'HK' ELSE B.T$PLNT END T$PLNT
--					FROM multekchi_realtime.dbo.TFSOLP100180 AS A  
--						LEFT JOIN FactoryLoading.dbo.TFSCPP201 as b
--						ON A.T$CWAR = B.T$CWAR
--					WHERE A.T$CWAR <> ''
--					GROUP BY A.T$CUNO,A.T$ITEM,A.T$CWAR,B.T$PLNT
--				) A
--				GROUP BY T$CUNO,T$ITEM,T$PLNT
--				) B WHERE T$PLNT IS NOT NULL AND T$PLNT <> ''

		UPDATE ItemPriceMasterQuery_Data SET T$PLNT = dbo.ItemPriceMasterQuery(T$CUNO,T$ITEM)
		--TRUNCATE TABLE ItemPriceMasterQuery_Data_Plant_Temp
END



GO

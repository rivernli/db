USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[ItemPriceMasterQuery]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ItemPriceMasterQuery] 
(
	-- Add the parameters for the function here
	@Cuttomer	varchar(32),
	@Item		varchar(32)
)
RETURNS nvarchar(20)
AS
BEGIN
	
		DECLARE	@Plant	nvarchar(20)
		SET @Plant = ''
--		SELECT @Plant=@Plant+T$PLNT+',' FROM ItemPriceMasterQuery_Data_Plant_Temp WHERE T$CUNO = @Cuttomer AND T$ITEM = @Item
		SELECT @Plant=@Plant+T$PLNT+',' FROM TFSOLP148180 WHERE T$CUNO = @Cuttomer AND T$ITEM = @Item
		ORDER BY CASE WHEN T$PLNT = '2F' THEN 'B2' ELSE T$PLNT END
		IF LEN(@Plant) > 0
			SET @Plant = LEFT(@Plant, LEN(@Plant) - 1)
		
		RETURN @Plant
		
		
	/*
	-- Declare the return variable here
		DECLARE	@Plant	nvarchar(20),@Temp	NVARCHAR(5)
		DECLARE	@PriceMaster	Table
		(
			T$CWAR	NVARCHAR(3),
			T$PLNT	NVARCHAR(5)
		)
		SET @Plant = ''
		SET @Temp  = ''

	-- Add the T-SQL statements to compute the return value here
		-- Get all of relation plant
			INSERT INTO @PriceMaster
			SELECT T$CWAR,T$PLNT FROM 
			(
				SELECT T$CWAR,T$PLNT
				FROM    HKGNT111.multekChi_Realtime.dbo.TFSOLP102180
				WHERE	T$COTP <>'SCS'
					AND T$COTP <>'SL8'
					AND T$COTP <>'RSS'
					AND	T$PLNT <> ''
					AND T$PLNT IS NOT NULL
					AND	T$CUNO = @Cuttomer
					AND	T$ITEM = @Item
				GROUP BY T$CUNO,T$ITEM,T$CWAR,T$PLNT
			
				UNION

				SELECT A.T$CWAR,B.T$PLNT FROM multekchi_realtime.dbo.TFSOLP100180 AS A  
					LEFT JOIN FactoryLoading.dbo.TFSCPP201 as b
					ON A.T$CWAR = B.T$CWAR
				WHERE A.T$CWAR <> ''
					AND	T$CUNO = @Cuttomer
					AND	T$ITEM = @Item
				GROUP BY A.T$CUNO,A.T$ITEM,A.T$CWAR,B.T$PLNT
			) A
			GROUP BY T$CWAR,T$PLNT

			UPDATE @PriceMaster SET T$PLNT = 'HK' FROM @PriceMaster WHERE T$CWAR IN ('452','474')

		DECLARE	Plant CURSOR FOR 
		SELECT T$PLNT FROM @PriceMaster where T$PLNT is not null and T$PLNT <> ''
		OPEN Plant
		FETCH	NEXT FROM Plant INTO @Temp
		WHILE @@FETCH_STATUS= 0 
			BEGIN
				SET @Plant = (CASE @Plant WHEN '' THEN '' ELSE @PLANT+',' END) + @Temp
				FETCH	NEXT FROM Plant INTO @Temp
			END
		CLOSE Plant
		DEALLOCATE Plant

	-- Return the result of the function
	RETURN @Plant
	*/

END


GO

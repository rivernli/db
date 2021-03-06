USE [DataWarehouse]
GO
/****** Object:  View [dbo].[DW_DIM_Product_Type_Mapping]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[DW_DIM_Product_Type_Mapping]
AS
SELECT [T$ITEM],
       [T$VALU],
	   (
			CASE 
				WHEN LTRIM(SUBSTRING(T$VALU,1,3))  = 'STD'				THEN 'STD'
				WHEN LTRIM(SUBSTRING(T$VALU,1,3))  = 'BVH'				THEN 'BVH'
				WHEN LTRIM(SUBSTRING(T$VALU,1,4))  = 'ELIC'				THEN 'ELIC'
				WHEN LTRIM(SUBSTRING(T$VALU,1,13)) = 'ATTACHED COIN'	THEN 'ATTACHED COIN'
				WHEN LTRIM(SUBSTRING(T$VALU,1,14)) = 'PRESS-FIT COIN'	THEN 'PRESS-FIT COIN'
				WHEN LTRIM(SUBSTRING(T$VALU,1,13)) = 'EMBEDDED COIN'	THEN 'EMBEDDED COIN'
				WHEN CHARINDEX('+',T$VALU)>0 
					THEN SUBSTRING(T$VALU,1,CHARINDEX('+',T$VALU))+'N'+REVERSE(SUBSTRING(REVERSE(T$VALU),1,CHARINDEX('+',REVERSE(T$VALU))))
			END
		) AS T$STAD
  FROM [FactoryLoading].[dbo].[TFSAMI028180]
  WHERE T$ITEM = 'TYPE'
  
  --select * FROM [FactoryLoading].[dbo].[TFSAMI028180]
  --WHERE T$ITEM = 'TYPE' and t$valu like N'%HDI%'

GO

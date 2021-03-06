USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_TESTING]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_TESTING]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT	
			T711.T$PLNT,
			T711.T$ITEM,
			T711.T$PRIC,
			SUM(T711.T$TQUA) AS T$TQUA,
			CAST(SUM(T711.T$AMNT) AS DECIMAL(18,4)) AS T$AMNT,
			CAST(SUM(T711.T$SQFT) AS DECIMAL(18,4)) AS T$SQFT,
			dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,'2011-04-01','T$CESU') AS T$CESU,
			dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,'2011-04-01','T$CISU') AS T$CISU,
			dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,'2011-04-01','T$TCIU') AS T$TCIU,
			dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,'2011-04-01','T$TCUU') AS T$TCUU,
			CAST(dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,'2011-04-01','T$BUSP') AS INT) AS T$BUSP,
			CAST(dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,'2011-04-01','T$SERN') AS INT) AS T$SERN
	FROM	FactoryLoading.dbo.TFSCPP711180 AS T711
	WHERE	T711.T$PLNT <> '2F' AND T711.T$PLNT <> 'HK'
	AND		T711.T$asdt BETWEEN '2011-04-01' AND '2011-04-29'
	GROUP BY T711.T$PLNT,T711.T$ITEM,T711.T$PRIC
	ORDER BY T711.T$PLNT,T711.T$ITEM,T711.T$PRIC
END



GO

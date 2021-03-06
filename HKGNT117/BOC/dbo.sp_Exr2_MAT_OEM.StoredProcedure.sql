USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MAT_OEM]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MAT_OEM]
	@Plant NVARCHAR(50),
	@Domain  nvarchar(50),
    @UserId  nvarchar(50)
AS
BEGIN
	--找出用戶的ID.
	DECLARE @id INT
	SELECT TOP 1 @id=sysuserid  FROM [Multek_BI].[dbo].[GAM_USERS] WHERE [uid]=@UserId AND [domain]=@Domain
	--列出用戶對應可以看的OEM
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#OEMList') AND TYPE = 'U')
		DROP TABLE [#OEMList]
	SELECT [OEMName] INTO [#OEMList] FROM [Multek_BI].[dbo].[fx_getSalesForMKTRPT](@id) GROUP BY [OEMName]
    DECLARE  @ListNumber int
    SELECT   @ListNumber=count(*) FROM  [#OEMList]
    
	IF @Plant = 'ALL'
	BEGIN
		IF @ListNumber>0
		BEGIN
			SELECT  [OEMName]
			FROM(
				SELECT  'ALL' AS [OEMName], ''AS [g]
				UNION ALL
				SELECT  T.[OEMName], 'o'AS [g]
				FROM    [CostDetail]AS T, [#OEMList] AS B 
				WHERE T.[OEMName]= B.[OEMName] 
				GROUP BY T.[OEMName] 
			)AS T
			ORDER BY [g], [OEMName] 
		END
		ELSE
		BEGIN
			SELECT  [OEMName]
			FROM(
				SELECT  'ALL' AS [OEMName], ''AS [g]
				UNION ALL
				SELECT  [OEMName], 'o'AS [g]
				FROM    [CostDetail]
				GROUP BY [OEMName]
			)AS T
			ORDER BY [g], [OEMName] 
		END
	END
	ELSE
	BEGIN
		IF @ListNumber>0
		BEGIN
			SELECT  [OEMName]
			FROM(
				SELECT  'ALL' AS [OEMName], ''AS [g]
				UNION ALL
				SELECT  T.[OEMName], 'o'AS [g]
				FROM    [CostDetail]AS T, [#OEMList] AS B 
				WHERE T.[OEMName]= B.[OEMName]  
					AND  T.[Plant] = @plant
				GROUP BY T.[OEMName] 
			)AS T
			ORDER BY [g], [OEMName] 
		END
		ELSE
		BEGIN
			SELECT  [OEMName]
			FROM(
				SELECT  'ALL' AS [OEMName], ''AS [g]
				UNION ALL
				SELECT  [OEMName], 'o'AS [g]
				FROM    [CostDetail]
				WHERE [Plant] = @plant
				GROUP BY [OEMName]
			)AS T
			ORDER BY [g], [OEMName] 
		END
	END
	
	--Delete Table
	DROP TABLE [#OEMList]
END



GO

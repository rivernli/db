USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MAT_Layers]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MAT_Layers]
	@Plant nvarchar(50)
	,@OEM  nvarchar(50)
	,@Technology nvarchar(50)
	,@Domain  nvarchar(50)
    ,@UserId  nvarchar(50)
AS
BEGIN
	--找出用戶的ID.
	DECLARE @id INT
	SELECT TOP 1 @id=sysuserid  FROM [Multek_BI].[dbo].[GAM_USERS] WHERE [uid]=@UserId AND [domain]=@Domain
	--列出用戶對應可以看的OEM
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#OEMList') AND TYPE = 'U')
		DROP TABLE [#OEMList]
	SELECT  [OEMName] INTO [#OEMList] FROM [Multek_BI].[dbo].[fx_getSalesForMKTRPT](@id) GROUP BY [OEMName]
    DECLARE  @ListNumber int
    SELECT   @ListNumber=count(*) FROM  [#OEMList]
    
	IF @Plant = 'ALL'
	BEGIN
		IF @OEM = 'ALL'
		BEGIN
			IF @ListNumber>0
			BEGIN
				SELECT     T.[Layers]
				FROM       [CostDetail] AS T, [#OEMList] AS B 
				WHERE    T.[OEMName]= B.[OEMName] 
							AND T.[Technology]=@Technology
				GROUP BY T.[Layers]
				ORDER BY T.[Layers]
			END
			ELSE
			BEGIN
				SELECT     [Layers]
				FROM       [CostDetail]
				WHERE    [Technology]=@Technology
				GROUP BY [Layers]
				ORDER BY [Layers]
			END
		END
		ELSE
		BEGIN
			SELECT     [Layers]
			FROM       [CostDetail]
			WHERE     [OEMName] = @OEM 
				AND [Technology]=@Technology
			GROUP BY [Layers]
			ORDER BY [Layers]
		END
	END
	ELSE
	BEGIN
		IF @OEM = 'ALL'
		BEGIN
			IF @ListNumber>0
			BEGIN
				SELECT     T.[Layers]
				FROM       [CostDetail] AS T, [#OEMList] AS B 
				WHERE    T.[Plant] = @plant
							AND T.[OEMName]= B.[OEMName] 
							AND T.[Technology]=@Technology
				GROUP BY T.[Layers]
				ORDER BY T.[Layers]
			END
			ELSE
			BEGIN
				SELECT     [Layers]
				FROM       [CostDetail]
				WHERE     [Plant] = @plant
							AND [Technology]=@Technology
				GROUP BY [Layers]
				ORDER BY [Layers]
			END
		END
		ELSE
		BEGIN
			SELECT     [Layers]
			FROM       [CostDetail]
			WHERE     [Plant] = @plant
				AND [OEMName] = @OEM 
				AND [Technology]=@Technology
			GROUP BY [Layers]
			ORDER BY [Layers]
		END
	END
	
END


GO

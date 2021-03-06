USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MAT_Technology]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MAT_Technology]
	@Plant nvarchar(50)
	,@OEM  nvarchar(50)
	,@Technology nvarchar(50)=NULL
	,@Domain  nvarchar(50)
    ,@UserId  nvarchar(50)
AS
BEGIN
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#Temp') and type = 'U')
	drop table [#Temp]
	
	SELECT [Technology], [OEMName]
	INTO [#Temp]
	FROM [CostDetail]
	WHERE 1<>1
	
	IF @Plant = 'ALL'
	BEGIN
		IF @OEM = 'ALL'
		BEGIN
			INSERT INTO [#Temp]
			SELECT  LTRIM(RTRIM([Technology]))AS [Technology], [OEMName]
			FROM         [CostDetail]
			WHERE    [Technology] IS NOT NULL
			GROUP BY [Technology], [OEMName]
			ORDER BY [Technology], [OEMName]
		END
		ELSE
		BEGIN
			INSERT INTO [#Temp]
			SELECT  LTRIM(RTRIM([Technology]))AS [Technology], [OEMName]
			FROM         [CostDetail]
			WHERE   [OEMName] = @OEM
				AND [Technology] IS NOT NULL
			GROUP BY [Technology], [OEMName]
			ORDER BY [Technology], [OEMName]
		END
	END
	ELSE
	BEGIN
		IF @OEM = 'ALL'
		BEGIN
			INSERT INTO [#Temp]
			SELECT  LTRIM(RTRIM([Technology]))AS [Technology], [OEMName]
			FROM         [CostDetail]
			WHERE Plant = @plant
				AND [Technology] IS NOT NULL
			GROUP BY [Technology], [OEMName]
			ORDER BY [Technology], [OEMName]
		END
		ELSE
		BEGIN
			INSERT INTO [#Temp]
			SELECT  LTRIM(RTRIM([Technology]))AS [Technology], [OEMName]
			FROM         [CostDetail]
			WHERE Plant = @plant
				AND [Technology] IS NOT NULL
				AND [OEMName] = @OEM
			GROUP BY [Technology], [OEMName]
			ORDER BY [Technology], [OEMName]
		END
	END
	
	--找出用戶的ID.
	DECLARE @id INT
	SELECT TOP 1 @id=sysuserid  FROM [Multek_BI].[dbo].[GAM_USERS] WHERE [domain]=@Domain AND [uid]=@UserId
	--列出用戶對應可以看的OEM
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#OEMList') AND TYPE = 'U')
		DROP TABLE [#OEMList]
	SELECT  [OEMName] INTO [#OEMList] FROM [Multek_BI].[dbo].[fx_getSalesForMKTRPT](@id) GROUP BY [OEMName]
    DECLARE  @ListNumber int
    SELECT   @ListNumber=count(*) FROM  [#OEMList]
    IF @ListNumber>0 
    BEGIN
		   DELETE [#Temp] WHERE [OEMName] NOT IN(SELECT [OEMName] FROM [#OEMList]) 
	END
	
	IF @Technology IS NULL
	BEGIN
		SELECT [Technology]
		FROM [#Temp]
		GROUP BY  [Technology]
	END
	ELSE
	BEGIN
		SELECT [Technology]
		FROM [#Temp]
		WHERE [Technology] Like '%'+ @Technology +'%' 
		GROUP BY  [Technology]
	END
	
END



GO

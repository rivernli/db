USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_Plant]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_Exr2_Plant]
	@Domain  nvarchar(50),
    @UserId  nvarchar(50)
AS
BEGIN
	--找出用戶的ID.
	DECLARE @id INT
	SELECT TOP 1 @id=sysuserid  FROM [Multek_BI].[dbo].[GAM_USERS] WHERE [uid]=@UserId AND [domain]=@Domain
	
	--列出用戶對應可以看的OEM
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#PlantList') AND TYPE = 'U')
		DROP TABLE [#PlantList]
	SELECT [Plant] INTO [#PlantList] FROM [Multek_BI].[dbo].[fx_getSalesForMKTRPT](@id) GROUP BY [Plant]
    DECLARE  @ListNumber int
    SELECT   @ListNumber=count(*) FROM  [#PlantList]
    IF @ListNumber>0
    BEGIN
		SELECT 'ALL' AS [Plant]
		UNION ALL
		SELECT [Plant] FROM [#PlantList] WHERE  [Plant]!= '2F' AND [Plant]!= 'HK' AND [Plant]!= '12'
	END
	ELSE
	BEGIN
		SELECT [Plant] FROM [#PlantList] WHERE  1<>1
	END
	
	
	--Delete Table
	DROP TABLE [#PlantList]
END


GO

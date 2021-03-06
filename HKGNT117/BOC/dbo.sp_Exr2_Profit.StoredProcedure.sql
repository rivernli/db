USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_Profit]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_Profit]
	@PercentageType   nvarchar(20),
	@FYear   nvarchar(10),
	@FPeriod nvarchar(10),
	@plant   nvarchar(15),
	@top     int,
	@Type    nvarchar(30),
    @UserId  nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000)
	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @FPeriod = LTRIM(RTRIM(@FPeriod))

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE #CostDetails
	SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount INTO #CostDetails FROM dbo.CostDetail WHERE 1 <> 1

	-- get details data 
	IF @plant <> 'ALL'
		BEGIN
			IF @FPeriod <> 'P'
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount 
					FROM dbo.CostDetail
					WHERE FYear = @FYear and Plant = @plant and Period = @FPeriod
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount
					FROM dbo.CostDetail
					WHERE FYear = @FYear and Plant = @plant
				END
		END
	ELSE
		BEGIN
			IF @FPeriod <> 'P'
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount
					FROM dbo.CostDetail
					WHERE FYear = @FYear  and Period = @FPeriod
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount 
					FROM dbo.CostDetail
					WHERE FYear = @FYear
				END
		END

--	UPDATE #CostDetails SET PERCENTAGE = 0 WHERE UnitPrice = 0
	DELETE #CostDetails WHERE ISNULL(MATCost,0)= 0 OR  ISNULL(UnitPrice,0) = 0

	ALTER TABLE #CostDetails ADD OEM_NAME NVARCHAR(50)
	UPDATE #CostDetails SET OEM_NAME = (select X.OEM_Name from dbo.CostItemMatchOEM AS X where X.item = #CostDetails.project)
	
	--Percentage
	ALTER TABLE #CostDetails ADD PERCENTAGE decimal(18,4)
	IF @PercentageType = 'Yield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([StdCostIncludedScrap],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4))
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([StdCostExcludedScrap],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4))
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([t$cisu],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) 
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([MATCost],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4))
		END
		
		
	
	

    DECLARE  @User1Number int
    SELECT   @User1Number=count(*) FROM  RightUserTable WHERE RightUserTable.suid=@UserId
    IF @User1Number>0
    BEGIN
       declare @RightOEM table(OEM NVARCHAR(50) )
       INSERT INTO  @RightOEM 
       SELECT  RightOEMTable.oem FROM RightOEMTable INNER JOIN RightUserTable ON RightOEMTable.suid = RightUserTable.suid
	   WHERE RightUserTable.suid=@UserId OR RightUserTable.muid=@UserId
	   
	   IF @Type = 'ALL'
		BEGIN
			IF @top = 0 
				BEGIN
					SELECT * FROM #CostDetails  WHERE OEM_NAME In(SELECT OEM FROM @RightOEM )  order by PERCENTAGE desc
				END
			ELSE
				BEGIN
					SELECT top(@top) * FROM #CostDetails  WHERE OEM_NAME In(SELECT OEM FROM @RightOEM )  order by SalesAmount desc,PERCENTAGE desc
				END	
		END
		ELSE
		BEGIN
		   IF @top = 0 
				BEGIN
					exec('SELECT * FROM #CostDetails WHERE PERCENTAGE'+ @Type +'   AND OEM_NAME In(SELECT OEM FROM @RightOEM ) order by PERCENTAGE desc')
				END
			ELSE
				BEGIN
					exec('SELECT top(' +@top+ ') * FROM #CostDetails WHERE PERCENTAGE'+ @Type +'  AND OEM_NAME In(SELECT OEM FROM @RightOEM )   order by SalesAmount desc,PERCENTAGE desc')
				END	
		END


	    
	END
    ELSE
    BEGIN
 
	    IF @Type = 'ALL'
		BEGIN
			IF @top = 0 
				BEGIN
					SELECT * FROM #CostDetails order by PERCENTAGE desc
				END
			ELSE
				BEGIN
					SELECT top(@top) * FROM #CostDetails order by SalesAmount desc,PERCENTAGE desc
				END	
	    END
	    ELSE
	    BEGIN
		   IF @top = 0 
				BEGIN
					exec('SELECT * FROM #CostDetails WHERE PERCENTAGE'+ @Type +' order by PERCENTAGE desc')
				END
			ELSE
				BEGIN
					exec('SELECT top('+ @top +') * FROM #CostDetails WHERE PERCENTAGE'+ @Type +'  order by SalesAmount desc,PERCENTAGE desc')
				END	
	    END

	END


	


END


GO

USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrenedPlant]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrenedPlant]
@type nvarchar(20),
@plant_From nvarchar(10),
@plant_To nvarchar(10)
as
	set nocount on
	declare @Result nvarchar(100)

	set @type = isnull(@type,'')
	set @plant_From = isnull(@plant_From,'')
	set @plant_To = isnull(@plant_To,'')
	IF  @plant_To = '' 
		SET @plant_To = 'ZZ'

	IF @type = 'Bind'
		BEGIN
			select distinct t$plnt into #temp_plant from dbo.TFSPUR034180
			where t$plnt not like  N'%|%'
			order by t$plnt

			--DELETE table #temp_plant where 
			ALTER TABLE #temp_plant ADD DSCA NVARCHAR(5)
			UPDATE #temp_plant SET DSCA = t$plnt
			UPDATE #temp_plant SET DSCA = 'B1' WHERE t$plnt = 'P2'
			INSERT #temp_plant(t$plnt,DSCA) values('','')
			INSERT #temp_plant(t$plnt,DSCA) values('ZZ','ZZ')
			SELECT * FROM #temp_plant ORDER BY DSCA
		END
	IF @type = 'Selection'
		BEGIN
			BEGIN
				IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TTTT') and TYPE = 'U')
					DROP TABLE #TTTT
				select distinct t$plnt into #TTTT
				from dbo.TFSPUR034180 
				where t$plnt not like  N'%|%' --t$plnt between @plant_From and @plant_To
				--and	  t$plnt <> '|'
				order by t$plnt
			END
	
			UPDATE #TTTT SET t$plnt = 'B1' WHERE t$plnt = 'P2'
			SELECT * INTO #Templant FROM #TTTT ORDER BY t$plnt
			DROP TABLE #TTTT

			SET @Result = ''			-- It's very importment for this segment.
			SELECT @Result = @Result + ',' + t$plnt +'' from  #Templant WHERE t$plnt between @plant_From and @plant_To
			SET @Result = RIGHT(@Result,LEN(@Result)-1)
			--SET @Result =STUFF(@Result,1,1,'')

			SELECT @Result as t$plnt
		END

GO

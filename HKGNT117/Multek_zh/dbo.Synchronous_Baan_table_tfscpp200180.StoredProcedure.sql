USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Synchronous_Baan_table_tfscpp200180]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Synchronous_Baan_table_tfscpp200180]
AS
BEGIN
	SET NOCOUNT ON;

	-- Get Data from Baan to temp table 
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempfscpp200180') AND TYPE = 'U')
			DROP TABLE #tempfscpp200180

		SELECT * INTO #tempfscpp200180 FROM OPENQUERY(as1p1,'select t$pitm,t$pver,t$item,t$pfix,t$otyp,t$prdn from baan.tfscpp200180')

		UPDATE #tempfscpp200180 set t$item = ltrim(rtrim(T$PFIX))+ltrim(rtrim(T$PITM))+ltrim(rtrim(T$PVER)) from #tempfscpp200180 where t$item = ''

--	-- Insert new data to final table 
	-- Update old data when product type or project type changed
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempchange') AND TYPE = 'U')
			DROP TABLE #tempchange
		
		INSERT INTO multekchi_realtime.dbo.TFSCPP200180_link(t$pitm,t$pver,t$pfix,t$item,t$otyp,t$prdn)
		SELECT t1.t$pitm,t1.t$pver,t1.t$pfix,t1.t$item,t1.t$otyp,t1.t$prdn 
		FROM #tempfscpp200180 AS t1
		WHERE T1.T$ITEM NOT IN
		(
			SELECT T2.T$ITEM FROM MULTEKCHI_REALTIME.DBO.TFSCPP200180_LINK AS T2
		)

		SELECT t1.t$pitm,t1.t$pver,t1.t$pfix,t1.t$item,t1.t$otyp,t1.t$prdn INTO #tempchange FROM #tempfscpp200180 AS t1 ,multekchi_realtime.dbo.TFSCPP200180_link AS t2
		WHERE	T1.T$ITEM = T2.T$ITEM 
		AND		(t1.t$prdn <> t2.t$prdn or t1.t$otyp <> t2.t$otyp)

		UPDATE multekchi_realtime.dbo.TFSCPP200180_link SET t$prdn = X.t$prdn,t$otyp = X.t$otyp FROM #tempchange AS X,multekchi_realtime.dbo.TFSCPP200180_link AS A
		WHERE A.t$item = X.t$item

END

GO

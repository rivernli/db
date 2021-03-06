USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Synchronous_Baan_table_tfscpp200180_orginal]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Synchronous_Baan_table_tfscpp200180_orginal]
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempfscpp200180') AND TYPE = 'U')
		drop table #tempfscpp200180

	select * into #tempfscpp200180 from openquery(as1p1,'select t$pitm,t$pver,t$item,t$pfix,t$otyp,t$prdn from baan.tfscpp200180')

	INSERT INTO multekchi_realtime.dbo.TFSCPP200180_link(t$pitm,t$pver,t$pfix,t$item,t$otyp,t$prdn) 
	SELECT t$pitm,t$pver,t$pfix,t$item,t$otyp,t$prdn  FROM #tempfscpp200180 
	WHERE t$pitm+t$pver+t$pfix NOT IN(SELECT X.t$pitm+X.t$pver+X.t$pfix FROM multekchi_realtime.dbo.TFSCPP200180_link AS X)
	OR t$item NOT IN(SELECT X.t$item FROM multekchi_realtime.dbo.TFSCPP200180_link AS X)

	UPDATE multekchi_realtime.dbo.TFSCPP200180_link SET t$prdn = X.t$prdn,t$otyp = X.t$otyp FROM #tempfscpp200180 AS X,multekchi_realtime.dbo.TFSCPP200180_link AS A
	WHERE A.t$pitm = X.t$pitm AND A.t$pver = X.t$pver AND A.t$pfix = X.t$pfix AND (A.t$otyp <> X.t$otyp OR A.t$prdn <> X.t$prdn)

	UPDATE multekchi_realtime.dbo.TFSCPP200180_link SET t$prdn = X.t$prdn,t$otyp = X.t$otyp FROM #tempfscpp200180 AS X,multekchi_realtime.dbo.TFSCPP200180_link AS A
	WHERE  A.t$item = X.t$item AND (A.t$otyp <> X.t$otyp OR A.t$prdn <> X.t$prdn)

END

GO

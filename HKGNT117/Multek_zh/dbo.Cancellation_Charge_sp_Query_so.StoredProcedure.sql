USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Query_so]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_Query_so]
	-- Add the parameters for the stored procedure here
@SO	FLOAT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here 
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tfsolp100') AND TYPE = 'U')
--		DROP TABLE #tfsolp100

	SELECT A.T$ORNO,A.T$PONO,A.T$ITEM,CONVERT(NVARCHAR,A.T$DDTA,111) AS T$DDTA,B.T$PLNT,A.T$OQUA,A.T$BQUA,A.T$CCUR,A.T$PRIC,A.T$ECDT
--	INTO #tfsolp100
	FROM	multekchi_realtime.dbo.TFSOLP100180 as a,FactoryLoading.dbo.TFSCPP201 as b
	WHERE A.T$CWAR = B.T$CWAR	AND A.T$ORNO = @SO
	ORDER BY T$ORNO,T$PONO
	--COMPUTE SUM(A.T$BQUA) BY T$ORNO

--	UPDATE #tfsolp100 SET T$OQUA = (SELECT SUM(T$OQUA) FROM multekchi_realtime.dbo.TFSOLP100180 WHERE T$ORNO = @SO)

--	SELECT * FROM #tfsolp100
END


GO

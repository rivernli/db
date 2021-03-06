USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[new_M6_auto_analysis_current_to_Next]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[new_M6_auto_analysis_current_to_Next]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare	@LOOP	INT;
	DECLARE	@MAX	INT;
	DECLARE	@NEXT	INT;

    -- Insert statements for procedure here
	SET @LOOP = 1
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#m6') AND TYPE = 'U')
		DROP TABLE #m6

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#cur_Number') AND TYPE = 'U')
		DROP TABLE #cur_Number

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#temp') AND TYPE = 'U')
		DROP TABLE #temp

	CREATE TABLE #m6
	(
		ID		INT IDENTITY,
		DATE	DATETIME,
	)

	CREATE TABLE #cur_Number
	(
		ID		INT
	)

	CREATE TABLE #temp
	(
		DATE	DATETIME,
		NUMBER	INT
	)
	
	INSERT INTO #M6(DATE)
	SELECT DATE FROM M6 GROUP BY DATE ORDER BY DATE

		INSERT INTO #cur_Number(ID)
		SELECT ID FROM #m6 AS A
		WHERE A.DATE IN
		(
			SELECT B.DATE FROM M6 AS B WHERE B.issp = 0 and B.number = @LOOP
		)

		UPDATE #cur_Number SET ID = ID + 1  -- Move to next period

		INSERT INTO #TEMP(DATE,NUMBER)
		SELECT DATE,NUMBER FROM m6 WHERE DATE IN
		(
			SELECT DATE FROM #M6 WHERE ID IN (SELECT ID FROM #cur_Number)
		)
		AND ISSP = 0

		SELECT top 8 NUMBER,COUNT(*) AS aa FROM #TEMP GROUP BY NUMBER ORDER BY aa desc
END

GO

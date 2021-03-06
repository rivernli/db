USE [multekChi_Realtime]
GO
/****** Object:  StoredProcedure [dbo].[sp_Check_Baan_Base_Table_Row_Count]    Script Date: 11/06/2014 15:53:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Check_Baan_Base_Table_Row_Count]
	-- Add the parameters for the stored procedure here
	@Date DATETIME,
	@RowCount INT OUTPUT,
	@Table VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Temp TABLE(Count INT)
	DECLARE @SQLString VARCHAR(MAX)
	IF @Table='tfhacr051183'
		BEGIN
			SET @SQLString='SELECT * FROM  OPENQUERY(AS1P1ORACLE,'+''''+'SELECT COUNT(*) AS Count FROM BAAN.'+@Table+' WHERE (T$DDTA=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''') OR '+'t$trdt=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''')) AND t$dqua <> 0 '+''''+')'
		END
	IF @Table='ttdsls045180'
		BEGIN
			--SET @SQLString='SELECT * FROM  OPENQUERY(AS1P1ORACLE,'+''''+'SELECT COUNT(*) AS Count FROM BAAN.'+@Table+' WHERE (T$DDAT=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''') OR '+'T$INVD=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''')) AND t$dqua <> 0 AND trim(t$cuno) <> '+''''''+'ATL'+''''+''''''+')'
			SET @SQLString='SELECT * FROM  OPENQUERY(AS1P1ORACLE,'+''''+'SELECT COUNT(*) AS Count FROM BAAN.'+@Table+' WHERE (T$DDAT=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''') OR '+'T$INVD=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''')) AND t$dqua <> 0 AND trim(t$cuno) <> '+''''''+'ATL'+''''+''''''+')'
		END
	IF @Table='ttdsls045183'
		BEGIN
			SET @SQLString='SELECT * FROM  OPENQUERY(AS1P1ORACLE,'+''''+'SELECT COUNT(*) AS Count FROM BAAN.'+@Table+' WHERE (T$DDAT=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''') OR '+'t$INVD=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''')) AND t$dqua <> 0 '+''''+')'
		END
	IF @Table='tfsolp102180'
		BEGIN
			SET @SQLString='SELECT * FROM  OPENQUERY(AS1P1ORACLE,'+''''+'SELECT COUNT(*) AS Count FROM BAAN.'+@Table+' WHERE (T$DDAT=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''') OR '+'T$INVD=TO_DATE('+''''''+CONVERT(VARCHAR(10),@Date,120)+''''''+',''''yyyy-mm-dd'''')) AND t$dqua <> 0 '+''''+')'
		END
	INSERT INTO @Temp
	EXECUTE (@SQLString)
	SET @RowCount=ISNULL((SELECT Count FROM @Temp),0)
END
GO

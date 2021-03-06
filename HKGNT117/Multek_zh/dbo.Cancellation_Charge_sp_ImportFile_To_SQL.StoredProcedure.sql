USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_ImportFile_To_SQL]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_ImportFile_To_SQL]
@File	nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQL				NVARCHAR(MAX)
	DECLARE	@Provider			NVARCHAR(100)
	--DECLARE	@FILE			NVARCHAR(256)
	DECLARE	@ConnectionString	NVARCHAR(1000)
	DECLARE	@Query				NVARCHAR(1000)

	SET @Provider          = N'Microsoft.Jet.OLEDB.4.0'
	SET @FILE              = RTRIM(LTRIM(@FILE))
	SET @ConnectionString  = N'Excel 8.0;DATABASE='+@FILE+';HDR=YES;IMEX=1'
	SET @Query             = N'SELECT * FROM [Sheet1$]'

	SET @SQL = N'SELECT [SO],[Line],[Item],[Quanlity]	FROM OPENROWSET(' 
			+ QUOTENAME(@Provider, N'''') + N', ' 
			+ QUOTENAME(@ConnectionString, N'''') + N', '
			+ QUOTENAME(@Query, N'''') + N')'

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#cancellationTemp') AND TYPE = 'U')
		DROP TABLE #cancellationTemp

	CREATE TABLE #cancellationTemp
	(
		T$ORNO	NVARCHAR(6),
		T$PONO	INT,
		T$ITEM	NVARCHAR(35),
		T$QUAN	DECIMAL(18,0)
	)

	BEGIN 
		INSERT INTO #cancellationTemp
		EXEC SP_EXECUTESQL @SQL
	END

	IF @@ROWCOUNT > 0
		BEGIN
			--DELETE DUPLATE DATA
			DELETE #cancellationTemp FROM #cancellationTemp AS A,dbo.Cancellation_Charge_PPC_FG AS B
			WHERE A.T$ORNO = B.T$ORNO AND A.T$PONO = B.T$PONO

			IF EXISTS(SELECT TOP 1 * FROM #cancellationTemp)
				BEGIN
					INSERT INTO dbo.Cancellation_Charge_PPC_FG
					SELECT A.* FROM #cancellationTemp
				END
		END
END

GO

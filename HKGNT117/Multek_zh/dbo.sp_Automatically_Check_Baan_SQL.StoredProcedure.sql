USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Automatically_Check_Baan_SQL]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Automatically_Check_Baan_SQL] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-------------------------------------------------------------------------------------------------------
    -- Get HKGNT117 & HKGNT111 SQL FSOLP Table information
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#TableList') AND TYPE = 'U')
			DROP TABLE #TableList

		CREATE TABLE #TableList(
			Table_Qualifier VARCHAR(100),
			Table_Owner		VARCHAR(100),
			Table_Name		VARCHAR(100),
			Table_Type		VARCHAR(100),
			Remarks			VARCHAR(100)
			)

		INSERT INTO #TableList
		EXECUTE SP_TABLES @TABLE_NAME = '%FSOLP%'

		INSERT INTO #TableList
		EXECUTE HKGNT111.Multek_SZ_New..SP_TABLES @TABLE_NAME = '%FSOLP%'

		DELETE #TableList FROM #TableList
		WHERE Table_Qualifier+Table_Owner+Table_Name NOT IN
		(
			SELECT Table_Qualifier+Table_Owner+Table_Name FROM #TableList WHERE Table_Name LIKE 'tfsolp%' AND Table_Type='Table' AND LEN(RTRIM(TABLE_NAME))= 12
		)

		DELETE #TableList FROM #TableList where Table_Name = 'TFSOLP129180'

		ALTER TABLE #TableList ADD ID			INT IDENTITY
		ALTER TABLE #TableList ADD SQL_COUNT	INT
		ALTER TABLE #TableList ADD BAAN_COUNT	INT
		ALTER TABLE #TableList ADD DIFF			INT
--		CREATE INDEX TableList_ID ON #TableList (ID)
	-------------------------------------------------------------------------------------------------------
	-- Get Table data count 
		DECLARE	@MAX			INT
		DECLARE	@LOOP			INT
		DECLARE	@DB_NAME		VARCHAR(100)
		DECLARE	@DB_OWNER		VARCHAR(100)
		DECLARE	@TABLE_NAME		VARCHAR(100)
		DECLARE @LinkedServer	VARCHAR(100)
		DECLARE	@SQLString		VARCHAR(MAX)

		SET		@LOOP = 1
		SELECT @MAX = MAX(ID)  FROM #TableList

		WHILE @LOOP <= @MAX
			BEGIN
				SELECT @DB_NAME = Table_Qualifier,@DB_OWNER = Table_Owner,@TABLE_NAME = Table_Name
				FROM #TableList WHERE ID = @LOOP

				-- Update SQL Data Records
					IF @DB_NAME = 'Multek_ZH'
						BEGIN
							SET @SQLString = 'UPDATE #TableList SET SQL_COUNT = (SELECT COUNT(*) FROM ['+
											@DB_NAME+'].['+@DB_OWNER+'].['+@TABLE_NAME +
											']) FROM #TableList WHERE ID = '+CAST(@LOOP AS NVARCHAR(3))
						END
					IF @DB_NAME = 'Multek_SZ_New'
						BEGIN
							SET @LinkedServer = 'HKGNT111'
							SET @SQLString = 'UPDATE #TableList SET SQL_COUNT = (SELECT COUNT(*) FROM ['+
											@LinkedServer+'].'+'['+
											@DB_NAME+'].['+@DB_OWNER+'].['+@TABLE_NAME +
											']) FROM #TableList WHERE ID = '+CAST(@LOOP AS NVARCHAR(3))
						END

					EXECUTE (@SQLString)

				-- Update Oracle Table Recouds
					SET @SQLString = '
						UPDATE #TableList SET BAAN_COUNT =
						(
							SELECT Baan_Count FROM OPENQUERY(AS1P1,'+''''+'SELECT COUNT(*) as Baan_Count FROM BAAN.'+@TABLE_NAME+''''+')
						)
						FROM #TableList
						WHERE ID = '+CAST(@LOOP AS NVARCHAR(3))
--					SET @SQLString = '
--						UPDATE #TableList SET BAAN_COUNT =
--						(
--							SELECT num_rows FROM OPENQUERY(AS1P1,'+''''+'select num_rows from dba_indexes where table_name = '+''''++''''+@TABLE_NAME+''''+''''+' AND INDEX_NAME LIKE '+''''+''''+'%IDX1'+''''+''''')
--						)
--						FROM #TableList
--						WHERE ID = '+CAST(@LOOP AS NVARCHAR(3))

					EXECUTE (@SQLString)

				-- Update Tepm table difference 
					UPDATE #TableList SET DIFF = BAAN_COUNT - SQL_COUNT

				SET @LOOP = @LOOP + 1
			END

	-------------------------------------------------------------------------------------------------------
	-- Save Result
		ALTER TABLE #TableList DROP COLUMN ID
		TRUNCATE TABLE TFSOLP_TABLE_STATUS 
		INSERT INTO TFSOLP_TABLE_STATUS 
		SELECT * FROM #TableList
	-------------------------------------------------------------------------------------------------------
	-- Send result to administratot
	DECLARE	@EmailBody VARCHAR(MAX)
	DECLARE @To NVARCHAR(MAX),@Subject NVARCHAR(MAX)
	DECLARE	@SQLData	INT
	DECLARE	@BaanData	INT
	DECLARE	@Diff		INT

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#ResultTable') AND TYPE = 'U')
			DROP TABLE #ResultTable

	SELECT * INTO #ResultTable FROM TFSOLP_TABLE_STATUS WHERE DIFF <> 0

	SET @MAX = (SELECT COUNT(*) FROM #ResultTable)
	IF @MAX <> 0 
		BEGIN
--			ALTER TABLE #ResultTable DROP COLUMN ID
			ALTER TABLE #ResultTable ADD ID INT IDENTITY

			SET @EmailBody=''
			SET @EmailBody=@EmailBody+'<html><body><br><hr/>'
		    SET @EmailBody=@EmailBody+'<table width=100%  style='+''''+'FONT-SIZE: 10pt ; background-color: white; font-family: '+''''+'Times New Roman'+''''+';'+''''+' border=1 cellpadding=1 cellspacing=1>'
			SET @EmailBody=@EmailBody+'<TR align=left style='+''''+'font-weight: bold; color: white; background-color: navy;'+''''+'>'
			-- Header
			SET @EmailBody=@EmailBody+'<td>Database Name</td>'
			SET @EmailBody=@EmailBody+'<td>Owner</td>'
			SET @EmailBody=@EmailBody+'<td>Table Name</td>'
			SET @EmailBody=@EmailBody+'<td>SQL Count</td>'
			SET @EmailBody=@EmailBody+'<td>Baan Count</td>'
			SET @EmailBody=@EmailBody+'<td>Difference</td>'
			SET @EmailBody=@EmailBody+'</tr>'
			-- Details
			SET		@LOOP = 1
			WHILE @LOOP <= @MAX
				BEGIN
					SELECT	@DB_NAME = Table_Qualifier,
							@DB_OWNER = Table_Owner,
							@TABLE_NAME = Table_Name ,
							@SQLData = SQL_COUNT,
							@BaanData = BAAN_COUNT,
							@Diff = DIFF
					FROM #ResultTable WHERE ID = @LOOP

					SET @EmailBody=@EmailBody+'<tr>'
					SET @EmailBody=@EmailBody+'<td>'+@DB_NAME+'</td>'
					SET @EmailBody=@EmailBody+'<td>'+@DB_OWNER+'</td>'
					SET @EmailBody=@EmailBody+'<td>'+@TABLE_NAME+'</td>'
					SET @EmailBody=@EmailBody+'<td>'+CAST(@SQLData AS NVARCHAR(30))+'</td>'
					SET @EmailBody=@EmailBody+'<td>'+CAST(@BaanData AS NVARCHAR(30))+'</td>'
					SET @EmailBody=@EmailBody+'<td>'+CAST(@Diff AS NVARCHAR(30))+'</td>'
					SET @EmailBody=@EmailBody+'</tr>'
					SET @LOOP = @LOOP + 1
				END

			SET @EmailBody=@EmailBody+'</table>'
			SET @EmailBody=@EmailBody+'</body></html>'

		-- SEND EMAIL
		set @Subject = 'There are some sql tables record is difference with Baan!'
		SET @To='Rivern.Li@HK.MULTEK.COM;Charlie.niu@hk.multek.com'

		EXEC	msdb.dbo.sp_send_dbmail
				@profile_name          ='CN-HKGMultekApplications&Business@cn.flextronics.com',
				@recipients            =@To,
				@body                  =@EmailBody, 
				@subject               =@Subject,
				@body_format		   ='HTML'  
		END
END



GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Standard_Cost_Query_Project_List]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Standard_Cost_Query_Project_List]
@Project		NVARCHAR(12),
@Top			NVARCHAR(5),
@Account		VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE	@SQL_STRING	NVARCHAR(MAX)
	DECLARE	@Condition  NVARCHAR(1000)

	SET NOCOUNT ON;
	SET @Project = ISNULL(@Project,'')
	SET @Top	 = ISNULL(@Top,'0')
	
	SET @Account = ISNULL(@Account,'')
--	IF @Account = ''
--		BEGIN
--			RAISERROR('Session timeout!',16,1)
--			return
--		END

	IF @Project = ''
		BEGIN
			RAISERROR('Please enter project first !',16,1)
			RETURN
		END

	SET @Condition = ' FROM dbo.vc_Standard_Cost_TFSBOM400180'
	SET @Condition = @Condition + ' WHERE	T$PJNO LIKE N'+''''+'%'+@Project+'%'+''''
	SET @Condition = @Condition + ' ORDER BY T$SERN DESC,T$VERS Desc'

    -- Insert statements for procedure here
	IF @Top = 0
		BEGIN
			SET @SQL_STRING = 'SELECT T$PLNT,T$PJNO,T$SERN,T$VERS,T$ATYP,T$CRID,
					CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,
					CASE T$STAT when 2 then '+''''+'Confirm'+''''+' else '+''''+'unconfirm'+''''+' end as T$STAT,
					T$CESU '+@Condition
		END
	ELSE
		BEGIN
			SET @SQL_STRING = 'SELECT TOP '+@Top+'T$PLNT,T$PJNO,T$SERN,T$VERS,T$ATYP,T$CRID,
					CONVERT(NVARCHAR,T$CRDT,111) AS T$CRDT,CONVERT(NVARCHAR,T$LCDT,111) AS T$LCDT,
					CASE T$STAT when 2 then '+''''+'Confirm'+''''+' else '+''''+'unconfirm'+''''+' end as T$STAT,
					T$CESU '+@Condition
		END
	EXECUTE(@SQL_STRING)

END





GO

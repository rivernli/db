USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_Autocomplete]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Sheet_Query_Autocomplete]
@prefixText		NVARCHAR(13),
@count			INT,
@Account		varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Account = ISNULL(@Account,'')
--	IF @Account = ''
--		BEGIN
--			RAISERROR('Session timeout!',16,1)
--			return
--		END

--	IF EXISTS(SELECT TOP 1 * FROM dbo.Cost_Sheet_Query_CS_OEM_Authority WHERE ACCOUNT = @Account)
--		BEGIN
--			SELECT DISTINCT TOP(@count) T$PJNO FROM dbo.Cost_Sheet_Query_ProjectList_by_UserOEM WHERE ACCOUNT = @Account and T$PJNO LIKE N'%'+@prefixText+'%' ORDER BY T$PJNO
--		END
--	ELSE
--		BEGIN
			SELECT DISTINCT TOP(@count) T$PJNO 
			FROM dbo.Cost_Sheet_Query_ProjectList 
			WHERE	T$PJNO LIKE N'%'+@prefixText+'%' 
			AND		T$PJNO NOT LIKE N'@%'
			AND		T$PJNO NOT LIKE N'$%'
			AND		(T$APRJ IS NULL OR 	T$APRJ ='')
			ORDER BY T$PJNO
--		END
END



GO

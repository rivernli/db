USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Simple_Cost_Query_Material_Cost]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Simple_Cost_Query_Material_Cost]
@Project	NVARCHAR(13),
@Version	NVARCHAR(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Project = ISNULL(@Project,'')
	SET @Version = ISNULL(@Version,'')

	IF @Project = ''
		BEGIN
			RAISERROR('Please select project first!',16,1)
			RETURN
		END

	IF @Version = ''
		BEGIN
			RAISERROR('Please select version first!',16,1)
			RETURN
		END

	SELECT	T401.T$PJNO,T401.T$SERN,T401.T$SQNO,
			T401.T$AVER,T401.T$VERS,
			T401.T$META,T401.T$COSP,
			T401.T$COSU,T401.T$COSS,
			T401.T$COPR
	FROM	Multek_ZH.dbo.vc_Simple_Cost_TFSBOM401180 AS T401
	WHERE	T401.T$PJNO = @Project
	AND		T401.T$SERN = @Version
	ORDER BY T401.T$PJNO,T401.T$SERN,T401.T$SQNO
	COMPUTE SUM(T401.T$COSP),
			SUM(T401.T$COSU),
			SUM(T401.T$COSS),
			SUM(T401.T$COPR)

END



GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_OEM_List_by_Userid]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Sheet_Query_OEM_List_by_Userid]
@Account	varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Account = ISNULL(@Account,'')

    -- Insert statements for procedure here
	IF @Account <> ''
		BEGIN
			SELECT A.T$DSCA FROM FactoryLoading.dbo.TTCMCS044180 AS A
			WHERE A.T$DSCA NOT IN (SELECT B.OEM FROM dbo.Cost_Sheet_Query_CS_OEM_Authority AS B WHERE ACCOUNT = @Account)
			ORDER BY A.T$DSCA 
		END
	ELSE
		BEGIN
			SELECT A.T$DSCA FROM FactoryLoading.dbo.TTCMCS044180 AS A ORDER BY A.T$DSCA 
		END
END


GO

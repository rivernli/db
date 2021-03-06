USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_AutoUpdate_ProjectList]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Sheet_Query_AutoUpdate_ProjectList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE Cost_Sheet_Query_ProjectList

	INSERT INTO Cost_Sheet_Query_ProjectList

	SELECT  DISTINCT   T$PJNO,T$APRJ
	FROM         dbo.Cost_Sheet_Query_TFSBOM400180
	ORDER BY T$PJNO,T$APRJ
END

GO

USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_Cost_Sheet_Details]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_Cost_Sheet_Details]
@Project	NVARCHAR(10),
@Version	NVARCHAR(5)
AS
BEGIN

	SET NOCOUNT ON;

	SET @Project = ISNULL(@Project,'')
	SET @Version = ISNULL(@Version,'')
	SET @Project = LTRIM(RTRIM(@Project))
	SET @Version = LTRIM(RTRIM(@Version))

    -- Insert statements for procedure here
	SELECT 
		T$PJNO,
		T$SERN,
		T$SQNO,
		T$META,
		CAST(T$COSP AS DECIMAL(18,4)) as T$COSP,
		CAST(T$COSU AS DECIMAL(18,4)) as T$COSU,
		CAST(T$COSS AS DECIMAL(18,4)) as T$COSS,
		CAST(T$COPR AS DECIMAL(18,4)) as T$COPR
	FROM FactoryLoading.dbo.TFSBOM401180 WHERE T$PJNO = @Project AND T$SERN = @Version order by T$SQNO asc
END

GO

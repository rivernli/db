USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Automatically_Process_Daily]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[VI_Report_sp_Automatically_Process_Daily]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE VI_Report_Shipped_All_Daily

	INSERT INTO VI_Report_Shipped_All_Daily (Site,Plant,Day,Amount)
	SELECT LOC,'',CONVERT(VARCHAR(10),SHDate,120),SUM(SHDols)
	FROM VI_Report_Shipped_All
	WHERE Loc='DIS'
		AND SHDate IS NOT NULL
	GROUP BY Loc,CONVERT(VARCHAR(10),SHDate,120)

	INSERT INTO VI_Report_Shipped_All_Daily (Site,Plant,Day,Amount)
	SELECT LOC,'',CONVERT(VARCHAR(10),SHDate,120),SUM(SHDols)
	FROM VI_Report_Shipped_All
	WHERE Loc='CHI'
		AND Plant<>'NA'
		AND SHDate IS NOT NULL
	GROUP BY Loc,CONVERT(VARCHAR(10),SHDate,120)

	INSERT INTO VI_Report_Shipped_All_Daily (Site,Plant,Day,Amount)
	SELECT LOC,'',CONVERT(VARCHAR(10),SHDate,120),SUM(SHDols)
	FROM VI_Report_Shipped_All
	WHERE Loc='GER'
		AND SHDate IS NOT NULL
	GROUP BY Loc,CONVERT(VARCHAR(10),SHDate,120)

	INSERT INTO VI_Report_Shipped_All_Daily (Site,Plant,Day,Amount)
	SELECT LOC,'',CONVERT(VARCHAR(10),SHDate,120),SUM(SHDols)
	FROM VI_Report_Shipped_All
	WHERE Loc='SAO'
		AND SHDate IS NOT NULL
	GROUP BY Loc,CONVERT(VARCHAR(10),SHDate,120)

	INSERT INTO VI_Report_Shipped_All_Daily (Site,Plant,Day,Amount)
	SELECT LOC,'',CONVERT(VARCHAR(10),SHDate,120),SUM(SHDols)
	FROM VI_Report_Shipped_All
	WHERE Loc='NFD'
		AND SHDate IS NOT NULL
	GROUP BY Loc,CONVERT(VARCHAR(10),SHDate,120)

--	INSERT INTO VI_Report_Shipped_All_Daily (Site,Plant,Day,Amount)
--	SELECT LOC,Plant,CONVERT(VARCHAR(10),SHDate,120),SUM(SHDols)
--	FROM VI_Report_Shipped_All
--	WHERE Loc='CHI'
--		AND Plant<>'NA'
--		AND SHDate IS NOT NULL
--	GROUP BY Loc,Plant,CONVERT(VARCHAR(10),SHDate,120)

END





GO

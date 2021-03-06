USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_DailyIncoming_Total]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_DailyIncoming_Total]
	-- Add the parameters for the stored procedure here
	@Plant VARCHAR(50),
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ISNULL(SUM(Amount),0) AS Amount
	FROM GlobalViewReport_DailyIncoming
	WHERE Plant=@Plant
		AND Day BETWEEN @DateFrom AND @DateTo
	GROUP BY Plant
END
GO

USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Daily_OEM_By_Plant]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Daily_OEM_By_Plant]
	@Date DATETIME,
	@Type VARCHAR(50),
	@Plant VARCHAR(50)
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SET @Plant=(CASE WHEN @Plant='B1' THEN 'P2' WHEN @Plant='B2F' THEN '2F' WHEN @Plant='VVI' THEN 'HK' ELSE @Plant END)
	SELECT *
	FROM (
			SELECT a.T$DESC AS Type,a.T$CSGS AS OEM,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT=@Plant AND b.T$TRDT=@Date 
				)) AS Total
			FROM TFSOLP121180 a
			WHERE a.T$TRDT =@Date
				AND a.T$PLNT=@Plant
			GROUP BY a.T$DESC,a.T$CSGS
		) c
	WHERE Type=@Type
		AND Total<>0
	ORDER BY  c.Total DESC,c.OEM ASC


END
GO

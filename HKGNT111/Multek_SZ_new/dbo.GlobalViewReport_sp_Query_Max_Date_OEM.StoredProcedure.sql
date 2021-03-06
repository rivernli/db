USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Max_Date_OEM]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Max_Date_OEM]
	@Type VARCHAR(50)
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT MAX(DATE)
	FROM (
			SELECT a.T$DESC AS Type,a.T$CSGS AS OEM,a.T$TRDT AS DATE,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='P2' 
				)) AS B1,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='2F' 
				)) AS B2F,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B3' 
				)) AS B3,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B4' 
				)) AS B4,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='B5' 
				)) AS B5,
				CONVERT(INT,(
					SELECT CASE WHEN a.T$DESC='Price Change' THEN ISNULL(SUM(T$MAMN),0)-ISNULL(SUM(T$MAMT),0) ELSE ISNULL(SUM(T$MAMT),0) END FROM TFSOLP121180 b WHERE b.T$DESC=a.T$DESC AND b.T$CSGS=a.T$CSGS AND b.T$PLNT='HK' 
				)) AS VVI
			FROM TFSOLP121180 a
			GROUP BY a.T$DESC,a.T$CSGS,a.T$TRDT
		) c
	WHERE (B1<>0 OR B2F<>0 OR B3<>0 OR B4<>0 OR B5<>0 OR VVI<>0) 
		AND Type=@Type


END
GO

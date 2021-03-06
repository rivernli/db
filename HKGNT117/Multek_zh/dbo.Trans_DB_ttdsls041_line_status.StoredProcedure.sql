USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Trans_DB_ttdsls041_line_status]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Trans_DB_ttdsls041_line_status] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempSales041') AND TYPE = 'U')
		DROP TABLE #tempSales041
	
	SELECT	T$ORNO,
			T$PONO,
			(CASE T$SFLG WHEN 0 THEN '' WHEN 1 THEN 'ON HOLD' WHEN 2 THEN 'CANCEL' WHEN 3 THEN 'RELEASE' END) AS T$SFLG,
			(CASE T$SSTA WHEN 1 THEN 'YES' WHEN 2 THEN 'NO' ELSE '' END ) AS T$SSTS 
	INTO #tempSales041
	FROM OPENQUERY(AS1P1,'SELECT A.T$ORNO,A.T$PONO,A.T$SFLG,A.T$SSTA FROM BAAN.TTDSLS041180 A,BAAN.TFSOLP100180 B WHERE A.T$ORNO = B.T$ORNO AND A.T$PONO = B.T$PONO AND A.T$PONO > 999')

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'Multek_zh.dbo.ttdsls041180_shipment_Status') AND TYPE = 'U')
		BEGIN
			TRUNCATE TABLE Multek_zh.dbo.ttdsls041180_shipment_Status
			INSERT INTO Multek_zh.dbo.ttdsls041180_shipment_Status
			SELECT T$ORNO,T$PONO,T$SSTS  FROM #tempSales041
		END
	ELSE
		BEGIN
			SELECT T$ORNO,T$PONO,T$SSTS INTO Multek_zh.dbo.ttdsls041180_shipment_Status FROM #tempSales041
		END
END

GO

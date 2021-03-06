USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_B2B_NFD]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_B2B_NFD]
	@BU VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
/****** Script for SelectTopNRows command from SSMS  ******/
	SELECT a.*,'W'+(CASE WHEN b.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.FiscalWeek)+'FY'+RIGHT(CONVERT(CHAR(4),b.FiscalYear),2) AS WeekDesc
	FROM nfdb2b a,Calendar b
	WHERE a.Date=b.calenderDate
		AND BU=@BU
	ORDER BY a.BU,a.Date ASC
  
END
GO

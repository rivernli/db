USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Initial_Materia_Cost_Sheet]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Initial_Materia_Cost_Sheet]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE Cost_Sheet_Query_TFSBOM400180
	INSERT INTO Cost_Sheet_Query_TFSBOM400180
	SELECT * FROM HKGNT117.Multek_ZH.dbo.Cost_Sheet_Query_TFSBOM400180
	UPDATE dbo.Cost_Sheet_Query_TFSBOM400180
	SET T$PJNO=LEFT(T$PJNO,8)

END
GO

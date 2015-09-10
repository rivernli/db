USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Update_RMA]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Update_RMA]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--UPDATE TFSOLP109180 SET T$AMNT=ABS(T$AMNT)
	UPDATE TFSOLP109180 SET T$AMNT=(CASE WHEN T$AMNT<0 THEN ABS(T$AMNT) ELSE T$AMNT*-1.0000 END)
	
END
GO

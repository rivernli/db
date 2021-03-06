USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_DailyIncoming]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_DailyIncoming]
	-- Add the parameters for the stored procedure here
	@Plant VARCHAR(50),
	@Day DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(
				SELECT *
				FROM GlobalViewReport_DailyIncoming
				WHERE Plant=@Plant
					AND Day=@Day
			)
		BEGIN
				SELECT *
				FROM GlobalViewReport_DailyIncoming
				WHERE Plant=@Plant
					AND Day=@Day
		END
	ELSE
		BEGIN
			SELECT @Plant AS Plant,@Day AS Day,0 AS Amount
		END
END
GO

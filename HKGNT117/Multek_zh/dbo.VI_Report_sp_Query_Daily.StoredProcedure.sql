USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_Daily]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[VI_Report_sp_Query_Daily]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Day DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Site='Global'
	BEGIN
		-- Insert statements for procedure here
		IF EXISTS(
					SELECT *
					FROM VI_Report_Shipped_All_Daily
					WHERE Day=@Day
				)
			BEGIN
					SELECT *
					FROM VI_Report_Shipped_All_Daily
					WHERE Day=@Day
			END
		ELSE
			BEGIN
				SELECT @Site AS Site,@Plant AS Plant,@Day AS Day,0 AS Amount
			END
	END

	ELSE 
		-- Insert statements for procedure here
		IF EXISTS(
					SELECT *
					FROM VI_Report_Shipped_All_Daily
					WHERE Site=@Site
						AND Plant=@Plant
						AND Day=@Day
				)
			BEGIN
					SELECT *
					FROM VI_Report_Shipped_All_Daily
					WHERE Site=@Site
						AND Plant=@Plant
						AND Day=@Day
			END
		ELSE
			BEGIN
				SELECT @Site AS Site,@Plant AS Plant,@Day AS Day,0 AS Amount
			END
END 
GO
